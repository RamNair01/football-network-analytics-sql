# Football Network Analytics with SQL

I am revisiting SQL by engineering and analysing the football data used in my MSc thesis. The original thesis workflow was developed in Python; this repository is a local SQL-based recreation of the data pipeline and analysis environment.

The original Python project is available at [football-passing-networks](https://github.com/RamNair01/football-passing-networks).

The repository includes the database schema, data-loading queries, and local Docker configuration.

Source CSV data are kept out of version control because of their size and licensing considerations.

## Data sources

- [StatsBomb Open Data](https://github.com/statsbomb/open-data) supplies event and match data.
- [ClubElo](http://clubelo.com/) supplies pre-match team ratings.

### StatsBomb attribution

[![StatsBomb logo](assets/statsbomb-logo.jpg)](https://statsbomb.com/)

Use of the source data remains subject to the terms set by each provider.

## Local setup

1. Copy `.env.example` to `.env` and set a local PostgreSQL password.
2. Start PostgreSQL with `docker compose up -d`.
3. Run the SQL files in `sql/` to create the schema and load locally available raw data.

See [data/raw/README.md](data/raw/README.md) for the local data inputs.
