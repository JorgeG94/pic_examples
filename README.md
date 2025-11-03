# PIC examples

This repository contains a series of examples of simple uses of the routines implemented in the [pic](https://github.com/JorgeG94/pic) library.

We use the fpm to build an run the examples. Simply do `fpm run` and you'll see things go broom.

## How to install the FPM

See the instructions [here](https://fpm.fortran-lang.org/install/index.html)

If you are on a Linux distro and have any Fortran compiler installed, do:

```
git clone https://github.com/fortran-lang/fpm
cd fpm
./install.sh
```

This will put the fpm in your `$HOME/.local/bin`

## How to change the FPM config

Basically just remove my name and add yours. Also just add your project name.

To build, simply: `fpm build`

To test, `fpm test`

To see my super cool printout: `fpm run`


## CI/CD

This repo contains a very powerful CI/CD workflow based on gha3mi's work, which you can find [here](https://github.com/gha3mi/setup-fortran-conda/tree/main)


## pre-commit hooks

The repo also comes with a pre-commit that will ensure a formatting for your Fortran files. You can install pre-commits by using:

```
python3 -m pip install pre-commit
pre-commit install
```
