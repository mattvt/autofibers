#smooth each temp individually then rbin
#' @export
smoothEach <- function(allMech, wind){
  indi <- unique(allMech$temp)

  y <- data.frame(temp = NA, time = NA, forces = NA, stroke = NA)
  x <- data.frame()

  for (i in 1:length(indi)){
    x <- allMech[allMech$temp == indi[i],]
    x$forces = smoother::smth(x = x$forces, window = wind, method = "gaussian")
    x$stroke = smoother::smth(x$stroke, window = wind, method = "gaussian")
    xr <- x[!is.na(x$forces),]
    scale <- min(xr$forces)
    xr$forces <- xr$forces-scale
    y <- rbind(y,xr)
  }

  return(y)

}

