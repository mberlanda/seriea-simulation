using Test
include("../src/match.jl")
using .match: Match, parse_match, parse_match_from_csv

@testset "parse_match tests" begin
    @testset "Valid match data" begin
        row = Dict("Round" => 1, "Home" => "TeamA", "Away" => "TeamB", "HGoals" => "2", "AGoals" => "1")
        match = parse_match(row)
        @test match.round == 1
        @test match.home == "TeamA"
        @test match.away == "TeamB"
        @test match.hgoals == 2
        @test match.agoals == 1
        @test match.outcome == "H"
    end

    @testset "Draw match data" begin
        row = Dict("Round" => 2, "Home" => "TeamC", "Away" => "TeamD", "HGoals" => "1", "AGoals" => "1")
        match = parse_match(row)
        @test match.round == 2
        @test match.home == "TeamC"
        @test match.away == "TeamD"
        @test match.hgoals == 1
        @test match.agoals == 1
        @test match.outcome == "D"
    end

    @testset "Missing goals data" begin
        row = Dict("Round" => 3, "Home" => "TeamE", "Away" => "TeamF", "HGoals" => "", "AGoals" => "")
        match = parse_match(row)
        @test match.round == 3
        @test match.home == "TeamE"
        @test match.away == "TeamF"
        @test match.hgoals === missing
        @test match.agoals === missing
        @test match.outcome === missing
    end

    @testset "Invalid goals data" begin
        row = Dict("Round" => 4, "Home" => "TeamG", "Away" => "TeamH", "HGoals" => "abc", "AGoals" => "xyz")
        match = parse_match(row)
        @test match.round == 4
        @test match.home == "TeamG"
        @test match.away == "TeamH"
        @test match.hgoals === missing
        @test match.agoals === missing
        @test match.outcome === missing
    end
end

@testset "parse_match_from_csv tests" begin
    @testset "Valid match data" begin
        row = Dict(
            "Round Number" => "1",
            "Home Team" => "Genoa",
            "Away Team" => "Inter",
            "Result" => "2 - 2"
        )
        match = parse_match_from_csv(row)
        @test match.round == 1
        @test match.home == "Genoa"
        @test match.away == "Inter"
        @test match.hgoals == 2
        @test match.agoals == 2
        @test match.outcome == "D"
    end

    @testset "Missing result data" begin
        row = Dict(
            "Round Number" => "2",
            "Home Team" => "Parma",
            "Away Team" => "Fiorentina",
            "Result" => missing
        )
        match = parse_match_from_csv(row)
        @test match.round == 2
        @test match.home == "Parma"
        @test match.away == "Fiorentina"
        @test match.hgoals === missing
        @test match.agoals === missing
        @test match.outcome === missing
    end

    @testset "Invalid result format" begin
        row = Dict(
            "Round Number" => "3",
            "Home Team" => "Empoli",
            "Away Team" => "Monza",
            "Result" => "invalid"
        )
        match = parse_match_from_csv(row)
        @test match.round == 3
        @test match.home == "Empoli"
        @test match.away == "Monza"
        @test match.hgoals === missing
        @test match.agoals === missing
        @test match.outcome === missing
    end
end
