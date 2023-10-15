# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

# Check out https://r-pkgs.org/testing-basics.html as a helpful resource to get
# started

# To run unit tests for dependenceR I am using devtools::test() in RStudio with
# dependenceR as my working directory

library(testthat)
library(dependenceR)

test_check("dependenceR")
