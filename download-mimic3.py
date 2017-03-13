import sys
from file_utils import *
import lazyjson
from bs4 import BeautifulSoup
import requests
import datetime
import multiprocessing

sys.setrecursionlimit(100000)


physioneturl = "https://physionet.org/physiobank/database/mimic3wdb/matched"
db_file = 'mimic3wdb.json'
output = 'data/mimic3wdb'

create_folder(output)

if not file_exists(db_file):
    create_file(db_file, contents='{}')
db = lazyjson.File(db_file)


def list_page(url, string_red=9999999, pre_idx=0):
    print(url)
    page = requests.get(url)
    soup = BeautifulSoup(page.text, 'html.parser')
    tmp = list(map(lambda e: e.string[:string_red], soup.find_all('pre')[pre_idx].find_all('a')))

    return tmp


folders = list_page(physioneturl, -1, 3)[9:]
print('Got {} folders'.format(len(folders)))


files = list_page(physioneturl + '/' + folders[0])[5:]
print('Got {} files'.format(len(files)))
print(files)


def process_url(f, file_url, file_path):
    download_file(file_url, file_path)
    h = sha256_checksum(file_path)
    s = file_size(file_path)
    return f, h, s

pool = multiprocessing.Pool(processes=16)
def download_folder(name):
    dir_path = output + '/' + name

    create_folder(dir_path)
    db_sub = dir_path + '/' + name + '.json'
    if not file_exists(db_sub):
        create_file(db_sub, contents='{}')
    db_sub = lazyjson.File(db_sub)

    #if 'done' in db_sub:
    #    return 0, 0

    dir_url = physioneturl + '/' + name

    files_to_dl = []
    for f in list_page(dir_url)[5:]:
        if f.endswith('hea') or f.endswith('dat'):
            file_url = dir_url + '/' + f
            file_path = dir_path + '/' + f

            # Check local existance
            if file_exists(file_path):
                if f in db_sub:
                    continue

            delete_file(file_path)
            files_to_dl.append((f, file_url, file_path))

    try:
        res = pool.starmap(process_url, files_to_dl)
    except:
        for _, _, fp in files_to_dl:
            delete_file(fp)
        raise
    total_size = 0
    total_dl = 0
    for f, h, s in res:
        total_size += s
        db_sub[f] = {
            'hash': h,
            'size': s
        }
        total_dl += 1
    db_sub['done'] = True
    return total_size, total_dl



size = 0
for k in folders:
    start = datetime.datetime.now()
    print('Downloading {}...'.format(k), end='')
    s, dl = download_folder(k)
    elapsed = datetime.datetime.now() - start
    total_sec = elapsed.seconds + elapsed.microseconds / 1000000
    print(' Done! {} files downloaded/updated ({} in {}s: {}/s)'.format(
        dl,
        sizeof_fmt(s),
        total_sec,
        sizeof_fmt(s/total_sec)
    ))
