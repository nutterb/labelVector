devtools::document(getwd())
devtools::test(getwd())
devtools::check(getwd())
devtools::check_win_release(getwd())
devtools::check_win_devel(getwd())
# devtools::install_local(getwd(), force = TRUE)
# devtools::release(getwd())

rev_dep_path <- "C:/Users/benja/Documents/GitHub/RevDepCheck"
if (file.exists(rev_dep_path)){
  devtools::build(".", path = "C:/Users/benja/Documents/GitHub/RevDepCheck")
  tools::check_packages_in_dir(rev_dep_path, 
                               reverse = TRUE)
}


