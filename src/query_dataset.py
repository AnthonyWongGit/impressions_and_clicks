from sqlalchemy import create_engine, text
import json

# Establish database connection
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

    # Unique users in dataset1
    dataset1_users_query = connection.execute(text(
    '''
        SELECT COUNT(DISTINCT user_id), COUNT(user_id) 
        FROM dataset1;
    '''))
    dataset1_unique_users, dataset1_total_users = dataset1_users_query.fetchone()
    print(f'There are {dataset1_unique_users} unique users out of {dataset1_total_users} in dataset1')

    # Unique users in dataset2
    dataset2_users_query = connection.execute(text(
    '''
        SELECT COUNT(DISTINCT user_id), COUNT(user_id) 
        FROM dataset2;
    '''))
    dataset2_unique_users, dataset2_total_users = dataset2_users_query.fetchone()
    print(f'There are {dataset2_unique_users} unique users out of {dataset2_total_users} in dataset2')

    # Unique users in dataset2 matching the target audience
    target_audience_query = connection.execute(text(
    '''
        SELECT COUNT(DISTINCT user_id)
        FROM (
            SELECT *
            FROM dataset2
            WHERE age >= 55
            AND nrs_grade IN ('A', 'B')
        ) AS target_audience
    '''))
    matching_targets = target_audience_query.fetchone()[0]
    print(f'There are {matching_targets} unique users matching the target audience, which is {round(matching_targets / dataset2_unique_users * 100, 2)}% of the total unique users')

    