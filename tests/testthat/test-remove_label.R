context("remove_label")

the_time <- Sys.time()
test_numeric   <- set_label(seq(1, 2, by = 0.1), "number")
test_character <- set_label(letters, "alphabet")
test_integer   <- set_label(1:10, "integer")
test_factor    <- set_label(factor(c("a", "b", "c")), "factor")
test_date      <- set_label(Sys.Date(), "date")
test_posixct   <- set_label(the_time, "time")

test_that(
  "Remove label from atomic vectors", 
  {
    expect_false("labelled" %in% class(remove_label(test_numeric)))
    expect_false("labelled" %in% class(remove_label(test_character)))
    expect_false("labelled" %in% class(remove_label(test_integer)))
    expect_false("labelled" %in% class(remove_label(test_factor)))
    expect_false("labelled" %in% class(remove_label(test_date)))
    expect_false("labelled" %in% class(remove_label(test_posixct)))
    
    expect_equal(seq(1, 2, by = 0.1), 
                 remove_label(test_numeric))
    expect_equal(letters, 
                 remove_label(test_character))
    expect_equal(1:10, 
                 remove_label(test_integer))
    expect_equal(factor(c("a", "b", "c")), 
                 remove_label(test_factor))
    expect_equal(Sys.Date(), 
                 remove_label(test_date))
    expect_equal(the_time, 
                 remove_label(test_posixct))
    
    expect_null(remove_label(NULL))
  }
)

test_that(
  "Remove label from data frames",
  {
    TestData <- data.frame(int = 1:10, 
                           char = letters[1:10], 
                           num = seq(1, 1.9, by = 0.1), 
                           stringsAsFactors = FALSE) 
    TestData <- set_label(TestData, 
                          int = "integer", 
                          char = "character")
    
    PostTest1 <- remove_label(TestData, 
                              vars = c("int", "char", "num"))
    
    expect_false("labelled" %in% class(PostTest1$int))
    expect_false("labelled" %in% class(PostTest1$char))
    expect_false("labelled" %in% class(PostTest1$num))
    
    
    PostTest2 <- remove_label(TestData, 
                              vars = c("int", "num"))
    
    expect_false("labelled" %in% class(PostTest2$int))
    expect_true("labelled" %in% class(PostTest2$char))
    expect_false("labelled" %in% class(PostTest2$num))
  }
)

test_that(
  "Argument Validation", 
  {
    # Return an error if x is not atomic
    
    expect_error(remove_label(list(a = letters)), 
                 "`x` must be an atomic vector")
    
    # Return an error if x is a data frame but vars is not character
    
    expect_error(remove_label(mtcars, 
                              1:3), 
                 "`vars` must have class `character`")
    
    # Return error if x is a data frame and vars has names not in the data frame
    
    expect_error(remove_label(mtcars, 
                              "not a valid name"), 
                 "The following are not variables in `x`: not a valid name")
  }
)
