#'The master function for this package
#'
#'This function prompts the user to first select a .csv file containing the
#'dataframe which contains the ftir and SEM data collected for each temperature. It then prompts
#'the user to select all of the mechanical test csv's. It then processes and reshapes
#'the data so that it can be easilly plotted in ggplot. It then creates the plots
#'and saves them in a specified directory.
#'
#'
#'this function requires the following functions:
#'getYM, getYMall, smoothEach
#'
#' @export
combineData <- function(n = 50, path = getwd(), condition = "condition"){

  library(plyr)
  library(smoother)
  library(reshape2)
  library(stringr)

  #choose ftirSEM file and mech tests
  ftirSemPath   <- file.choose()
  mechtestsPath <- choose.files()
  ftykDataPath  <- choose.files()

  #read ftirsem
  ftirSem <- read.csv(ftirSemPath)
  colnames(ftirSem)[1] <- 'temp'

  # and mechtests
  names(mechtestsPath) <- basename(mechtestsPath)
  renamed <- names(mechtestsPath)
  renamed <- substr(renamed, 1, 2)
  names(mechtestsPath) <- renamed

  # and fityK data
  names(ftykDataPath) <- basename(ftykDataPath)
  renamedFityk <- names(ftykDataPath)
  renamedFityk <- substr(renamedFityk, 2, length(basename(ftykDataPath)) - 19)
  names(ftykDataPath) <- renamedFityk
  renamedFityk

  #Read mechtests data
  allMech <- ldply(mechtestsPath, read.csv)
  allMech <- allMech[1:4]
  names(allMech) <- c('temp','time','forces','stroke')

  #Read fityk data
  fitykData <- ldply(ftykDataPath, read.delim, header=FALSE, comment.char="#")
  fitykData <- fitykData[1:6]
  names(fitykData) <- c('Temp','Peak','Center','Height','Area','FWHM')
  fitykData$Peak <- substr(fitykData$Peak, 3, 6)

  #make new dataframe of peak data that has percent crystallinity and orientation calculated
  fitykCalcs <- getPeakAreaAll(fitykData)
  fitykCalcs$Crystallinity <- fitykCalcs$area1725/(fitykCalcs$area1725 + fitykCalcs$area1736*1.46)
  fitykCalcs$time <- substr(fitykCalcs$Temp, 4,6)

  #need to get the 1157 peak fitted in fityk first so I can do the orientation calculation


  #merge the fityk table with the imported data.frame
  ftirSem2 <- merge(ftirSem, fitykCalcs)

  #Get rid of non numeric headers for each temperature
  allMech <- allMech[!is.na(as.numeric(as.character(allMech$force))),]

  # force everything back to numeric
  allMech$forces <- as.numeric(as.character(allMech$forces))
  allMech$stroke <- as.numeric(as.character(allMech$stroke))
  allMech$time <- as.numeric(as.character(allMech$time))

  allMech <- smoothEach(allMech, .01, n = 100)
  allMech <- na.omit(allMech)

  # Merge allMech and ftirSem and calculate stress vs strain

  all <- merge(allMech, ftirSem, by = 'temp')
  all$stressFTIR <- all$forces/all$CSA_FTIR/1000
  all$stressSEM  <- all$forces/all$CSA_SEM/1000
  all$strain     <- all$stroke/12.5

#get youngs modulus and maximum strength
  all <- getYMall(all)
  all$index <- seq(1, dim(all)[1],1)

  cond <- rep(condition, length(all$temp))
  all$condition <- cond

  all <- na.omit(all)

return(all)
}
