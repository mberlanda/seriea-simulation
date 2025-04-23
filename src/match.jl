module match

using DataFrames, Logging

export Match, parse_match

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

function safe_parse_int(::Type{Int}, x)
    try
        return x isa Int ? x : (x isa String && x !== missing) ? parse(Int, x) : missing
    catch
        return missing
    end
end

end # module match
