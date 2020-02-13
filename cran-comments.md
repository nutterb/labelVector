## Test environments
* Ubuntu 4.4.0-103-generic, R 3.6.1
* win-builder release (R 3.6.2)
* win-builder devel (2018-07-23 r75001)

## R CMD check results

This release stops the use of `NULL` in `structure` calls.

There were no errors, warnings, or notes returned by the checks on any of the 
three systems listed above.

## Downstream dependencies

There are no errors, warnings, or notes returned by `lazyWeave` or `pixiedust`. 

The check for `redcapAPI` returned a message about unused dependencies declared in the 
Imports field. I have corrected this problem in `redcapAPI` and will submit it shortly.

Many thanks
