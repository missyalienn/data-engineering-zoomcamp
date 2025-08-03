
import os 
import argparse

from time import time 

import pandas as pd 
from sqlalchemy import create_engine

url = "https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"
csv_name = url.split("/")[-1]
df = pd.read_csv(csv_name, nrows=100)
pd.io.sql.get_schema(df, name='yellow_taxi_data')

# Convert pickup and dropoff columns from text to datetime objects
df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

from sqlalchemy import create_engine
engine = create_engine('postgresql://root:root@localhost:5432/nyc_taxi')

df_iter = pd.read_csv(csv_name, iterator= True, chunksize=100000)
df = next(df_iter)

#df.head(0).to_sql(name= 'yellow_taxi_data', con= engine, if_exists= 'replace')
#df.to_sql(name= 'yellow_taxi_data', con= engine, if_exists= 'append')

for i, df in enumerate(df_iter): 
    
    start_t = time()

    df.to_sql(name='yellow_taxi_data', con=engine, if_exists= 'append')

    end_t = time()
    print(f'Ingested chunk {i +1}, took {end_t - start_t:.3f}seconds')


