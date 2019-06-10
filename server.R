library(shiny)
source("camera-control.R")

shinyServer(function(input, output,session) {
    rValues = reactiveValues(img = NULL)
    observeEvent(input$shutter,
    {
        
        output$image <- renderPlot({
            isolate({
                print(input$shutterspeed)
                if (input$preview)
                {
                    print("preview")
                    change.resolution(7)
                } else {change.resolution(5)}
                rValues$img <- timed.exposure(sec=input$shutterspeed,aperture=input$aperture) #assign image to global variable
                plot(rValues$img,asp=1)
            })
        },height=600,width=800)
    })

    output$annoteimage <- renderPlot({
        plot(rValues$img)
    },height=600,width=800)

    observeEvent(input$exitbtn,
                 {
                     stopApp()
                 })

    observeEvent(input$savebtn,
    {
        dir=ifelse(input$who=="unPAK",
                   "/home/strandlab/GoogleDrive/images/",
                   "/home/strandlab/GoogleDrive/moleCore/")
        dir=NULL
        if (input$who=="unPAK")
            dir= "/home/strandlab/GoogleDrive/images/"
        if (input$who=="MolecCore")
            dir= "/home/strandlab/GoogleDrive/molecCore/"
        if (input$who=="JamDNA")
            dir= "/home/strandlab/GoogleDrive/molecCore/The_Jam_DNA/"
        filename <- paste0(dir,gsub("/","_",input$expt),".jpg")
        print(filename)
        save.image(im=rValues$img,file=filename)
        print("file saved")
    })
})
