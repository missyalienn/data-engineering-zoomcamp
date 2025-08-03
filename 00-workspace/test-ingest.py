
# TODO: finish argument parsing and test that data download works 
# Review project's ingestion logic and write it here in your own words. Test it 

import os 
import argparse

from time import time 

import pandas as pd 
from sqlalchemy import create_engine

def main(params): 
    user= params.user
