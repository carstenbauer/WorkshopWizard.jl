# Troubleshooting

## IJulia/Jupyter installation

This is the part of the installation that is most likely to fail since IJulia
depends on Jupyter and therefore Python.

Generally, the IJulia installation strategy is to check if there is a system-wide
python available. If that's the case, it tries to install jupyter there. If not, it installs
a boxed mini python (through [Conda.jl](https://github.com/JuliaPy/Conda.jl)).
You can trigger the IJulia installation by

```
using Pkg
Pkg.add("IJulia")
```

as I show in this [youtube video](https://www.youtube.com/watch?v=4Rnm0n39DCs).

### IJulia can't find my global python

In this case, fire up Julia and enter
```
ENV["PYTHON"] = "path/to/python"
```
where `path/to/python` is the path to you python installation. Note that the path
should include the executable as well! Hence, on windows, it is `path/to/python.exe`
and **not** just `path/to/`.

Afterwards, rebuild IJulia (or `] add IJulia` if you haven't tried to install it)

```
using Pkg
Pkg.build("IJulia")
```

### IJulia fails to install a mini python

In this case I recommend to install a global python separately and then use the
steps explained above ([IJulia can't find my global python](@ref)).

On linux, you should use your package manager to install python and jupyter.

On windows, you can install [Anaconda](https://www.anaconda.com/distribution/).

For more information check out the [Jupyter documentation](https://jupyter.readthedocs.io/en/latest/install.html).


## Manual installation of a workshop

If, for some reason, the WorkshopWizard doesn't work for you, you can use these manual instructions
to install a workshop manually. We will demonstrate the necessary stepts for the `JuliaOulu20` workshop.

### Downloading the workshop

If you have `git` installed, just `git clone https://github.com/crstnbr/JuliaOulu20`. If you don't have `git` installed, or can't access it from the commmand line, start a fresh Julia instance and run
```
using LibGit2
LibGit2.clone("https://github.com/crstnbr/JuliaOulu20", "some/where/on/my/computer/JuliaOulu20")
```
where you replace `some/where/on/my/computer/` with a download path to your liking.

### Installing and precompiling the dependencies

Open up a Julia REPL and navigate to the `JuliaOulu20` directory
```
cd("some/where/on/my/computer/JuliaOulu20")
```
We now install all Julia package dependencies (*instantiate* the workshop's Julia environment)
and precompile them by running the following snippet

```
using Pkg
pkg"activate ."
pkg"instantiate"
pkg"precompile" # this may take a while
pkg"activate"
```

### Making IJulia globally available

You probably want to add IJulia to the global Julia environment, typically called `v1.x`.
To do this, start a fresh Julia REPL (or `] activate`) and execute

```
] add IJulia
```

If you have [installed and precompiled the workshop dependencies](@ref Installing and precompiling the dependencies)
before this should take almost no time, since IJulia is already installed. It just needs
to be added to the environment.

Things are set up correctly if you can start the notebook server in a fresh Julia REPL with

```
using IJulia
notebook()
```
