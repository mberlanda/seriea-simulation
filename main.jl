using Pkg
Pkg.activate(".")
Pkg.instantiate()

using CSV, DataFrames, Logging
import seriea_sim as SerieA

# Set up logging
# https://docs.julialang.org/en/v1/stdlib/Logging/
global_logger(ConsoleLogger())

# Load fixtures from CSV
# https://fixturedownload.com/results/serie-a-2024
# fixtures = SerieA.load_fixtures("data/fixtures.csv")
fixtures = SerieA.load_fixtures("data/serie-a-2024-UTC.csv"; mode=:csv)
@info "Fixtures loaded: $(length(fixtures)) matches"

# Display first few fixtures
@info "First few fixtures: $(first(fixtures, 10))"
# Compute standings
standings = SerieA.compute_standings(fixtures)

# Display results
@info "Current Standings (Based on Played Matches):"
show(standings, allrows=true, allcols=true)
