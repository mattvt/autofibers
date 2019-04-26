#'The master function for this package
#'
#'This function prompts the user to first select a .csv file containing the
#'dataframe which contains the data collected for each temperature. It then prompts
#'the user to select all of the mechanical tests. It then processes and reshapes
#'the data so that it can be easilly plotted in ggplot. It then creates the plots
#'and saves them in a specified directory.
#'
#'
#' @export
combineData <- function(n = 300, path = getwd(), condition = "condition"){

  library(plyr)
  library(smoother)
  library(reshape2)

  #choose ftirSEM file and mech tests
  ftirSemPath <- file.choose()
  mechtestsPath <- choose.files()

  #read ftirsem
  ftirSem <- read.csv(ftirSemPath)
  colnames(ftirSem)[1] <- 'temp'

  # and mechtests
  names(mechtestsPath) <- basename(mechtestsPath)
  renamed <- names(mechtestsPath)
  renamed <- substr(renamed, 1, 2)
  names(mechtestsPath) <- renamed

  allMech <- ldply(mechtestsPath, read.csv)
  allMech <- allMech[1:4]
  names(allMech) <- c('temp','time','forces','stroke')

  #Get rid of non numeric headers for each temperature
  allMech <- allMech[!is.na(as.numeric(as.character(allMech$force))),]

  # force everything back to numeric
  allMech$forces <- as.numeric(as.character(allMech$forces))
  allMech$stroke <- as.numeric(as.character(allMech$stroke))
  allMech$time <- as.numeric(as.character(allMech$time))

  allMech <- smoothEach(allMech, .01, n = n)
  allMech <- na.omit(allMech)

  # Merge allMech and ftirSem and calculate stress vs strain

  all <- merge(allMech, ftirSem, by = 'temp')
  all$stressFTIR <- all$forces/all$CSA_FTIR/1000
  all$stressSEM <- all$forces/all$CSA_SEM/1000
  all$strain <- all$stroke/12.5

#get youngs modulus and maximum strength
all <- getYMall(all)
all$index <- seq(1, dim(all)[1],1)

cond <- rep(condition, length(all$temp))
all$condition <- cond

all <- na.omit(all)

return(all)
}
