#Get the youngs modulus of each sample
#' @export
getYMall <- function(allMech){

  indi <- unique(allMech$temp)

  y <- data.frame()
  x <- data.frame()

  for (i in 1:length(indi)){

     x <- allMech[allMech$temp == indi[i],]
     xym <- getYM(x)
     y <- rbind(y,xym)

  }

  return(y)
}
