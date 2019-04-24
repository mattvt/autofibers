#########################
###   Master Plots  #####
#########################
#' @export
masterPlots <- function(df, path = getwd()){

#  library(ggplot2)

ssOverlay(df, path = path)
ym_UTSVStemp(df, path = path)
sequenctial_SS_YM(df, path = path)

}
