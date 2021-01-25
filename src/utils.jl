import REPL
using REPL.TerminalMenus

function workshop_selector()
    menu = RadioMenu(WORKSHOPS, pagesize = length(WORKSHOPS))
    choice = request("", menu)
    println()

    if choice != -1
        return WORKSHOPS[choice]
    else
        return nothing
    end
end

function yes_no_dialog()
    menu = RadioMenu(["yes", "no"], pagesize = 2)
    choice = request("", menu)
    println()

    if choice != -1
        return choice == 1 ? true : false
    else
        return nothing
    end
end


function with_pkg_env(
    fn::Function,
    path::AbstractString = ".";
    change_dir = false,
    globalenv = false,
)
    prev_active = Base.ACTIVE_PROJECT[]
    if globalenv
        Pkg.activate()
    else
        Pkg.activate(path)
    end
    try
        if change_dir
            cd(path) do
                fn()
            end
        else
            fn()
        end
    finally
        Base.ACTIVE_PROJECT[] = prev_active
    end
end

function pkgs_in_env()
    if VERSION < v"1.4"
        return keys(Pkg.installed())
    else
        return [dep.name for (uuid, dep) in Pkg.dependencies()]
    end
end

function julia_version_is_compatible(workshop)
    workshop in keys(WORKSHOP_JULIA_VERSION) || return true
    
    ver = WORKSHOP_JULIA_VERSION[workshop]
    ver_upper = VersionNumber(ver.major, ver.minor+1)
    return ver <= VERSION < ver_upper
end
