using WorkshopWizard
using Test, Pkg

function with_temp_env(f, env_name::AbstractString = "Dummy"; rm = true)
    prev_active = Base.ACTIVE_PROJECT[]
    env_path = joinpath(mktempdir(), env_name)
    Pkg.generate(env_path)
    Pkg.activate(env_path)
    if length(LOAD_PATH) == 3
        deleteat!(LOAD_PATH, 2)
        deleteat!(LOAD_PATH, 2)
    end
    try
        applicable(f, env_path) ? f(env_path) : f()
    finally
        Base.ACTIVE_PROJECT[] = prev_active
        try
            rm && Base.rm(env_path; force = true, recursive = true)
        catch err
            # Avoid raising an exception here as it will mask the original exception
            println(
                Base.stderr,
                "Exception in finally: $(sprint(showerror, err))",
            )
        end
        push!(LOAD_PATH, "@v#.#")
        push!(LOAD_PATH, "@stdlib")
    end
end

function test_load_pkg(pkg::Symbol)
    try
        @eval import $pkg
        return true
    catch
        return false
    end
end

function rm_global_IJulia()
    WorkshopWizard.with_pkg_env("", globalenv = true) do
        pkg"rm IJulia"
    end
end

@testset "WorkshopWizard.jl" begin

    @testset "Defaults" begin

        _, latest = findmax(map(
            w -> parse(Int, w[end-1:end]),
            WorkshopWizard.WORKSHOPS,
        ))
        latest_workshop = WorkshopWizard.WORKSHOPS[latest]
        @test WorkshopWizard.default_workshop() == latest_workshop
        @test WorkshopWizard.default_repo() == "https://github.com/crstnbr/$(latest_workshop)"
        if Sys.iswindows()
            @test WorkshopWizard.default_path() == joinpath(
                homedir(),
                "Desktop",
            )
        elseif Sys.islinux()
            @test WorkshopWizard.default_path() == homedir()
        else
            @test WorkshopWizard.default_path() == homedir()
        end
    end

    @testset "IJulia" begin
        with_temp_env() do
            @test WorkshopWizard._check_IJulia() == false
            WorkshopWizard.install_IJulia()
            @test WorkshopWizard._check_IJulia() == true
            with_temp_env() do
                @test WorkshopWizard._check_IJulia() == true
            end
            rm_global_IJulia()
        end
    end

    @testset "Download" begin
        cd(mktempdir()) do
            WorkshopWizard.download(
                repo = "https://github.com/crstnbr/JuliaTestWorkshop",
                path = pwd(),
            )
            @test isdir("JuliaTestWorkshop")
            @test isfile("JuliaTestWorkshop/README.md")
        end
    end

    @testset "Install" begin
        cd(mktempdir()) do
            WorkshopWizard.install(
                repo = "https://github.com/crstnbr/JuliaTestWorkshop",
                path = pwd(),
            )
            @test isdir("JuliaTestWorkshop")
            @test isfile("JuliaTestWorkshop/README.md")
            @test test_load_pkg(:IJulia)
            WorkshopWizard.with_pkg_env("JuliaTestWorkshop") do
                @test test_load_pkg(:IJulia)
                @test test_load_pkg(:Colors)
                @test test_load_pkg(:BenchmarkTools)
                @test test_load_pkg(:GenericLinearAlgebra)
            end
            rm_global_IJulia()
        end
    end

end # main
