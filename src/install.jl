using LibGit2

"""
    download(; repo = default_repo(), path = default_path())

Download a workshop from github.

Keyword arguments `repo` and `path` can be used to specify the github repository
and the local installation directory.
"""
function download(; repo = default_repo(), path = default_path())
    if !occursin("github.com", repo)
        repo = joinpath(GITHUB_BASEURL, repo)
    end
    workshop = basename(repo)
    @info "Downloading \"$workshop\" to $path"
    LibGit2.clone(repo, joinpath(path, workshop))
    return nothing
end

"""
    install(; repo = default_repo(), path = default_path(), check_IJulia = true)

Download the Julia workshop and install all dependencies.

By default, the workshop will be downloaded to the desktop (on windows)
or the home directory (on linux/macOS). Alternatively, the installation path
can be specified per keyword argument `path=desired/install/path`.
"""
function install(; repo = default_repo(), path = default_path(), check_IJulia = true)
    download(repo = repo, path = path)
    install_dependencies(joinpath(path, basename(repo)))
    @info "Workshop installation completed."

    if check_IJulia && (_check_IJulia() == false)
        @info "Couldn't find IJulia."
        install_IJulia()
    end
    return nothing
end


"""
    install_dependencies(workshop_path)

Install and precompile all dependencies of the Julia workshop in `workshop_path`.
"""
function install_dependencies(workshop_path)
    @info "Installing and precompiling all dependencies (this may take a while)"
    cd(workshop_path) do
        println()
        pkg"activate ."
        pkg"instantiate"
        pkg"precompile"
        println("Done.")
        println()
    end
    pkg"activate ."
end

"""
    install_wizard()

Starts the workshop installation wizard. It will interactively guide you through
the selection, download, and installation of a Julia workshop.

If not already present, the wizard will also install IJulia.
"""
function install_wizard()
    IJulia_found = _check_IJulia(verbose = false)

    @info "Welcome to the workshop installation wizard."

    # workshop selection
    @info "Please select a workshop:"
    workshop = workshop_selector()
    if isnothing(workshop)
        @info "No workshop selected. Aborting."
        return nothing
    end
    @info "Selected \"$workshop\" for installation."

    # installation directory
    path = default_path()
    @info "The default installation directory is: $path"
    @info "Is that okay?"
    answer = yes_no_dialog()
    if answer == false
        @info "Please specify a directory:"
        p = ""
        while !isdir(p)
            p = readline()
            if !isdir(p)
                @info "Invalid directory. Please try again."
            end
        end
        path = p
    end

    @info "Starting the installation"
    install(repo = joinpath(GITHUB_BASEURL, workshop), path = path)

    if !IJulia_found
        println()
        @info "You don't seem to have IJulia installed, which is necessary for the workshop."
        @info "Should I install it for you?"
        answer = yes_no_dialog()
        if answer == true
            install_IJulia()
        end
    end

    println()
    @info "That's it. Have fun with the workshop materials! - Carsten"
    return nothing
end
