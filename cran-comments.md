## Test environments
* win-builder release (R version 4.1.1 (2021-08-10))
* win-builder devel (2021-10-07 r81018)

## R CMD check results

There were no errors, warnings, or notes returned by the checks on any of the 
three systems listed above.

This also addresses a NOTE on the CRAN checks about lazyData being used with no 
data directory.  I've removed the lazyData setting in the DESCRIPTION file.

Lastly, this addresses a failed test that occurs in the development CRAN checks, 
as was reported to me in an e-mail on 26 Sept.

## Downstream dependencies

There are no errors, warnings, or notes returned by `lazyWeave`.

The reverese depedency check for `pixiedust` shows a NOTE about LazyData 
being specified without a data directory. This is unrelated to `labelVector` 
and I will correct it in a future submission of `pixiedust`.. 

The reverse dependency check for `redcapAPI` shows a NOTE about imports not 
being used. This is unrelated to `labelVector` and I will correct that in a
future submission of `redcapAPI`.

Many thanks
