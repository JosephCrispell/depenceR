# dependenceR
`dependenceR` is a _work in progress_ and is designed to be a package that helps
you map your R file(s) dependencies for packages and functions. Hopefully it'll
be a lot like [`pkgnet`](https://uptake.github.io/pkgnet/) but it will work on
single or multiple R files, whereas pkgnet is designed to map the dependencies
of an R package.

## Tasks:
- TODO document packages and functions loaded/created/called in R files
- TODO add unit tests
- TODO retrieve all functions for packages loaded
- TODO identify all function calls in R files
- TODO map called functions back to their source
- TODO report package and function dependencies

# Repository structure
The current repository has the following structure (standard R package setup
with additional pre-commit workflow)
```
📦dependenceR
 ┣ 📂R/
 ┣ 📂man/ # function docs
 ┣ 📜.gitignore
 ┣ 📜.pre-commit-config.yaml # precommit workflow
 ┣ 📜LICENSE
 ┣ 📜README.md
 ┣ 📜DESCRIPTION
 ┣ 📜NAMESPACE
 ┗ 📜setup.py
```

# Development
## Unit tests

`dependenceR` is set up with unit tests using the
[`testthat`](https://testthat.r-lib.org/) R package. To run the tests you'll
need the following packages installed:
- [`testthat`](https://testthat.r-lib.org/) - building and running unit tests
- [`devtools`](https://www.r-project.org/nosvn/pandoc/devtools.html) - for package development
- [`usethis`](https://usethis.r-lib.org/) - automating package and project setup

Then you can use `devtools::test()` in `dependenceR``s root directory to run the tests.

Building unit tests in R is very new to me and I have found the following resources useful so far:
- [Unit testsing basics](https://usethis.r-lib.org/)
- [Getting started with unit testing in R](https://www.pipinghotdata.com/posts/2021-11-23-getting-started-with-unit-testing-in-r/)


## `precommit` installation ✔

Install python [`pre-commit`](https://pre-commit.com/) with:
```bash
pip install pre-commit
```

Within repository folder run to install hooks:
```bash
pre-commit install
```
