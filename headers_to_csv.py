import copy
import glob
import numpy
import pandas
import os
from file_utils import *
import wfdb
from wfdb_helpers import wfdb_read_header
from datetime import datetime, timedelta


dir_path = 'data/mimic3wdb/'
input_matched_csv = 'matched.csv'

tmp_patients_file = 'patients_files.json'

output_record_csv = 'wfr.csv'
output_entry_csv = 'wfe.csv'
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
    'start_date': datetime,
    'end_date': datetime,
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


def get_patients(filename=tmp_patients_file):
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


def get_datetime(header, dt=None):
    basetime = header['basetime']
    basedate = header['basedate']
    try:
        if basedate != '':
            day, month, year = [int(e) for e in basedate.split('/')]
        else:
            day, month, year = dt.day, dt.month, dt.year

        tmp = basetime.split('.')
        if len(tmp) == 1:
            hms = tmp[0]
            ms = 0
        else:
            hms, ms = tmp
        tmp = hms.split(':')
        if len(tmp) == 2:
            if dt is None:
                hour = 0
            else:
                hour = dt.hour
            minutes, seconds = [int(e) for e in tmp]
        else:
            hour, minutes, seconds = [int(e) for e in tmp]
        milliseconds = int(ms)
        return datetime(
            year=year,
            month=month,
            day=day,
            hour=hour,
            minute=minutes,
            second=seconds,
            microsecond=milliseconds*1000)
    except ValueError as ve:
        print(f'Error with basetime="{basetime}" and basedate="{basedate}": {ve}')
        raise ve


def get_timedelta_from_nb_samp(nsampseg, frequency):
    seconds = nsampseg / frequency
    s, ms = int(seconds), seconds % 1
    return timedelta(seconds=s, milliseconds=ms)


def str_from_datetime(dt):
    return dt.strftime("%Y-%m-%d %H:%M:%S")


matched_df = pandas.read_csv(input_matched_csv, delimiter=',')

record_id = 0
def create_csv(patients, sep=',', collecton_sep='|'):
    map_s_file = {}
    if patients is None:
        patients = get_patients()

    # Create or overwrite output files
    wfr = open(output_record_csv, 'w+')
    wfe = open(output_entry_csv, 'w+')

    # Write CSV headers
    for e, _ in record_fields.items():
        wfr.write('{}{}'.format(e, sep))
    wfr.write('\n')
    for e, _ in entry_fields.items():
        wfe.write('{}{}'.format(e, sep))
    wfe.write('\n')

    def write_to(wf, fields, **kwargs):
        for e, k in fields.items():
            v = kwargs[e]
            if not isinstance(v, k):
                if isinstance(v, pandas.core.series.Series):
                    tmp = v.as_matrix()
                    if len(tmp) > 0:
                        v = tmp[0]
                    else:
                        v = None
                else:
                    try:
                        v = k(v)
                    except ValueError:
                        v = ''

            if isinstance(v, datetime):
                v = str_from_datetime(v)
            elif isinstance(v, list):
                v = collecton_sep.join([str(b) for b in v])

            wf.write('{}{}'.format(v, sep))
        wf.write('\n')


    def get_or_create_record(type_wn, patient, s_file, wfr, comments):
        if s_file in map_s_file:
            return map_s_file[s_file]
        
        global record_id
        record_id += 1
        map_s_file[s_file] = record_id

        record = patient + '/' + s_file
        if type_wn == 'n':
            record += 'n'
        matched_entry = matched_df.loc[matched_df.record==record]
        assert int(matched_entry['subject_id']) == int(patient[1:])
        if 'comments' in matched_entry:
            del matched_entry['comments']
        write_to(wfr, record_fields, **matched_entry, record_id=map_s_file[s_file], comments=comments)

        return map_s_file[s_file]

    for patient, files in patients.items():

        files = sorted(files)
        s_files = [f for f in files if 's' in f] # sxxxxx-date{n}.hea

        subdir_path = dir_path + patient
        for s_file in s_files:
            type_wn = 'n' if 'n' in s_file else 'w'

            header = wfdb_read_header(open(subdir_path + '/' + s_file + '.hea', 'r'))
            
            if 'n' in s_file:
                tmp = s_file[:-1]
            else:
                tmp = s_file
            record_id = get_or_create_record(type_wn, patient, tmp, wfr, header['comments'])
            
            start = get_datetime(header)
            if type_wn == 'n':
                # Only a single .dat file
                segment_index = -1
                assert len(set(header['filename'])) == 1 # unique filenameeader['comments'])
                assert header['nseg'] == 1

                # Extract datetime
                start_date = get_datetime(header)
                end_date = start_date + get_timedelta_from_nb_samp(header['nsamp'], header['fs'])

                # Write entry
                header['record_id'] = record_id
                header['segment_index'] = -1
                header['type'] = type_wn
                header['start_date'] = start_date
                header['end_date'] = end_date
                write_to(wfe, entry_fields, **header)

            elif type_wn == 'w':
                # Many .dat files, we need to iterate over each segment
                
                nsampseg_from_start = 0
                for i, segment in enumerate(header['filename']):
                    nsampseg = header['nsampseg'][i]

                    if 'layout' in segment:
                        assert nsampseg == 0
                        continue

                    if segment == '~':
                        nsampseg_from_start += nsampseg
                        continue
                    segment_header = wfdb_read_header(open(subdir_path + '/' + segment + '.hea', 'r'))

                    frequency = segment_header['fs']

                    # Extract datetime
                    supposed_start = start + get_timedelta_from_nb_samp(nsampseg_from_start, frequency)
                    nsampseg_from_start += nsampseg
                    supposed_end = start + get_timedelta_from_nb_samp(nsampseg_from_start, frequency)

                    if segment_header['nsamp'] != nsampseg:
                        print(segment_header['nsamp'], nsampseg)
                        exit(1)

                    start_date = get_datetime(segment_header, supposed_start)
                    end_date = start_date + get_timedelta_from_nb_samp(nsampseg, frequency)
                    if start_date.day != supposed_start.day:
                        print('Different days:', start_date, supposed_start, 'aborting...')
                        exit(1)
                    if end_date.day != supposed_end.day:
                        print('Different days:', end_date, supposed_end, 'aborting...')
                        exit(1)

                    segment_header['record_id'] = record_id
                    segment_header['segment_index'] = int(segment[-4:])
                    segment_header['type'] = type_wn
                    segment_header['start_date'] = start_date
                    segment_header['end_date'] = end_date
                    write_to(wfe, entry_fields, **segment_header)

create_csv(None)