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

function install_IJulia(; python = nothing)
    if !isnothing(python)
        !isfile(python) &&
        isdir(python) &&
        throw(ArgumentError("Please specify the path to the python executable " *
                            "including the executable name itself!"))
        @info "Setting ENV[\"PYTHON\"] = $python"
        ENV["PYTHON"] = python
    end

    @info "Installing IJulia"
    pkg"add IJulia"
    return nothing
end

function notebookserver()
    @info "Loading IJulia"
    @eval using IJulia
    @info "Starting Jupyter notebook server"
    @eval notebook()
end
