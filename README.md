# WorkshopWizard

[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://crstnbr.github.io/WorkshopWizard.jl/dev)
[![github-ci](https://github.com/crstnbr/WorkshopWizard.jl/workflows/Run%20tests/badge.svg)](https://github.com/crstnbr/WorkshopWizard.jl/actions?query=workflow%3A%22Run+tests%22)
[![codecov][codecov-img]](http://codecov.io/github/crstnbr/WorkshopWizard.jl?branch=master)

[codecov-img]: https://img.shields.io/codecov/c/github/crstnbr/WorkshopWizard.jl/master.svg?label=codecov

A magical little helper who will download and install one of my Julia workshops for you.

To quickly get the latest workshop, install the wizard

```julia
] add https://github.com/crstnbr/WorkshopWizard.jl
```

and start the magic

```julia
using WorkshopWizard
WorkshopWizard.run_wizard()
```

That's it!

For disbelievers there is a [documentation](https://crstnbr.github.io/WorkshopWizard.jl/dev).

## Demonstration

### Standard

![wizard demo](https://github.com/crstnbr/WorkshopWizard.jl/blob/master/demo/wizard.gif)

### Custom

![wizard demo](https://github.com/crstnbr/WorkshopWizard.jl/blob/master/demo/wizard_detailed.gif)
