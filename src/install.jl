using LibGit2

"""
    download(; repo = default_repo(), path = default_path())

Download a workshop from github.

Keyword arguments `repo` and `path` can be used to specify the github repository
and the local installation directory.
"""
function download(
    ;
    repo = default_repo(),
    path = default_path(),
    auto_overwrite = false,
)
    if !occursin("github.com", repo)
        repo = joinpath(GITHUB_BASEURL, repo)
    end
    workshop = basename(repo)
    target = joinpath(path, workshop)

    # overwrite?
    if isdir(target)
        if auto_overwrite
            answer = true
        else
            @info "Target directory $(target) already exists. Should I overwrite?"
            answer = yes_no_dialog()
        end

        if answer == true
            rm(target, force = true, recursive = true)
        else
            @info "Aborting."
            return false
        end
    end

    @info "Downloading \"$workshop\" to $target"
    LibGit2.clone(repo, target)
    return true
end

"""
    install(; repo = default_repo(), path = default_path(), check_IJulia = true, auto_overwrite = true)

More programmatic workshop installation interface.

By default, the workshop will be downloaded to the desktop (on windows)
or the home directory (on linux/macOS). The installation path
can be adjusted per keyword argument `path = desired/install/path`.
"""
function install(
    ;
    repo = default_repo(),
    path = default_path(),
    check_IJulia = true,
    auto_overwrite = true,
)
    success = download(
        repo = repo,
        path = path,
        auto_overwrite = auto_overwrite,
    )
    !success && (return false)
    _install_dependencies(joinpath(path, basename(repo)))
    workshop_dir = joinpath(path, basename(repo))
    @info "Workshop successfully installed to $(workshop_dir)."

    if check_IJulia && (_check_IJulia() == false)
        @info "Couldn't find IJulia."
        install_IJulia()
    end
    return true
end

function _install_dependencies(workshop_path)
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
    run_wizard()

Start the workshop installation wizard. It will interactively guide you through
the selection, download, and installation of a Julia workshop.

If not already present, the wizard will also install IJulia.
"""
function run_wizard()
    @info "Welcome to the workshop installation wizard."

    # default settings?
    @info "Should I download and install the $(default_workshop()) workshop with default settings?"
    answer = yes_no_dialog()
    if answer == true
        success = install(
            repo = default_repo(),
            path = default_path(),
            check_IJulia = true,
            auto_overwrite = false,
        )
    else
        success = _install_interactive()
    end

    !success && (return nothing)
    println()
    @info "That's it. Start the notebook server with \"using IJulia; notebook()\" and take it away."
    @info "Have fun with the workshop material!"
    println()
    println("- The Workshop Wizard")
    return nothing
end


function _install_interactive()
    # workshop selection
    @info "Please select a workshop:"
    workshop = workshop_selector()
    if isnothing(workshop)
        @info "No workshop selected. Aborting."
        return false
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
    success = install(
        repo = joinpath(GITHUB_BASEURL, workshop),
        path = path,
        auto_overwrite = false,
    )
    !success && (return false)

    IJulia_found = _check_IJulia()
    if !IJulia_found
        println()
        @info "You don't seem to have IJulia installed, which is necessary for the workshop."
        @info "Should I install it for you?"
        answer = yes_no_dialog()
        if answer == true
            success = install_IJulia()
            !success && (return false)
        end
    else
        @info "Skipping IJulia (already installed)."
    end
    return true
end
