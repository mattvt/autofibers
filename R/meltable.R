
#return a meltable dataframe without any of the time dependent studd
#' @export
meltable <- function(df){

minusSS <- unique(subset(df, select = -c(time, forces,stroke,ym, strain, stressSEM, stressFTIR, stressHyb, dstrain, dstress )))
minusSS <- plyr::melt(minusSS)
return(minusSS)
}
