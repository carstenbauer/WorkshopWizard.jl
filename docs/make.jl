using Documenter, WorkshopWizard

makedocs(
    modules = [WorkshopWizard],
    doctest = false,
    sitename = "WorkshopWizard.jl",
    pages = [
        "Introduction" => "index.md",
        "Usage" => "usage.md",
        "Troubleshooting" => "troubleshooting.md",
        "Functions" => "functions.md",
    ],
    # assets = ["assets/custom.css", "assets/custom.js"]
)

deploydocs(repo = "github.com/crstnbr/WorkshopWizard.jl.git", push_preview = true)
