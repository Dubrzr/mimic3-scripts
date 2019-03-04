import os
import re


def listdirfullpath(path):
    return [os.path.join(path, e) for e in os.listdir(path)]

def iter_mimic_waveforms(mimic_dir):
    for p0x in sorted(listdirfullpath(mimic_dir)):
        if not os.path.isfile(p0x):
            for p00xxxx in sorted(listdirfullpath(p0x)):
                for fn in sorted(listdirfullpath(p00xxxx)):
                    yield fn

reg = re.compile('.*p0\d{5}-\d{4}-\d{2}-\d{2}-\d{2}-\d{2}.*.hea')
def is_record_file(path):
    return reg.match(path)
                    
reg_w = re.compile('.*p0\d{5}-\d{4}-\d{2}-\d{2}-\d{2}-\d{2}.hea')
def is_record_w_file(path):
    return reg_w.match(path)

reg_n = re.compile('.*p0\d{5}-\d{4}-\d{2}-\d{2}-\d{2}-\d{2}n.hea')
def is_record_n_file(path):
    return reg_n.match(path)

def get_record_data_files(path):
    directory = '/'.join(path.split('/')[:-1])
    with open(path) as ff:
        contents = ff.read()
    result = []
    for line in contents.split('\n'):
        f = line.split(' ')[0]
        if ('n' in f or '_' in f) and not 'layout' in f and not 'p00' in f:
            result.append(os.path.join(directory, f.replace('.dat', '')))
    return sorted(list(set(result)))