## Test environments
* Ubuntu 4.4.0-103-generic, R 3.4.3
* ubuntu 14.04.5 (on travis-ci), R 3.4.2
* win-builder devel (2017-09-12 r73242)

## R CMD check results
Thank you for providing such a useful review.  I have quoted the package names in 
the description. I have also added extraction and replacement methods for the 
labelled class, as well as additional tests to ensure the desired behavior.

This is the initial release of a new package.  This package is necessitated by recent
changes to the 'Hmisc' package, which no longer exports methods I have been using 
in the 'redcapAPI' and 'lazyWeave' packages.  I will update those two packages using 
the methods provided in this package.

Check results indicated Hmisc and labelVector could be misspelled words.  These are
package names and are correctly spelled.

## Downstream dependencies
There are no downstream dependencies for this package at this time.