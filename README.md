# WorkshopWizard.jl


> Pay no attention to that man behind the curtain. - The Wizard of Oz


| **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
| [![][docs-dev-img]][docs-dev-url] | [![][github-ci-img]][github-ci-url] [![][codecov-img]][codecov-url] |

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://carstenbauer.github.io/WorkshopWizard.jl/dev
[github-ci-img]: https://github.com/carstenbauer/WorkshopWizard.jl/workflows/Run%20tests/badge.svg
[github-ci-url]: https://github.com/carstenbauer/WorkshopWizard.jl/actions?query=workflow%3A%22Run+tests%22
[codecov-img]: https://img.shields.io/codecov/c/github/carstenbauer/WorkshopWizard.jl/master.svg?label=codecov
[codecov-url]: http://codecov.io/github/carstenbauer/WorkshopWizard.jl?branch=master

A magical little helper who will download and install [one of my Julia workshops](http://www.carstenbauer.eu/#workshops) for you.

For disbelievers (and troubleshooting) there is a [documentation](https://carstenbauer.github.io/WorkshopWizard.jl/dev).

## Usage

To quickly get the latest workshop, install the wizard (copy-paste the following into the Julia REPL)

```julia
] add https://github.com/carstenbauer/WorkshopWizard.jl
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

![wizard demo](https://raw.githubusercontent.com/carstenbauer/WorkshopWizard.jl/master/demo/wizard.gif)
