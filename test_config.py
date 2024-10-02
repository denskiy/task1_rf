import os
from dotenv import load_dotenv

load_dotenv()

SERVER = os.getenv('SERVER')
DATABASE = os.getenv('DATABASE')
UID = os.getenv('UID')
PWD = os.getenv('PWD')

CONN_STR = f"DRIVER={{ODBC Driver 17 for SQL Server}};\
SERVER={SERVER};DATABASE={DATABASE};UID={UID};PWD={PWD}"
