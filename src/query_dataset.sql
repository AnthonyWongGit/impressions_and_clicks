\c dataset_test

DROP TABLE IF EXISTS target_audience_user_id;

\! echo "Total unique users:";
SELECT COUNT(DISTINCT user_id) FROM dataset2;

\! echo "Total unique users matching target audience characteristics:";
SELECT DISTINCT user_id INTO target_audience_user_id FROM (
    SELECT * FROM dataset2 WHERE age >= 55 AND nrs_grade IN ('A', 'B')
) AS target_audience;

SELECT COUNT(*) FROM target_audience_user_id;


\! echo "Percentage of unique users that matched target audience characteristics:";
SELECT 
    CAST((SELECT COUNT(DISTINCT user_id) FROM (
        SELECT * FROM dataset2 WHERE age >= 55 AND nrs_grade IN ('A', 'B')
        ) AS target_audience) AS float) /
    CAST((SELECT COUNT(DISTINCT user_id) FROM dataset2) AS float) * 100
AS result;

-- \! echo "Reach for Asset1";


-- \! echo "Reach for Asset2";
-- \! echo "Reach for Asset3";
-- \! echo "Reach for Asset4";
-- \! echo "Reach for Asset5";

-- \! echo "Frequency for Asset1";
-- SELECT
--     CAST((SELECT SUM(impressions) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset1') AS float) /
--     CAST((SELECT COUNT(DISTINCT user_id) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset1') AS float)
-- AS result;

-- \! echo "Frequency for Asset2";
-- SELECT
--     CAST((SELECT SUM(impressions) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset2') AS float) /
--     CAST((SELECT COUNT(DISTINCT user_id) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset2') AS float)
-- AS result;

-- \! echo "Frequency for Asset3";
-- SELECT
--     CAST((SELECT SUM(impressions) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset3') AS float) /
--     CAST((SELECT COUNT(DISTINCT user_id) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset3') AS float)
-- AS result;

-- \! echo "Frequency for Asset4";
-- SELECT
--     CAST((SELECT SUM(impressions) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset4') AS float) /
--     CAST((SELECT COUNT(DISTINCT user_id) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset4') AS float)
-- AS result;

-- \! echo "Frequency for Asset5";
-- SELECT
--     CAST((SELECT SUM(impressions) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset5') AS float) /
--     CAST((SELECT COUNT(DISTINCT user_id) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset5') AS float)
-- AS result;

-- \! echo "CTR for Asset1";
-- SELECT
--     CAST((SELECT SUM(clicks) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset1') AS float) /
--     CAST((SELECT SUM(impressions) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset1') AS float)
-- AS result;

-- \! echo "CTR for Asset2";
-- SELECT
--     CAST((SELECT SUM(clicks) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset2') AS float) /
--     CAST((SELECT SUM(impressions) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset2') AS float)
-- AS result;

-- \! echo "CTR for Asset3";
-- SELECT
--     CAST((SELECT SUM(clicks) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset3') AS float) /
--     CAST((SELECT SUM(impressions) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset3') AS float)
-- AS result;

-- \! echo "CTR for Asset4";
-- SELECT
--     CAST((SELECT SUM(clicks) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset4') AS float) /
--     CAST((SELECT SUM(impressions) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset4') AS float)
-- AS result;

-- \! echo "CTR for Asset5";
-- SELECT
--     CAST((SELECT SUM(clicks) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset5') AS float) /
--     CAST((SELECT SUM(impressions) FROM dataset1 WHERE user_id IN (
--         SELECT (user_id) FROM target_audience_user_id)
--         AND asset = 'Asset5') AS float)
-- AS result;

-- \! echo "VTR for Asset1";
-- \! echo "VTR for Asset2";
-- \! echo "VTR for Asset3";
-- \! echo "VTR for Asset4";
-- \! echo "VTR for Asset5";

-- \! echo "CR for Asset1";
-- \! echo "CR for Asset2";
-- \! echo "CR for Asset3";
-- \! echo "CR for Asset4";
-- \! echo "CR for Asset5";