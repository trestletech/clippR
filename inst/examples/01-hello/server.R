library(shiny)
library(shinyClip)
library(grid)
library(ggplot2)
library(ggthemes)

#' Define server logic required to generate a simple tree
#' @author Jeff Allen \email{jeff@@trestletech.com}
shinyServer(function(input, output, session) {
  output$clip <- renderClippy({
    clippy(agent="Clippy")
  })

  output$plot <- renderPlot({
    if (is.null(input$plotClick)){
      return(doPlot(c(1,1,1,1)))

    }

    updateClippy(session, "clip", "Are you trying to adjust the margins? Here, let me help you.")
    doPlot(runif(4, 0, 5))
  })

  observe({

  })

  # Drop down observer
  observe({
    if (input$sel != "Slider"){
      updateSelectInput(session, "sel", selected="Slider")
      updateClippy(session, "clip", "I only know how to help you with sliders. I'll reset the selection for you.")
    }
  })

  # Slider observer
  # Don't want to redundantly update after our 'updateSlider' call.
  suppressSliderUpdate <- TRUE
  observe({
    input$slider

    if (suppressSliderUpdate){
      suppressSliderUpdate <<- FALSE
      return()
    }

    updateClippy(session, "clip", "Hi! It looks like you're trying to adjust a slider. I'll round it down to the nearest multiple of 13 for you.")

    mult <- input$slider - input$slider%%13
    updateSliderInput(session, "slider", value=mult)
    suppressSliderUpdate <<- TRUE
  })
})

doPlot <- function(marg){
  dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
  (qplot(carat, price, data=dsamp, colour=cut)
  + theme_excel()
  + scale_colour_excel()
  + theme(plot.margin = unit(marg, "cm")))
}

updateClippy <- function(session, id, speak){
  msg <- dropNulls(list(
    id=id,
    speak=speak
  ))
  session$sendCustomMessage("shinyClip", msg)
}

# From shiny:::dropNulls
dropNulls <- function(x){
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}
