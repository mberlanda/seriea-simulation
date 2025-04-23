using Test
using seriea_sim

@testset "Serie A Simulation Tests" begin
    # Test `load_fixtures`
    @testset "load_fixtures" begin
        fixtures_file = joinpath(@__DIR__, "fixtures.csv")
        matches = load_fixtures(fixtures_file)
        @test length(matches) > 0
    end

    # Test `compute_standings`
    @testset "compute_standings" begin
        matches = [
            Match(1, "TeamA", "TeamB", 2, 1, "H"),
            Match(1, "TeamC", "TeamD", 0, 0, "D"),
            Match(2, "TeamA", "TeamC", 3, 2, "H"),
            Match(2, "TeamB", "TeamD", 1, 1, "D")
        ]
        standings = compute_standings(matches)
        @test size(standings, 1) == 4
        @test standings[1, :Team] == "TeamA"
    end
end
