context("print.labelled")

test_that(
  "print labelled vector",
  {
    a <- set_label(1:10, "integers")
    expect_output(
      print(a),
      "integers"
    )
  }
)
