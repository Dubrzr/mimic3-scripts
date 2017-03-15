import datetime

from file_utils import *

record_fields = {
    'record_id': int,
    'subject_id': int,
    'starttime': str,
    'endtime': str,
    'starting_hadm': int,
    'ending_hadm': int,
    'starting_icustay': int,
    'ending_icustay': int,
    'hadmmatch': str,
    'icumatch': str,
    'rih': int,
    'rii': int,
    'hadm_overlap': float,
    'icustay_overlap': float,
    'comments': list
}
entry_fields = {
    'record_id': int,
    'segment_index': int,
    'type': str,
    'start_date': datetime.datetime,
    'end_date': datetime.datetime,
    'nsamp': int,
    'nsig': int,
    'fs': float,
    'fmt': list,
    'sampsperframe': list,
    'skew': list,
    'byteoffset': list,
    'gain': list,
    'units': list,
    'baseline': list,
    'initvalue': list,
    'signame': list,
    'comments': list
}

def get_patients(filename):
    if file_exists(filename):
        return read_json(filename)

    patients = {}

    nb_patient = 0
    nb_file = 0
    for name in os.listdir(dir_path):
        subdir_path = dir_path + name
        patients[name] = []
        nb_patient += 1
        tmp = {}
        for subname in os.listdir(subdir_path):
            if subname.endswith('.json'):
                continue
            sn = subname[:-4]
            if not sn in tmp:
                patients[name].append(sn)
                tmp[sn] = True
        nb_file += len(patients[name])

    print(nb_patient, 'patients,', nb_file, 'files')

    write_json(filename, patients)
    return patients
