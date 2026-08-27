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

--- Just checking that the view works
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
WHERE is_successful_pass
LIMIT 20;

SELECT *
FROM staging.events
WHERE is_goal
LIMIT 20;