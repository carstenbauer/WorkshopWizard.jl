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
