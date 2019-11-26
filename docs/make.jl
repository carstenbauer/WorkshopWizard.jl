using Documenter, WorkshopWizard

makedocs(
    modules = [WorkshopWizard],
    doctest = false,
    sitename = "WorkshopWizard.jl",
    # pages = [
    #     "Home" => "index.md",
    #     "Manual" => [
    #         "Getting started" => "manual/gettingstarted.md",
    #         "Examples" => "manual/examples.md",
    #     ],
    #     "Physical models" => [
    #         "Ising model" => "models/ising.md",
    #         "Attractive Hubbard model" => "models/hubbardattractive.md",
    #     ],
    #     "Monte Carlo flavors" => [
    #         "MC" => "flavors/mc.md",
    #         "DQMC" => "flavors/dqmc.md",
    #     ],
    #     "Lattices" => "lattices.md",
    #     "Customize" => "customize.md",
    #     "Methods" => ["General" => "methods/general.md"],
    #     "Interfaces" => [
    #         "MC" => "interfaces/MC.md",
    #         "DQMC" => "interfaces/DQMC.md",
    #     ],
    # ],
    # assets = ["assets/custom.css", "assets/custom.js"]
)

deploydocs(repo = "github.com/crstnbr/WorkshopWizard.jl.git", push_preview = true)
