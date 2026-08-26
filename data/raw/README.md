# Raw data inputs

This directory contains the full, local source layer for the SQL pipeline.
It is intentionally excluded from Git because `events_2015_16.csv` is large.

| File | Rows | Source |
| --- | ---: | --- |
| `matches_2015_16.csv` | 1,823 | StatsBomb match metadata, preserved from the thesis input layer |
| `events_2015_16.csv` | 6,417,863 | Original StatsBomb event feeds, flattened to relational columns |
| `clubelo_ratings.csv` | 9,845 | Consolidated ClubElo team-rating histories from the thesis input layer |
| `non_league_fixtures.csv` | 514 | Non-league fixtures used to calculate rest days |
| `team_name_mapping.csv` | 100 | Mapping between StatsBomb and ClubElo team names |

The event data use StatsBomb Open Data at commit `b878744`, matching the
thesis pipeline. Follow the source terms when sharing analysis based on these
data, including attribution to StatsBomb.

