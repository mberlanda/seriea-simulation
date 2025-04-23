module seriea_sim

using DataFrames, CSV, Logging
include("match.jl")
using .match: Match, parse_match

export Match, load_fixtures, compute_standings

function load_fixtures(file::String)
    df = CSV.read(file, DataFrame)
    matches = Match[]

    for row in eachrow(df)
        push!(matches, parse_match(row))
    end

    return matches
end

function compute_standings(matches::Vector{Match})
    teams = Dict{String, Dict{Symbol, Int}}()

    for match in matches
        if match.hgoals === missing || match.agoals === missing
            continue
        end

        for t in [match.home, match.away]
            if !haskey(teams, t)
                teams[t] = Dict(:P => 0, :W => 0, :D => 0, :L => 0, :GF => 0, :GA => 0, :Pts => 0)
            end
        end

        teams[match.home][:P] += 1
        teams[match.away][:P] += 1

        teams[match.home][:GF] += match.hgoals
        teams[match.home][:GA] += match.agoals
        teams[match.away][:GF] += match.agoals
        teams[match.away][:GA] += match.hgoals

        if match.hgoals > match.agoals
            teams[match.home][:W] += 1
            teams[match.away][:L] += 1
            teams[match.home][:Pts] += 3
        elseif match.hgoals == match.agoals
            teams[match.home][:D] += 1
            teams[match.away][:D] += 1
            teams[match.home][:Pts] += 1
            teams[match.away][:Pts] += 1
        else
            teams[match.away][:W] += 1
            teams[match.home][:L] += 1
            teams[match.away][:Pts] += 3
        end
    end

    standings = DataFrame(
        Team = String[],
        P = Int[],
        W = Int[],
        D = Int[],
        L = Int[],
        GF = Int[],
        GA = Int[],
        GD = Int[],
        Pts = Int[]
    )

    for (team, stats) in teams
        @info "Team: $team, Stats: $stats"
        push!(standings, (
            Team = team,
            P = stats[:P],
            W = stats[:W],
            D = stats[:D],
            L = stats[:L],
            GF = stats[:GF],
            GA = stats[:GA],
            GD = stats[:GF] - stats[:GA],
            Pts = stats[:Pts]
        ))
    end

    return sort(standings, [:Pts, :GD, :GF], rev = true)
end

end # module seriea_sim
