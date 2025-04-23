module match

using DataFrames, Logging

export Match, parse_match, parse_match_from_csv

struct Match
    round::Int
    home::String
    away::String
    hgoals::Union{Int, Missing}
    agoals::Union{Int, Missing}
    outcome::Union{String, Missing}
end

function parse_match(row)
    h = row.Home
    a = row.Away
    hg = safe_parse_int(Int, row.HGoals)
    ag = safe_parse_int(Int, row.AGoals)

    @debug "Parsed match" home=h away=a hgoals=hg agoals=ag

    outcome = if hg !== missing && ag !== missing
        hg > ag ? "H" : hg == ag ? "D" : "A"
    else
        missing
    end

    return Match(row.Round, h, a, hg, ag, outcome)
end

function parse_match_from_csv(row)
    round = safe_parse_int(Int, row."Round Number")
    home = row."Home Team"
    away = row."Away Team"
    
    result = row.Result
    @info "Parsing match from CSV: Round $round, Home $home, Away $away, Result $result"
    hgoals, agoals = if result !== missing && occursin(" - ", result)
        split(result, " - ") .|> x -> safe_parse_int(Int, x)
    else
        missing, missing
    end

    outcome = if hgoals !== missing && agoals !== missing
        hgoals > agoals ? "H" : hgoals == agoals ? "D" : "A"
    else
        missing
    end

 
    return Match(round, home, away, hgoals, agoals, outcome)
end

function safe_parse_int(::Type{Int}, x)
    try
        @info "Attempting to parse integer: $x"
        if x isa Int
            return x
        elseif (x isa String || x isa SubString) && x !== missing
            return parse(Int, String(x))
        else
            @warn "Invalid type for integer parsing: $(typeof(x))"
            return missing
        end
    catch
        @warn "Failed to parse integer: $x"
        return missing
    end
end

end # module match
