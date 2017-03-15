from datetime import datetime, timedelta

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
