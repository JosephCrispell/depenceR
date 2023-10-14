# dependenceR
`dependenceR` is a _work in progress_ and is designed to be a package that helps
you map your R file(s) dependencies for packages and functions. Hopefully it'll
be a lot like [`pkgnet`](https://uptake.github.io/pkgnet/) but it will work on
single or multiple R files, whereas pkgnet is designed to map the dependencies
of an R package.

## Tasks:
- TODO document packages and functions loaded/created/called in R files
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

# `precommit` installation ✔

Install python [`pre-commit`](https://pre-commit.com/) with:
```bash
pip install pre-commit
```

Within repository folder run to install hooks:
```bash
pre-commit install
```
