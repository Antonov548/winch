<!-- README.md is generated from README.Rmd. Please edit that file -->

# winch

<!-- badges: start -->

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

<!-- badges: end -->

The goal of winch is to provide stack traces that combine R and C function calls. This is primarily useful for developers of R packages where a substantial portion of the code is C or C++.

## Installation

Once on CRAN, you can install the released version of winch from [CRAN](https://CRAN.R-project.org) with:

<pre class='chroma'>
<span class='nf'><a href='https://rdrr.io/r/utils/install.packages.html'>install.packages</a></span>(<span class='s'>"winch"</span>)
</pre>

Install the development version from GitHub with:

<pre class='chroma'>
<span class='k'>devtools</span>::<span class='nf'><a href='https://devtools.r-lib.org//reference/remote-reexports.html'>install_github</a></span>(<span class='s'>"r-lib/winch"</span>)
</pre>

## Example

This is an example where an R function calls into C which calls back into R, see the second-to-last entry in the trace:

<pre class='chroma'>
<span class='nf'><a href='https://rdrr.io/r/base/library.html'>library</a></span>(<span class='k'><a href='https://krlmlr.github.io/r-prof/'>winch</a></span>)

<span class='k'>foo</span> <span class='o'>&lt;-</span> <span class='nf'>function</span>() {
  <span class='nf'>winch_call</span>(<span class='k'>bar</span>)
}

<span class='k'>bar</span> <span class='o'>&lt;-</span> <span class='nf'>function</span>() {
  <span class='nf'>winch_trace_back</span>()
}

<span class='nf'>foo</span>()
<span class='c'>#&gt;                  func               ip</span>
<span class='c'>#&gt; 1  Rf_NewFrameConfirm 00007f0db4bd3480</span>
<span class='c'>#&gt; 2             Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 3        R_execMethod 00007f0db4c22550</span>
<span class='c'>#&gt; 4             Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 5        R_execMethod 00007f0db4c20e90</span>
<span class='c'>#&gt; 6             Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 7             Rf_eval 00007f0db4c1f170</span>
<span class='c'>#&gt; 8     Rf_applyClosure 00007f0db4c20090</span>
<span class='c'>#&gt; 9             Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 10       R_execMethod 00007f0db4c20e90</span>
<span class='c'>#&gt; 11            Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 12            Rf_eval 00007f0db4c1f170</span>
<span class='c'>#&gt; 13    Rf_applyClosure 00007f0db4c20090</span>
<span class='c'>#&gt; 14            Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 15         winch_call 00007f0da1aa5500</span>
<span class='c'>#&gt; 16 Rf_NewFrameConfirm 00007f0db4bd18a0</span>
<span class='c'>#&gt; 17 Rf_NewFrameConfirm 00007f0db4bd3480</span>
<span class='c'>#&gt; 18            Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 19       R_execMethod 00007f0db4c20e90</span>
<span class='c'>#&gt; 20            Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 21            Rf_eval 00007f0db4c1f170</span>
<span class='c'>#&gt; 22    Rf_applyClosure 00007f0db4c20090</span>
<span class='c'>#&gt; 23            Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 24       R_execMethod 00007f0db4c20e90</span>
<span class='c'>#&gt; 25            Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 26            Rf_eval 00007f0db4c1f170</span>
<span class='c'>#&gt; 27    Rf_applyClosure 00007f0db4c20090</span>
<span class='c'>#&gt; 28            Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 29     R_forceAndCall 00007f0db4c233a0</span>
<span class='c'>#&gt; 30           do_Rprof 00007f0db4c07b80</span>
<span class='c'>#&gt; 31            Rf_eval 00007f0db4c1d4f0</span>
<span class='c'>#&gt; 32            Rf_eval 00007f0db4c1f170</span>
<span class='c'>#&gt; 33    Rf_applyClosure 00007f0db4c20090</span>
<span class='c'>#&gt;                                        pathname</span>
<span class='c'>#&gt; 1                        /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 2                        /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 3                        /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 4                        /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 5                        /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 6                        /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 7                        /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 8                        /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 9                        /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 10                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 11                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 12                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 13                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 14                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 15 /home/kirill/git/R/r-prof/winch/src/winch.so</span>
<span class='c'>#&gt; 16                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 17                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 18                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 19                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 20                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 21                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 22                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 23                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 24                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 25                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 26                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 27                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 28                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 29                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 30                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 31                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 32                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt; 33                       /usr/lib/R/lib/libR.so</span>
<span class='c'>#&gt;  [ reached 'max' / getOption("max.print") -- omitted 99 rows ]</span>
</pre>

[`rlang::entrace()`](https://rlang.r-lib.org/reference/entrace.html) checks if winch is installed, and adds a native backtrace. This cannot be easily demonstrated in a knitr document, the output is copied from [this GitHub Actions run](https://github.com/r-prof/winch/runs/1147640026?check_suite_focus=true#step:12:169).

<pre class='chroma'>
<span class='nf'><a href='https://rdrr.io/r/base/options.html'>options</a></span>(
  error = <span class='k'>rlang</span>::<span class='k'><a href='https://rlang.r-lib.org/reference/entrace.html'>entrace</a></span>,
  rlang_backtrace_on_error = <span class='s'>"full"</span>,
  rlang_trace_use_winch = <span class='m'>1L</span>
)

<span class='k'>vctrs</span>::<span class='nf'><a href='https://vctrs.r-lib.org/reference/vec_as_location.html'>vec_as_location</a></span>(<span class='k'>quote</span>, <span class='m'>2</span>)
</pre>

    Error: Must subset elements with a valid subscript vector.
    ✖ Subscript has the wrong type `function`.
    ℹ It must be logical, numeric, or character.
    Backtrace:
        █
     1. └─vctrs::vec_as_location(quote, 2)
     2.   └─`/vctrs.so`::vctrs_as_location()
     3.     └─`/vctrs.so`::vec_as_location_opts()

## How does it work?

It’s a very crude heuristic. R’s traceback (and also profiling) infrastructure introduces the notion of a “context”. Every call to an R function opens a new context, and closes it when execution of the function ends. Unfortunately, no new context is established for native code called with [`.Call()`](https://rdrr.io/r/base/CallExternal.html) or [`.External()`](https://rdrr.io/r/base/CallExternal.html). Establishing contexts requires precious run time, this might be the reason for this omission.

To work around this limitation, the source code of all R functions along the call chain is scanned for instances of `.Call` and `.External`. The native call stack (obtained via libunwind or libbacktrace) is scanned for chunks of code outside of `libR.so` (R’s main library) – these are assumed to correspond to [`.Call()`](https://rdrr.io/r/base/CallExternal.html) or [`.External()`](https://rdrr.io/r/base/CallExternal.html). The native traces are embedded as artificial calls into the R stack trace.

## Limitations

  - The matching will not be perfect, it still may lead to quicker discovery of the cause of an error.
  - Windows only works on x64, and there the traces can be obtained only for one shared library at a time. See `winch_init_library()` for details.

-----

## Code of Conduct

Please note that the winch project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
