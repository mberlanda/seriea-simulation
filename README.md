# Serie A Simulation

This small program allows to run some simulation scenarios of Serie A 2024/2025 last 5 matches. For the exercise scope, Julia will be the utilized programming language.

Run the tests

```
julia --project -e 'using Pkg; Pkg.test()'
```

Run the main script

```

```


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