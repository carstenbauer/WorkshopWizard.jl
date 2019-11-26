using WorkshopTools
using Test, Pkg

function with_temp_env(f, env_name::AbstractString="Dummy"; rm=true)
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
            println(Base.stderr, "Exception in finally: $(sprint(showerror, err))")
        end
        push!(LOAD_PATH, "@v#.#")
        push!(LOAD_PATH, "@stdlib")
    end
end

function with_pkg_env(fn::Function, path::AbstractString="."; change_dir=false)
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

function test_load_pkg(pkg::Symbol)
    try
        @eval import $pkg
        return true
    catch
        return false
    end
end

@testset "WorkshopTools.jl" begin

    @testset "Defaults" begin
        @test WorkshopTools.default_workshop() == "JuliaOulu2020"
        @test WorkshopTools.default_repo() == "https://github.com/crstnbr/JuliaOulu2020"
        if Sys.iswindows()
            @test WorkshopTools.default_path() == joinpath(homedir(), "Desktop")
        elseif Sys.islinux()
            @test WorkshopTools.default_path() == homedir()
        else
            @test WorkshopTools.default_path() == homedir()
        end
    end

    @testset "IJulia" begin
        with_temp_env() do
            @test WorkshopTools._check_IJulia() == false
            WorkshopTools.install_IJulia()
            @test WorkshopTools._check_IJulia() == true
        end
    end

    @testset "Download" begin
        cd(mktempdir()) do
            WorkshopTools.download(
                repo = "https://github.com/crstnbr/JuliaTestWorkshop",
                path = pwd(),
            )
            @test isdir("JuliaTestWorkshop")
            @test isfile("JuliaTestWorkshop/README.md")
        end
    end

    @testset "Install" begin
        cd(mktempdir()) do
            WorkshopTools.install(
                repo = "https://github.com/crstnbr/JuliaTestWorkshop",
                path = pwd(),
            )
            @test isdir("JuliaTestWorkshop")
            @test isfile("JuliaTestWorkshop/README.md")
            with_pkg_env("JuliaTestWorkshop") do
                @test test_load_pkg(:Colors)
                @test test_load_pkg(:BenchmarkTools)
                @test test_load_pkg(:GenericLinearAlgebra)
            end
        end
    end

end # main
