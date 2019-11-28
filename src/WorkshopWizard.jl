module WorkshopWizard

using Pkg

const GITHUB_BASEURL = "https://github.com/crstnbr/"
const WORKSHOPS = ["JuliaOulu20", "JuliaWorkshop19", "JuliaWorkshop18"]

default_workshop() = WORKSHOPS[2]
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
