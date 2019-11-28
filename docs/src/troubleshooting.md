# Troubleshooting

## IJulia/Jupyter installation

This is the part of the installation that is most likely to fail since IJulia
depends on Jupyter and therefore Python.

Generally, the IJulia installation strategy is to check if there is a system-wide
python available. If yes, it tries to install jupyter there. If not, it installs
a boxed mini python (through [Conda.jl](https://github.com/JuliaPy/Conda.jl)).

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

In this case I recommend you install a global python separately and then use the
steps explained above ([IJulia can't find my global python](@ref)).

On linux, you should use your package manager to install python and jupyter.

On windows, you can install [Anaconda](https://www.anaconda.com/distribution/).

For more information check out the [Jupyter documentation](https://jupyter.readthedocs.io/en/latest/install.html).
