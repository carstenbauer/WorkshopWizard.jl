"""
Check if IJulia is available.
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
    install_IJulia(; python = nothing, globally = true)

Install the IJulia kernel for jupyter.

Although the installer should locate your local python installation automatically
(if present), the keyword `python` can be used to manually point to a python executable.

When `globally = true` IJulia will be installed to the global `v#.#` environment,
or to the environment that has been given to `--project` when Julia was started.
"""
function install_IJulia(; python = nothing, globally = true)
    if _check_IJulia()
        @info "IJulia already seems to be installed."
        return nothing
    end

    if !isnothing(python)
        !isfile(python) &&
        isdir(python) &&
        throw(ArgumentError("Please specify the path to the python executable " *
                            "including the executable name itself!"))
        @info "Setting ENV[\"PYTHON\"] = $python"
        ENV["PYTHON"] = python
    end

    if globally
        @info "Installing IJulia to global environment"
        # prev_active = Base.ACTIVE_PROJECT[]
        # pkg"activate"
        # pkg"add IJulia"
        # Pkg.activate(prev_active)
        with_pkg_env("", globalenv = true) do
            pkg"add IJulia"
        end
    else
        @info "Installing IJulia"
        pkg"add IJulia"
    end
    return nothing
end

"""
    notebookserver()

Start the Jupyter notebook server to dive into the workshop materials!
"""
function notebookserver()
    @info "Loading IJulia"
    @eval using IJulia
    @info "Starting Jupyter notebook server"
    @eval notebook()
end
