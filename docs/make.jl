using RanDAGen
using Documenter

makedocs(;
    modules=[RanDAGen],
    authors="Trystan Kaes <trystanblkaes@gmail.com>",
    repo="https://github.com/TrystanKaes/RanDAGen.jl/blob/{commit}{path}#L{line}",
    sitename="RanDAGen.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://RanDAGen.github.io/RanDAGen.jl",
        assets=String[],
    ),
    # devbranch = "master",
    # devurl = "dev",
    versions = ["stable" => "v^", "v#.#", "dev" => "dev"],
    pages=[
        "Home" => "index.md",
    ],
    push_preview=true,
)

deploydocs(;
    repo="github.com/TrystanKaes/RanDAGen.jl",
)
