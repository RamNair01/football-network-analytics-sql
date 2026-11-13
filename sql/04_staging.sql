CREATE SCHEMA IF NOT EXISTS staging;
CREATE OR REPLACE VIEW staging.matches AS
SELECT match_id,
    match_date,
    kick_off,
    competition_name,
    home_team_id,
    away_team_id,
    home_team_name,
    away_team_name,
    home_score,
    away_score,
    home_manager,
    away_manager,
    match_week
FROM raw.matches;
CREATE OR REPLACE VIEW staging.events AS
SELECT event_id,
    match_id,
    event_index,
    period,
    minute,
    second,
    possession_id,
    team_name,
    possession_team_name,
    player_name,
    event_type,
    start_x,
    start_y,
    pass_recipient_name,
    pass_outcome,
    pass_end_x,
    pass_end_y,
    shot_xg,
    shot_outcome,
    substitution_outcome,
    card_type,

    event_type = 'Pass' --- NOTE TO SELF: SQL uses single = for comparison
    AND pass_outcome IS NULL AS is_successful_pass,
    event_type = 'Shot'
    AND shot_outcome = 'Goal' AS is_goal,
    minute * 60 + second AS event_time_seconds
FROM raw.events;


CREATE OR REPLACE VIEW staging.clubelo_ratings AS
SELECT competition_name,
    clubelo_team_name,
    elo,
    valid_from,
    valid_to
FROM raw.clubelo_ratings;

CREATE OR REPLACE VIEW staging.non_league_fixtures AS
SELECT date,
    home_team,
    away_team,
    competition
FROM raw.non_league_fixtures;

--- Just checking that the view works for the events table
SELECT *
FROM staging.events
WHERE is_successful_pass OR is_goal
LIMIT 20;

SELECT *
FROM staging.events
WHERE NOT is_successful_pass OR NOT is_goal
LIMIT 20;

SELECT *
FROM staging.events
WHERE NOT is_successful_pass AND NOT is_goal
LIMIT 20;

SELECT *
FROM staging.events
WHERE is_successful_pass
LIMIT 20;

SELECT *
FROM staging.events
WHERE is_goal
LIMIT 20;

SELECT *
FROM staging.events
WHERE shot_xg IS NOT NULL
LIMIT 20;

SELECT *
FROM staging.events
WHERE substitution_outcome IS NOT NULL
LIMIT 20;