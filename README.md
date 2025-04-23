# Serie A Simulation

This small program allows to run some simulation scenarios of Serie A 2024/2025 last 5 matches. For the exercise scope, Julia will be the utilized programming language.

Run the tests

```
julia --project -e 'using Pkg; Pkg.test()'
```

Run the main script

```
julia main.jl
```

Fixtures source: https://fixturedownload.com/results/serie-a-2024

The data source seems to be incomplete:

```
[ Info: Team: Inter, Stats: Dict(:P => 32, :Pts => 71, :GF => 72, :W => 21, :D => 8, :L => 3, :GA => 29)
[ Info: Team: Parma, Stats: Dict(:P => 32, :Pts => 28, :GF => 37, :W => 5, :D => 13, :L => 14, :GA => 51)
[ Info: Team: Como, Stats: Dict(:P => 33, :Pts => 39, :GF => 43, :W => 10, :D => 9, :L => 14, :GA => 48)
[ Info: Team: Udinese, Stats: Dict(:P => 32, :Pts => 40, :GF => 36, :W => 11, :D => 7, :L => 14, :GA => 46)
[ Info: Team: Lazio, Stats: Dict(:P => 32, :Pts => 56, :GF => 53, :W => 16, :D => 8, :L => 8, :GA => 43)
[ Info: Team: Atalanta, Stats: Dict(:P => 33, :Pts => 64, :GF => 66, :W => 19, :D => 7, :L => 7, :GA => 30)
[ Info: Team: Monza, Stats: Dict(:P => 33, :Pts => 16, :GF => 25, :W => 2, :D => 10, :L => 21, :GA => 56)
[ Info: Current Standings (Based on Played Matches):
20×9 DataFrame
 Row │ Team           P      W      D      L      GF     GA     GD     Pts
     │ String         Int64  Int64  Int64  Int64  Int64  Int64  Int64  Int64
─────┼───────────────────────────────────────────────────────────────────────
   1 │ Inter             32     21      8      3     72     29     43     71
   2 │ Napoli            33     21      8      4     52     25     27     71
   3 │ Atalanta          33     19      7      7     66     30     36     64
   4 │ Bologna           33     16     12      5     52     37     15     60
   5 │ Juventus          32     15     14      3     49     30     19     59
   6 │ Roma              33     16      9      8     48     32     16     57
   7 │ Lazio             32     16      8      8     53     43     10     56
   8 │ Milan             33     14      9     10     51     38     13     51
   9 │ Fiorentina        31     14      8      9     46     32     14     50
  10 │ Torino            32      9     13     10     36     37     -1     40
  11 │ Udinese           32     11      7     14     36     46    -10     40
  12 │ Como              33     10      9     14     43     48     -5     39
  13 │ Genoa             32      9     12     11     29     38     -9     39
  14 │ Hellas Verona     33      9      5     19     30     60    -30     32
  15 │ Cagliari          32      7      9     16     32     47    -15     30
  16 │ Parma             32      5     13     14     37     51    -14     28
  17 │ Lecce             33      6      8     19     23     55    -32     26
  18 │ Empoli            33      4     13     16     26     52    -26     25
  19 │ Venezia           33      3     14     16     26     46    -20     23
  20 │ Monza             33      2     10     21     25     56    -31     16%
  ```


---


Install Julia: https://julialang.org/install/
```sh
curl -fsSL https://install.julialang.org | sh
```
Add VSCode extension: https://marketplace.visualstudio.com/items?itemName=julialang.language-julia

```
]
generate seriea_sim
```

Add dependencies
```
(@v1.11) pkg> activate ./
  Activating project at `~/Code/seriea-simulation`

(seriea_sim) pkg> add DataFrames CSV Combinatorics StatsBase
```