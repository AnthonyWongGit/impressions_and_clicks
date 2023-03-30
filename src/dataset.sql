DROP DATABASE IF EXISTS dataset_test;

CREATE DATABASE dataset_test;

\c dataset_test

CREATE TABLE dataset1 (
    user_id VARCHAR,
    date DATE NOT NULL,
    hour VARCHAR NOT NULL,
    impressions INTEGER NOT NULL,
    clicks INTEGER NOT NULL,
    video_midpoint INTEGER NOT NULL,
    video_complete_views INTEGER NOT NULL,
    asset VARCHAR,
    conversions INTEGER NOT NULL
);

CREATE TABLE dataset2 (
    user_id VARCHAR,
    gender VARCHAR CHECK (gender IN ('M', 'F', 'U', NULL)),
    age INTEGER,
    device_type VARCHAR,
    os VARCHAR,
    nrs_grade VARCHAR,
    date_collected DATE
);

\copy dataset1 from 'data/dataset1.csv' delimiter ',' CSV HEADER;
\copy dataset2 from 'data/dataset2.csv' delimiter ',' CSV HEADER;