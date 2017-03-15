import copy
import datetime
import glob
import numpy
import os
import pandas

from wfdb_helpers import wfdb_read_header

from date_utils import *
from file_utils import *
from mimic_utils import *


dir_path = 'data/mimic3wdb/'
input_matched_csv = 'matched.csv'
tmp_patients_file = 'patients_files.json'
matched_df = pandas.read_csv(input_matched_csv, delimiter=',')

output_record_csv = 'wfr.csv'
output_entry_csv = 'wfe.csv'

record_id = 0
def create_csv(patients=None, sep=',', collecton_sep='|'):
    map_s_file = {}
    if patients is None:
        patients = get_patients(tmp_patients_file)

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

            if isinstance(v, datetime.datetime):
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
                
                start = get_datetime(header)

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

create_csv()