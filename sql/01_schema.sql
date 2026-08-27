CREATE SCHEMA IF NOT EXISTS raw;
CREATE TABLE IF NOT EXISTS raw.matches (
    match_id BIGINT PRIMARY KEY,
    match_date DATE NOT NULL,
    kick_off TIME,
    home_team_id BIGINT,
    away_team_id BIGINT,
    home_team_name TEXT NOT NULL,
    away_team_name TEXT NOT NULL,
    home_score SMALLINT,
    away_score SMALLINT,
    home_manager TEXT,
    away_manager TEXT,
    match_week SMALLINT,
    competition_name TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS raw.events (
    match_id BIGINT NOT NULL,
    event_id UUID PRIMARY KEY,
    event_index INTEGER,
    period SMALLINT,
    minute SMALLINT,
    second SMALLINT,
    possession_id INTEGER,
    team_name TEXT,
    possession_team_name TEXT,
    player_name TEXT,
    event_type TEXT,
    start_x DOUBLE PRECISION,
    start_y DOUBLE PRECISION,
    pass_recipient_name TEXT,
    pass_outcome TEXT,
    pass_end_x DOUBLE PRECISION,
    pass_end_y DOUBLE PRECISION,
    shot_xg DOUBLE PRECISION,
    shot_outcome TEXT,
    substitution_outcome TEXT,
    card_type TEXT
);
CREATE TABLE IF NOT EXISTS raw.clubelo_ratings (
    competition_name TEXT NOT NULL,
    clubelo_team_name TEXT NOT NULL,
    rank NUMERIC(5, 1),
    country TEXT,
    level SMALLINT,
    elo DOUBLE PRECISION,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL
);
CREATE TABLE IF NOT EXISTS raw.non_league_fixtures (
    date TIMESTAMP,
    home_team TEXT,
    away_team TEXT,
    competition TEXT,
    round TEXT
);
CREATE TABLE IF NOT EXISTS raw.team_name_mapping (
    competition_name TEXT NOT NULL,
    statsbomb_team_name TEXT NOT NULL,
    clubelo_team_name TEXT NOT NULL,
    PRIMARY KEY (competition_name, statsbomb_team_name)
);