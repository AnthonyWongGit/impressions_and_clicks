from sqlalchemy import create_engine, text
import json

with open('db_credentials.json') as f:
    credentials = json.load(f)
    database = credentials['database']
    username = credentials['username']
    password = credentials['password']
    host = credentials['host']
    port = credentials['port']

engine = create_engine(f'postgresql://{username}:{password}@{host}:{port}/{database}')

with engine.connect() as connection:
    connection.execution_options(isolation_level="AUTOCOMMIT")

    result = connection.execute(text('SELECT * FROM dataset1'))
    print(result.fetchone())