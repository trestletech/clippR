#' @import htmlwidgets
#' @export
clippy <- function(agent="Clippy", width=NULL, height=NULL) {
  htmlwidgets::createWidget("shinyClip", list(agent=agent), width = width, height = height)
}

#' @export
clippyOutput <- function(outputId, width = "100%", height = "400px") {
  shinyWidgetOutput(outputId, "shinyClip", width, height, package = "shinyClip")
}
#' @export
renderClippy <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, clippyOutput, env, quoted = TRUE)
}
