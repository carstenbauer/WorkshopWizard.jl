"""
Check if IJulia is available (anywhere).
"""
function check_IJulia()
    if _check_IJulia()
        @info "IJulia seems to be installed correctly."
    else
        @warn "Couldn't find IJulia. You can call `install_IJulia()` to install it.`"
    end
    return nothing
end

function _check_IJulia()
    try
        @eval import IJulia
        return true
    catch
        return false
    end
end


"""
    install_IJulia(; python = nothing)

Install IJulia to the to the global `v#.#` environment,
or to the environment that has been given to `--project` when Julia was started.

IJulia should automatically install python and jupyter if necessary.
The keyword `python` can be used to manually point to a python executable (to give it a hint).
"""
function install_IJulia(; python = nothing)
    if !isnothing(python)
        !isfile(python) &&
        isdir(python) &&
        throw(ArgumentError("Please specify the path to the python executable " *
                            "including the executable name itself!"))
        @info "Setting ENV[\"PYTHON\"] = $python"
        ENV["PYTHON"] = python
    end

    with_pkg_env("", globalenv = true) do
        if "IJulia" in pkgs_in_env()
            @info "IJulia already seems to be installed."
        else
            @info "Installing IJulia to global environment"
            pkg"add IJulia"
        end
    end
    return nothing
end


"""
    uninstall_IJulia()

Remove IJulia from the global environment.
"""
function uninstall_IJulia()
    with_pkg_env("", globalenv = true) do
        if "IJulia" in pkgs_in_env()
            @info "Uninstalling IJulia"
            pkg"rm IJulia"
        else
            @info "IJulia couldn't be found in the global environment"
        end
    end
    return nothing
end
