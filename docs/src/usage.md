# Usage

In this section we describe how to use the WorkshopWizard.

## Getting the latest workshop

To quickly get the latest workshop, install the wizard

```julia
] add https://github.com/crstnbr/WorkshopWizard.jl
```

and start the magic

```julia
using WorkshopWizard
WorkshopWizard.run_wizard()
```

That's it! You can now start the Jupyter notebook server and dive into the workshop materials:

```julia
using IJulia
notebook()
```

The default download path is the desktop, on windows, or the home directory, on linux/macOS.

## Demonstration

![wizard demo](https://raw.githubusercontent.com/crstnbr/WorkshopWizard.jl/master/demo/wizard.gif)


## Unattended installation

If you want to install the latest workshop without interactivity you can use
[`WorkshopWizard.install()`](@ref):

```@setup install
using Pkg;
pkg" add https://github.com/crstnbr/WorkshopWizard.jl/"
```

```@repl install
using WorkshopWizard
WorkshopWizard.install();
```

```jldoctest
using Pkg;
pkg" add https://github.com/crstnbr/WorkshopWizard.jl/"
using WorkshopWizard
WorkshopWizard.install();
isdir(joinpath(WorkshopWizard.default_path(), WorkshopWizard.default_workshop()))

# output

true
```
