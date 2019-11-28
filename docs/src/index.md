# Introduction

The **Workshop Wizard** is a magical little helper who will download and
install one of [my](https://github.com/crstnbr) Julia workshops
(like [this one](https://github.com/crstnbr/JuliaWorkshop19)) for you.

Specifically, the wizard does the following:

* Download the workshop materials
* Instantiate and precompile the workshop environment
* Add IJulia to the global environment (opt-out possible)


## Usage

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
