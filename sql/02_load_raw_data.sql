COPY raw.matches
FROM '/data/raw/matches_2015_16.csv' WITH (FORMAT csv, HEADER true);
SELECT COUNT(*) AS match_count
FROM raw.matches;
COPY raw.clubelo_ratings
FROM '/data/raw/clubelo_ratings.csv' WITH (FORMAT csv, HEADER true);
SELECT COUNT(*) AS clubelo_ratings_count
FROM raw.clubelo_ratings;
COPY raw.non_league_fixtures
FROM '/data/raw/non_league_fixtures.csv' WITH (FORMAT csv, HEADER true);
SELECT COUNT(*) AS non_league_fixtures_count
FROM raw.non_league_fixtures;
COPY raw.team_name_mapping
FROM '/data/raw/team_name_mapping.csv' WITH (FORMAT csv, HEADER true);
SELECT COUNT(*) AS team_name_mapping_count
FROM raw.team_name_mapping;
COPY raw.events
FROM '/data/raw/events_2015_16.csv' WITH (FORMAT csv, HEADER true);
SELECT COUNT(*) AS events_count
FROM raw.events;
