#' @export
getYM <- function(df){

  for (i in 1:(length(df$temp)-1)){
    df$dstress[i] <- df$stressFTIR[i+6]-df$stressFTIR[i]
    df$dstrain[i] <- df$strain[i+6]-df$strain[i]
    df$ym <- df$dstress/df$dstrain
    df$ym <- smoother::smth(x = df$ym, window = 10, method = "gaussian")

    ymMax <- na.omit(df$ym)
    df$ym[length(df$ym)] <- 0

    df$ymMax <- rep(max(ymMax),nrow(df))


    #lets get max strength in this function as well

    df$UTS_FTIR <- rep(max(df$stressFTIR),nrow(df))
    df$UTS_SEM  <- rep(max(df$stressSEM) ,nrow(df))
   # df$UTS_Hyb  <- rep(max(df$stressHyb) ,nrow(df))

  }
  return(df)
}
