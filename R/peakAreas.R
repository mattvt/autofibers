#this function gets the peak area for one peak

getPeakArea <- function(data.frame, peak){

  indi <- unique(data.frame$Temp)
  peakx <- data.frame[data.frame$Peak == peak,]
  y <- data.frame()
  x <- data.frame()

  for (i in 1:length(indi)){
    x <- peakx[peakx$Temp == indi[i],]
    sum <- sum(x$Area)
    y <- rbind(y, sum)
  }

names(y) <- paste("area",peak, sep = "")
return(y)
}

#this function gets the area for all the peaks, using the above function
getPeakAreaAll <- function(data.frame){

  indi <- unique(data.frame$Peak)
  y <- data.frame(unique(data.frame$Temp))
  names(y) <- "Temp"
  x <- data.frame()

  for (i in 1:length(indi)){
    x <- data.frame[data.frame$Peak == indi[i],]
    x <- getPeakArea(x, indi[i])
    y <- cbind(y,x)
  }
#y <- y[1:length(unique(data.frame$Peak))]
return(y)
}
