## Test environments
* Ubuntu 4.4.0-103-generic, R 3.4.3
* ubuntu 14.04.5 (on travis-ci), R 3.4.2
* win-builder (devel)

## R CMD check results
This is the initial release of a new package.  This package is necessitated by recent
changes to the `Hmisc` package, which no longer exports methods I have been using 
in the `redcapAPI` and `lazyWeave` packages.  I will update those two packages using 
the methods provided in this package.

## Downstream dependencies
There are no downstream dependencies for this package at this time.