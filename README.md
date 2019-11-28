# WorkshopWizard


> Pay no attention to that man behind the curtain. - The Wizard of Oz


| **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
| [![][docs-dev-img]][docs-dev-url] | [![][github-ci-img]][github-ci-url] [![][codecov-img]][codecov-url] |

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://crstnbr.github.io/WorkshopWizard.jl/dev
[github-ci-img]: https://github.com/crstnbr/WorkshopWizard.jl/workflows/Run%20tests/badge.svg
[github-ci-url]: https://github.com/crstnbr/WorkshopWizard.jl/actions?query=workflow%3A%22Run+tests%22
[codecov-img]: https://img.shields.io/codecov/c/github/crstnbr/WorkshopWizard.jl/master.svg?label=codecov
[codecov-url]: http://codecov.io/github/crstnbr/WorkshopWizard.jl?branch=master

A magical little helper who will download and install [one](http://github.com/crstnbr/JuliaWorkshop18) [of](http://github.com/crstnbr/JuliaWorkshop19) [my](http://github.com/crstnbr/JuliaOulu20) Julia workshops for you.

The wizard does

* download the workshop materials,
* instantiate and precompile the workshop environment,
* add IJulia to the global environment (opt-out possible).

The default download path is the desktop (on windows) or the home directory (on linux/macOS).

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

For disbelievers (and troubleshooting) there is a [documentation](https://crstnbr.github.io/WorkshopWizard.jl/dev).

## Demonstration

### Standard

![wizard demo](https://github.com/crstnbr/WorkshopWizard.jl/blob/master/demo/wizard.gif)

### Custom

![wizard demo](https://github.com/crstnbr/WorkshopWizard.jl/blob/master/demo/wizard_detailed.gif)
