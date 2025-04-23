using Pkg
Pkg.activate(".")
Pkg.instantiate()

using CSV, DataFrames, Logging
import seriea_sim as SerieA

# Set up logging
# https://docs.julialang.org/en/v1/stdlib/Logging/
global_logger(ConsoleLogger())

# Load fixtures from CSV
fixtures = SerieA.load_fixtures("data/fixtures.csv")
@info "Fixtures loaded: $(length(fixtures)) matches"

# Display first few fixtures
@info "First few fixtures: $(first(fixtures, 10))"
# Compute standings
standings = SerieA.compute_standings(fixtures)

# Display results
@info "Current Standings (Based on Played Matches):"
show(standings, allrows=true, allcols=true)
