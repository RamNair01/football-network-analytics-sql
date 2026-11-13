/* In my thesis, I investigate the relationship between a team's passing network structure and their attacking performance. 
As a result, each match produces two observations, one from each team's perspective. Therefore, I need to create a table of team-match observations */

CREATE SCHEMA IF NOT EXISTS analytics;

DROP VIEW IF EXISTS analytics.team_half_event_features;
DROP TABLE IF EXISTS analytics.team_matches;

CREATE TABLE analytics.team_matches AS
SELECT
    match_id,
    match_date,
    competition_name,
    match_week,
    home_team_id AS team_id,
    home_team_name AS team_name,
    away_team_id AS opponent_team_id,
    away_team_name AS opponent_team_name,
    TRUE AS is_home,
    home_score AS goals_for,
    away_score AS goals_against
FROM staging.matches

UNION ALL -- NOTE FOR SELF: UNION ALL adds duplicate rows, which is exactly what is needed here. UNION would remove the duplicate rows.

SELECT
    match_id,
    match_date,
    competition_name,
    match_week,
    away_team_id AS team_id,
    away_team_name AS team_name,
    home_team_id AS opponent_team_id,
    home_team_name AS opponent_team_name,
    FALSE AS is_home,
    away_score AS goals_for,
    home_score AS goals_against
FROM staging.matches;

ALTER TABLE analytics.team_matches
ADD PRIMARY KEY (match_id, team_id);

SELECT *
FROM analytics.team_matches
ORDER BY competition_name, match_date, match_week, match_id;

/* Just check that the # of rows in analytics.team_matches is exactly double staging.matches 
because we have a panel dataset with two observations per match. 
*/
SELECT 
    COUNT(*) AS team_matches_count,
    (SELECT COUNT(*) * 2 FROM staging.matches) AS expected_count,
    COUNT(*) = (SELECT COUNT(*) * 2 FROM staging.matches) AS matching_counts
FROM analytics.team_matches;

