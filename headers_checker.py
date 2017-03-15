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

record_id = 0
def check_headers(patients=None):
    if patients is None:
        patients = get_patients(tmp_patients_file)

    nb_h_nomatch_n = 0
    nb_h_nomatch_w = 0
    nb_h_nomatch = []

    incorrect_date_n_s = 0
    incorrect_date_n_e = 0
    incorrect_date_w_s = 0
    incorrect_date_w_e = 0
    incorrect_date = []
    for patient, files in patients.items():

        files = sorted(files)
        s_files = [f for f in files if 's' in f] # sxxxxx-date{n}.hea


        subdir_path = dir_path + patient
        for s_file in s_files:
            type_wn = 'n' if 'n' in s_file else 'w'

            header = wfdb_read_header(open(subdir_path + '/' + s_file + '.hea', 'r'))
            
            if type_wn == 'n':
                # Only a single .dat file
                assert len(set(header['filename'])) == 1 # unique filenameeader['comments'])
                assert header['nseg'] == 1

                # Extract datetime
                start = get_datetime(header)
                end = start + get_timedelta_from_nb_samp(header['nsamp'], header['fs'])

                tmp = patient + start.strftime('-%Y-%m-%d-%H-%Mn')
                if s_file != tmp:
                    print('Header file contents does not match filename: {} VS {}'.format(s_file, tmp))
                    nb_h_nomatch_n += 1
                    nb_h_nomatch.append(s_file)

                if start.year < 2080 or start.year > 2220:
                    print('Incorrect start date found in header contents: 2080 < {} < 2220 ({})'.format(start.year, s_file))
                    incorrect_date_n_s += 1
                    incorrect_date.append(s_file)

            elif type_wn == 'w':
                # Many .dat files, we need to iterate over each segment

                start = get_datetime(header)

                tmp = patient + start.strftime('-%Y-%m-%d-%H-%M')
                if s_file != tmp:
                    print('Header file contents does not match filename: {} VS {}'.format(s_file, tmp))
                    nb_h_nomatch_w += 1
                    nb_h_nomatch.append(s_file)

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


                if start.year < 2080 or start.year > 2220:
                    print('Incorrect start date found in header contents: 2080 < {} < 2220 ({})'.format(start.year, s_file))
                    incorrect_date_w_s += 1
                    incorrect_date.append(s_file)

    print('[' + ','.join(nb_h_nomatch) + ']')
    print('[' + ','.join(incorrect_date) + ']')

    print('Found {} numerics headers with a date that is not matching header contents'.format(nb_h_nomatch_n))
    print('Found {} numerics headers with invalid start dates (2080 < not here < 2220)'.format(incorrect_date_n_s))
    print('Found {} numerics headers with invalid end dates (2080 < not here < 2220)'.format(incorrect_date_n_e))
    print('Found {} waveform headers with a date that is not matching header contents'.format(nb_h_nomatch_w))
    print('Found {} waveform headers with invalid start dates (2080 < not here < 2220)'.format(incorrect_date_w_s))
    print('Found {} waveform headers with invalid end dates (2080 < not here < 2220)'.format(incorrect_date_w_e))

check_headers()