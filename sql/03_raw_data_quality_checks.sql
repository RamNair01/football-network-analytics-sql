-- Just a regular check on the number of rows in each table
SELECT 'matches' AS table_name,
    COUNT(*)
FROM raw.matches
UNION ALL
SELECT 'events',
    COUNT(*)
FROM raw.events
UNION ALL
SELECT 'clubelo_ratings',
    COUNT(*)
FROM raw.clubelo_ratings
UNION ALL
SELECT 'non_league_fixtures',
    COUNT(*)
FROM raw.non_league_fixtures
UNION ALL
SELECT 'team_name_mapping',
    COUNT(*)
FROM raw.team_name_mapping;
/* Check for duplicate rows in the events tables, in
 case something went wrong with the data ingestion.
 */
SELECT match_id,
    event_id,
    COUNT(*)
FROM raw.events
GROUP BY match_id,
    event_id
HAVING COUNT(*) > 1;
    /* Counting if all events have a match_id that exists 
     in the matches table. 
     */
SELECT COUNT(*) AS events_with_no_match
FROM raw.events e
    LEFT JOIN raw.matches m ON e.match_id = m.match_id
WHERE m.match_id IS NULL;
/* Checking that the unique number of matches in the events table
 is the same as the number of matches in the matches table. 
 */
SELECT DISTINCT match_id
FROM raw.events
EXCEPT -- NOT FOR SELF: https://www.geeksforgeeks.org/sql/sql-except-clause/
SELECT match_id
FROM raw.matches;
/* I want to check the team name mismatch 
 between the matches table and the clubelo ratings table.
 This is important because I want to standadize the team names
 across the tables when I add the clubelo ratings to my panel data.
 */
SELECT COUNT(*) AS home_team_names_missing_from_clubelo
FROM (
        SELECT DISTINCT home_team_name
        FROM raw.matches
        EXCEPT
        SELECT DISTINCT clubelo_team_name
        FROM raw.clubelo_ratings
    ) AS missing_teams;
/* 
 team_name_mapping contains the statsbomb team name and the corresponding
 clubelo team name. I want to check if the clubeelo team names
 are present in the clubelo ratings table.
 */
SELECT COUNT(*) AS mapped_teams_missing_from_clubelo
FROM (
        SELECT competition_name,
            clubelo_team_name
        FROM raw.team_name_mapping
        EXCEPT
        SELECT competition_name,
            clubelo_team_name
        FROM raw.clubelo_ratings
    ) AS missing_elo_histories;


/* A bit of a silly check, but just checking if the 
 number of matches in the matches table is the same
 as the number of matches in the expected of the 2015-16 season.
 */
SELECT
    COUNT(*) AS total_matches,
    COUNT(*) FILTER (
        WHERE match_date >= DATE '2015-08-01'
          AND match_date < DATE '2016-08-01'
    ) AS matches_in_2015_16_range
FROM raw.matches;