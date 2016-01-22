
shinyUI(
  navbarPage(
      "GelDoc",
      tabPanel("Take the Picture",
               sidebarLayout(
                   sidebarPanel(
                       sliderInput("shutterspeed","Exposure time in sec",min=1,max=90,value=1),
                       checkboxInput("preview","Preview?",value=FALSE),
                       actionButton("shutter","Take Picture")
                   ),
                   mainPanel(
                       plotOutput("image")
                       ))
               ),
      tabPanel("Keep records",
               sidebarLayout(
                   sidebarPanel(
                       textInput("expt","Experiment",value=""),
                       selectInput("ladder","Type of ladder",choices=c("Bullseye 100bp","Mass ladder")),
                       numericInput("nrows","Number of rows on gel",value=1),
                       numericInput("nlanes","Number of lanes per row",value=13),
#                       numericInput("nsamp","Number of samples on gel",value=12),
#                       numericInput("nladder","Number of ladders on gel",value=1),
                       radioButtons("testradio","Numeric Choices",choices=1:10,inline=T),
                       radioButtons("firstsamp","Which position is lane 1?",choices=c("upper left","lower left","upper right","lower right"))
                   ),
                   mainPanel(
                       plotOutput("annoteimage")
                       ))
               )
      
  )
)
