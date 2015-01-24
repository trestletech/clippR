library(shiny)
library(shinyClip)

#' Define server logic required to generate a simple tree
#' @author Jeff Allen \email{jeff@@trestletech.com}
shinyServer(function(input, output, session) {
  output$clip <- renderClippy({
    input$slider
    clippy(agent="Clippy")
  })
})
