/* Now I need to compute several features for the first-half and second-half. To do this, I use the event level data from staging.events to compute
several features at the team-match level. */

CREATE SCHEMA IF NOT EXISTS analytics;

DROP VIEW IF EXISTS analytics.team_half_event_features;

CREATE OR REPLACE VIEW analytics.team_half_event_features AS
SELECT
    tm.match_id,
    tm.team_name,
    tm.opponent_team_name,
    tm.competition_name,

    -- First-half goals, shots, and xG
    COUNT(*) FILTER (
        WHERE
            e.period = 1
            AND e.event_type = 'Shot'
            AND e.shot_outcome = 'Goal'
    ) AS goals_team_h1,

    COUNT(*) FILTER (
        WHERE
            e.period = 1
            AND e.event_type = 'Shot'
    ) AS shot_count_team_h1,

    /* NOTE FOR SELF: COALESCE returns the first non-null value in a list (https://www.w3schools.com/sql/func_sqlserver_coalesce.asp). In this case, it
    returns 0.0 if sum_xg_team_h1 is null (a team takes no shots in the half) */
    COALESCE( 
        SUM(e.shot_xg) FILTER (
            WHERE
                e.period = 1
                AND e.event_type = 'Shot'
        ),
        0.0
    ) AS sum_xg_team_h1,


    COUNT(*) FILTER (
        WHERE
            e.substitution_outcome IS NOT NULL
            AND e.period = 1
    ) AS substitutions_team_h1,

    -- Second-half goals, shots, and xG
    COUNT(*) FILTER (
        WHERE e.period = 2
          AND e.event_type = 'Shot'
          AND e.shot_outcome = 'Goal'
    ) AS goals_team_h2,

    COUNT(*) FILTER (
        WHERE e.period = 2
          AND e.event_type = 'Shot'
    ) AS shot_count_team_h2,

    COALESCE( 
        SUM(e.shot_xg) FILTER (
            WHERE e.period = 2
              AND e.event_type = 'Shot'
        ),
        0.0
    ) AS sum_xg_team_h2,

    COUNT(*) FILTER (
        WHERE
            e.substitution_outcome IS NOT NULL
            AND e.period = 2
    ) AS substitutions_team_h2

FROM analytics.team_matches AS tm
LEFT JOIN staging.events AS e
    ON tm.match_id = e.match_id
   AND tm.team_name = e.team_name
GROUP BY
    tm.match_id,
    tm.team_name,
    tm.opponent_team_name,
    tm.competition_name;

SELECT *
FROM analytics.team_half_event_features
ORDER BY competition_name, team_name ASC
LIMIT 20;
