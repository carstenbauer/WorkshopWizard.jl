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
)
    prev_active = Base.ACTIVE_PROJECT[]
    Pkg.activate(path)
    try
        if change_dir
            cd(fn, path)
        else
            fn()
        end
    finally
        Base.ACTIVE_PROJECT[] = prev_active
    end
end
