module WorkshopWizard

using Pkg

const GITHUB_BASEURL = "https://github.com/crstnbr/"
const WORKSHOPS = [
    "JuliaNRW21",
    "JuliaOulu20",
    "JuliaWorkshop19",
    "JuliaWorkshop18"
    ]

const WORKSHOP_JULIA_VERSION = Dict(
    "JuliaNRW21" => v"1.5",
    "JuliaOulu20" => v"1.3",
    "JuliaWorkshop19" => v"1.2",
    "JuliaWorkshop18" => v"1.0"
    )

default_workshop() = WORKSHOPS[1]
default_repo() = joinpath(GITHUB_BASEURL, default_workshop())
default_path() = begin
    if Sys.iswindows()
        return joinpath(homedir(), "Desktop")
        # homedir()
    else
        return homedir()
    end
end

include("IJulia.jl")
include("utils.jl")
include("install.jl")

end # module
