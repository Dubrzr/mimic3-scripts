import os
from pathlib import Path
import requests
import hashlib
import json

def sizeof_fmt(num, suffix='B'):
    for unit in ['','Ki','Mi','Gi','Ti','Pi','Ei','Zi']:
        if abs(num) < 1024.0:
            return "%3.1f%s%s" % (num, unit, suffix)
        num /= 1024.0
    return "%.1f%s%s" % (num, 'Yi', suffix)


def file_exists(path):
    return os.path.isfile(path)

def folder_exists(path):
    return os.path.isdir(path)

def create_folder(path):
    if not os.path.exists(path):
        os.makedirs(path)

def clean_folder(path):
    if not folder_exists(path):
        return
    for the_file in os.listdir(path):
        file_path = os.path.join(path, the_file)
        if os.path.isfile(file_path):
            os.unlink(file_path)

def delete_folder(path):
    if not folder_exists(path):
        return
    rmtree(path)

def create_file(path, contents=None):
    if file_exists(path):
        return
    Path(path).touch()
    if contents is not None:
        with open(path, 'w') as f:
            f.write(contents)

def delete_file(path, response=None):
    if not file_exists(path):
        return
    os.remove(path)

def file_size(path):
    stat_info = os.stat(path)
    return stat_info.st_size

def sha256_checksum(filename, block_size=65536):
    sha256 = hashlib.sha256()
    with open(filename, 'rb') as f:
        for block in iter(lambda: f.read(block_size), b''):
            sha256.update(block)
    return sha256.hexdigest()

def download_file(url, path):
    r = requests.get(url, stream=True)
    if r.status_code == 200:
        with open(path, 'wb') as f:
            for chunk in r.iter_content(1024):
                f.write(chunk)

def write_json(filepath, contents):
    with open(filepath, 'w') as f:
        json.dump(contents, f)

def read_json(filepath):
    with open(filepath, 'r') as f:
        data = json.load(f)
    return data