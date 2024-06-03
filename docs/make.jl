using TrainingLog
using Documenter

DocMeta.setdocmeta!(TrainingLog, :DocTestSetup, :(using TrainingLog); recursive=true)

makedocs(;
    modules=[TrainingLog],
    authors="Jonathan Miller jonathan.miller@fieldofnodes.com",
    sitename="TrainingLog.jl",
    format=Documenter.HTML(;
        canonical="https://fieldofnodes.github.io/TrainingLog.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/fieldofnodes/TrainingLog.jl",
    devbranch="main",
)
