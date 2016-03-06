#
# functions that produce gphoto2 actions.
#divided into functions that change camera state, those that report, and those that
#return images
#
#
source("setup.R")

what.camera <- function()
{
    ret <- system("gphoto2 --auto-detect",intern=T)
    ret[-1*c(1:2)]
}

set.shutter <- function(sec=1)
{
    test <- system(paste0("gphoto2 --set-config shutterspeed=",sec),intern=T)
}

set.aperture <- function(a=1)
{
    test <- system(paste0("gphoto2 --set-config-value aperture=",a),intern=T)
}

change.resolution <- function(res=7)
{
    test <- system(paste0("gphoto2 --set-config imageformat=",res),intern=T)
}

timed.exposure <- function(sec=1,aperture=18)
{
    if (file.exists("capt0000.jpg")) unlink("capt0000.jpg")
    set.shutter("bulb")
    set.aperture(aperture)
    ret <- system(paste0("gphoto2 --set-config eosremoterelease=2 --wait-event=",sec,"s --set-config eosremoterelease=4 --wait-event-and-download=2s"),intern=T)
     retfn <- gsub("Saving file as ","",ret[grep("Saving file as",ret)])
    img <- load.image(retfn)
    unlink(retfn)
    img
                  
}

capture.preview <- function()
{
    ret <- system("gphoto2 --capture-preview",intern=T)
    img <- load.image("capture_preview.jpg")
    unlink("capture_preview.jpg")
    img
}

capture.image <- function()
{
    if (file.exists("capt0000.jpg")) unlink("capt0000.jpg")
    ret <- system("gphoto2 --capture-image-and-download",intern=T)
    retfn <- gsub("Saving file as ","",ret[grep("Saving file as",ret)])
    img <- load.image(retfn)
    unlink(retfn)
    img
}
