#' Execute \pkg{pkgdown} build_site in a package
#'
#' `build_site()` is a shortcut for [pkgdown::build_site()], it generates the
#'   static HTML documentation.
#'
#' @param path path to the package to build the static HTML.
#' @param ...  additional arguments passed to [pkgdown::build_site()]
#' @inheritParams install
#'
#' @return NULL
#' @export
build_site <- function(path = ".", quiet = TRUE, ...) {
  check_suggested("pkgdown")

  save_all()

  pkg <- as.package(path)

  check_dots_used()

  withr::with_temp_libpaths(action = "prefix", code = {
    install(pkg = pkg$path, upgrade = "never", reload = FALSE, quiet = quiet)
    if (isTRUE(quiet)) {
      withr::with_output_sink(
        tempfile(),
        pkgdown::build_site(pkg = pkg$path, ...)
      )
    } else {
      pkgdown::build_site(pkg = pkg$path, ...)
    }
  })
}
