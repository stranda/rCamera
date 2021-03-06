
shinyUI(
  navbarPage(
      "GelDoc",
      tabPanel("Take the Picture",
               sidebarLayout(
                   sidebarPanel(
                       selectInput("aperture","Camera aperture",choices=c(16,18,20,22,25,29)),
                       sliderInput("shutterspeed","Exposure time in sec",min=1,max=90,value=3),
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
#                       radioButtons("who","Where is this image housed?",choices=c("unPAK","Molec. Core")),
                       selectInput("who","Where is this image housed?",choices=c("unPAK","MolecCore","JamDNA")),
                       textInput("expt","Experiment",value=""),
                       selectInput("ladder","Type of ladder",choices=c("Bullseye 100bp","Mass ladder")),
                       numericInput("nrows","Number of rows on gel",value=1),
                       numericInput("nlanes","Number of lanes per row",value=13),
#                       numericInput("nsamp","Number of samples on gel",value=12),
#                       numericInput("nladder","Number of ladders on gel",value=1),
#                       radioButtons("testradio","Numeric Choices",choices=1:10,inline=T),
                       radioButtons("firstsamp","Which position is lane 1?",
                                    choices=c("upper left","lower left","upper right","lower right")),
                       actionButton("savebtn","Save image (uses experiment name above as name)"),
                       actionButton("exitbtn","Push to stop app")
                   ),

                   mainPanel(
                       plotOutput("annoteimage")
                       ))
               )
      
  )
)
