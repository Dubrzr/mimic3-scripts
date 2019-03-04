# Easily explore MIMIC3 waveform metadata

## Requirements

```
pip install -r requirements.txt
```

Postgresql with a dedicated database for this project.

## Run Jupyter to test/extend the code

```
jupyter lab
```

## Get the data

There are two ways of getting queryable metadata from the waveforms:

1. Download all metadata files from mimic waveforms and run the code in `hea_to_sql_db.ipynb` notebook
2. Use the `mimic.pg_dump` file to load the postgres database using `psql database_name < mimic.pg_dump`

You can then query waveforms metadata in the notebook.


/bin/bash: q: command not found
