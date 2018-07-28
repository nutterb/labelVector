devtools::document(getwd())
devtools::test(getwd())
devtools::check(getwd())
# devtools::build_win(getwd())
# devtools::install_local(getwd(), force = TRUE)
# devtools::release(getwd())

Record$race[1]

Record$race[c(1, 9, 64, 50, 83)] <- NA

x <- Record$race
x[c(1, 9, 64, 50, 83)] <- NA
x
