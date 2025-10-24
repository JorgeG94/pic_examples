# modern-fortran-project
A template repository for modern fortran projects

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

## Using your template repo in another project.

This repo will install everything CMake needs to find the project. THe only thing you need to set is  `YOUR_PROJECT_NAME_ROOT=/path/to/install/location`

And in your new project set `find_package(demo REQUIRED)`

To then link to demo, you can simply add `demo::demo` to you `target_link_libraries(${tgt} PRIVATE demo::demo)`
