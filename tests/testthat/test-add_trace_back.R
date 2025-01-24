test_that("traceback unchanged if no native code", {
  skip_if_not(winch_available())
  skip_if_not_installed("rlang")
  skip_if(packageVersion("rlang") >= "1.0.3")

  trace <- rlang::trace_back()
  expect_identical(unclass(winch_add_trace_back(trace)), unclass(trace))
})

test_that("traceback changed if native code", {
  skip_if_not(winch_available())
  skip_if_not_installed("rlang", "0.99.0.9000")

  foo <- function(fun) {
    winch_call(fun)
  }

  bar <- function() {
    rlang::trace_back()
  }

  baz <- function() {
    winch_add_trace_back(rlang::trace_back())
  }

  foo_bar <- foo(bar)
  foo_baz <- foo(baz)

  expect_false(identical(foo_bar, foo_baz))
  expect_true(any(grepl("/winch", foo_baz$namespace)))

  # Tests show different output on CI for some reason
  skip_on_ci()

  expect_snapshot({
    foo_baz
    as.data.frame(foo_baz)
  })
})


test_that("traceback changed if native code (rlang < 1.0.0)", {
  skip_if_not(winch_available())
  skip_if(packageVersion("rlang") > "0.99")

  foo <- function(fun) {
    winch_call(fun)
  }

  bar <- function() {
    rlang::trace_back()
  }

  baz <- function() {
    winch_add_trace_back(rlang::trace_back())
  }

  foo_bar <- foo(bar)
  foo_baz <- foo(baz)

  expect_false(identical(foo_bar, foo_baz))
  expect_true(any(grepl("/winch", foo_baz$calls)))
})
