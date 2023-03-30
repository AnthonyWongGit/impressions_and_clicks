\c dataset_test

DROP TABLE IF EXISTS result_table;

CREATE TABLE result_table (
    asset VARCHAR NOT NULL,
    reach FLOAT,
    frequency FLOAT,
    ctr FLOAT,
    vtr FLOAT,
    CR FLOAT
);

INSERT INTO result_table (asset) VALUES 
    ('Asset1'),
    ('Asset2'),
    ('Asset3'),
    ('Asset4'),
    ('Asset5');

DROP TABLE IF EXISTS target_audience_user_id;

\! echo "Total unique users:";
SELECT COUNT(DISTINCT user_id) 
FROM dataset2;

\! echo "Total unique users matching target audience characteristics:";
SELECT DISTINCT user_id 
INTO target_audience_user_id 
FROM (
    SELECT * 
    FROM dataset2 
    WHERE age >= 55 
    AND nrs_grade IN ('A', 'B')
) AS target_audience;

SELECT COUNT(*) 
FROM target_audience_user_id;

\! echo "Percentage of unique users that matched target audience characteristics:";
SELECT 
    CAST((SELECT COUNT(DISTINCT user_id) 
        FROM (
            SELECT * 
            FROM dataset2 
            WHERE age >= 55 
            AND nrs_grade IN ('A', 'B')
        ) AS target_audience) 
    AS float) /
    CAST((SELECT COUNT(DISTINCT user_id) 
        FROM dataset2) 
    AS float) * 100
AS result;

\! echo "Updating Reach for Asset1";
UPDATE result_table 
SET reach = (
    SELECT COUNT(DISTINCT user_id) 
    FROM dataset1 
    WHERE user_id IN (
        SELECT (user_id) 
        FROM target_audience_user_id) 
        AND asset = 'Asset1') 
WHERE asset = 'Asset1';


\! echo "Updating Reach for Asset2";
UPDATE result_table 
SET reach = (
    SELECT COUNT(DISTINCT user_id) 
    FROM dataset1 
    WHERE user_id IN (
        SELECT (user_id) 
        FROM target_audience_user_id) 
        AND asset = 'Asset2') 
WHERE asset = 'Asset2';

\! echo "Updating Reach for Asset3";
UPDATE result_table 
SET reach = (
    SELECT COUNT(DISTINCT user_id) 
    FROM dataset1 
    WHERE user_id IN (
        SELECT (user_id) 
        FROM target_audience_user_id) 
        AND asset = 'Asset3') 
WHERE asset = 'Asset3';

\! echo "Updating Reach for Asset4";
UPDATE result_table 
SET reach = (
    SELECT COUNT(DISTINCT user_id) 
    FROM dataset1 
    WHERE user_id IN (
        SELECT (user_id) 
        FROM target_audience_user_id) 
        AND asset = 'Asset4') 
WHERE asset = 'Asset4';

\! echo "Updating Reach for Asset5";
UPDATE result_table 
SET reach = (
    SELECT COUNT(DISTINCT user_id) 
    FROM dataset1 
    WHERE user_id IN (
        SELECT (user_id) 
        FROM target_audience_user_id) 
        AND asset = 'Asset5') 
WHERE asset = 'Asset5';

\! echo "Updating Frequency for Asset1";
UPDATE result_table
SET frequency = (
    SELECT
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset1') 
        AS float) /
        CAST((SELECT COUNT(DISTINCT user_id) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset1')
        AS float)
    AS result
)
WHERE asset = 'Asset1';

\! echo "Updating Frequency for Asset2";
UPDATE result_table
SET frequency = (
    SELECT
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset2') 
        AS float) /
        CAST((SELECT COUNT(DISTINCT user_id) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset2')
        AS float)
    AS result
)
WHERE asset = 'Asset2';

\! echo "Updating Frequency for Asset3";
UPDATE result_table
SET frequency = (
    SELECT
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset3') 
        AS float) /
        CAST((SELECT COUNT(DISTINCT user_id) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset3')
        AS float)
    AS result
)
WHERE asset = 'Asset3';

\! echo "Updating Frequency for Asset4";
UPDATE result_table
SET frequency = (
    SELECT
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset4') 
        AS float) /
        CAST((SELECT COUNT(DISTINCT user_id) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset4')
        AS float)
    AS result
)
WHERE asset = 'Asset4';

\! echo "Updating Frequency for Asset5";
UPDATE result_table
SET frequency = (
    SELECT
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset5') 
        AS float) /
        CAST((SELECT COUNT(DISTINCT user_id) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset5')
        AS float)
    AS result
)
WHERE asset = 'Asset5';

\! echo "Updating CTR for Asset1";
UPDATE result_table 
SET ctr = (
    SELECT
        CAST((SELECT SUM(clicks) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset1') 
        AS float) /
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset1') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset1';

\! echo "Updating CTR for Asset2";
UPDATE result_table 
SET ctr = (
    SELECT
        CAST((SELECT SUM(clicks) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset2') 
        AS float) /
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset2') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset2';

\! echo "Updating CTR for Asset3";
UPDATE result_table 
SET ctr = (
    SELECT
        CAST((SELECT SUM(clicks) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset3') 
        AS float) /
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset3') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset3';

\! echo "Updating CTR for Asset4";
UPDATE result_table 
SET ctr = (
    SELECT
        CAST((SELECT SUM(clicks) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset4') 
        AS float) /
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset4') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset4';

\! echo "Updating CTR for Asset5";
UPDATE result_table 
SET ctr = (
    SELECT
        CAST((SELECT SUM(clicks) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset5') 
        AS float) /
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset5') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset5';

\! echo "Updating VTR for Asset1";
UPDATE result_table 
SET vtr = (
    SELECT
        CAST((SELECT SUM(video_complete_views) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) FROM target_audience_user_id)
                AND asset = 'Asset1') AS float) /
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset1') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset1';

\! echo "Updating VTR for Asset2";
UPDATE result_table 
SET vtr = (
    SELECT
        CAST((SELECT SUM(video_complete_views) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) FROM target_audience_user_id)
                AND asset = 'Asset2') AS float) /
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset2') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset2';

\! echo "Updating VTR for Asset3";
UPDATE result_table 
SET vtr = (
    SELECT
        CAST((SELECT SUM(video_complete_views) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) FROM target_audience_user_id)
                AND asset = 'Asset3') AS float) /
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset3') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset3';

\! echo "Updating VTR for Asset4";
UPDATE result_table 
SET vtr = (
    SELECT
        CAST((SELECT SUM(video_complete_views) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) FROM target_audience_user_id)
                AND asset = 'Asset4') AS float) /
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset4') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset4';

\! echo "Updating VTR for Asset5";
UPDATE result_table 
SET vtr = (
    SELECT
        CAST((SELECT SUM(video_complete_views) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) FROM target_audience_user_id)
                AND asset = 'Asset5') AS float) /
        CAST((SELECT SUM(impressions) 
            FROM dataset1 
            WHERE user_id IN (
                SELECT (user_id) 
                FROM target_audience_user_id)
                AND asset = 'Asset5') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset5';

\! echo "Updating CR for Asset1";
UPDATE result_table
SET cr = (
    SELECT
    CAST((SELECT SUM(conversions) 
        FROM dataset1 
        WHERE user_id IN (
            SELECT (user_id) 
            FROM target_audience_user_id)
            AND asset = 'Asset1') 
    AS float) /
    CAST((SELECT SUM(impressions) 
        FROM dataset1 
        WHERE user_id IN (
            SELECT (user_id) 
            FROM target_audience_user_id)
            AND asset = 'Asset1') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset1';

\! echo "Updating CR for Asset2";
UPDATE result_table
SET cr = (
    SELECT
    CAST((SELECT SUM(conversions) 
        FROM dataset1 
        WHERE user_id IN (
            SELECT (user_id) 
            FROM target_audience_user_id)
            AND asset = 'Asset2') 
    AS float) /
    CAST((SELECT SUM(impressions) 
        FROM dataset1 
        WHERE user_id IN (
            SELECT (user_id) 
            FROM target_audience_user_id)
            AND asset = 'Asset2') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset2';

\! echo "Updating CR for Asset3";
UPDATE result_table
SET cr = (
    SELECT
    CAST((SELECT SUM(conversions) 
        FROM dataset1 
        WHERE user_id IN (
            SELECT (user_id) 
            FROM target_audience_user_id)
            AND asset = 'Asset3') 
    AS float) /
    CAST((SELECT SUM(impressions) 
        FROM dataset1 
        WHERE user_id IN (
            SELECT (user_id) 
            FROM target_audience_user_id)
            AND asset = 'Asset3') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset3';

\! echo "Updating CR for Asset4";
UPDATE result_table
SET cr = (
    SELECT
    CAST((SELECT SUM(conversions) 
        FROM dataset1 
        WHERE user_id IN (
            SELECT (user_id) 
            FROM target_audience_user_id)
            AND asset = 'Asset4') 
    AS float) /
    CAST((SELECT SUM(impressions) 
        FROM dataset1 
        WHERE user_id IN (
            SELECT (user_id) 
            FROM target_audience_user_id)
            AND asset = 'Asset4') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset4';

\! echo "Updating CR for Asset5";
UPDATE result_table
SET cr = (
    SELECT
    CAST((SELECT SUM(conversions) 
        FROM dataset1 
        WHERE user_id IN (
            SELECT (user_id) 
            FROM target_audience_user_id)
            AND asset = 'Asset5') 
    AS float) /
    CAST((SELECT SUM(impressions) 
        FROM dataset1 
        WHERE user_id IN (
            SELECT (user_id) 
            FROM target_audience_user_id)
            AND asset = 'Asset5') 
        AS float) * 100
    AS result
)
WHERE asset = 'Asset5';

SELECT * FROM result_table;