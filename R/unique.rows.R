unique.rows <- function(all){

  min.all <- all
  min.all <- na.omit(min.all)
  min.all <- unique(subset(min.all, select = -c(time, index, forces,stroke,ym, strain, stressSEM, stressFTIR, dstrain, dstress )))
  min.all$wamor_or  <- min.all$amor_or  * (1-min.all$Perc_Cryst)^2
  min.all$wcryst_or <- min.all$cryst_or * min.all$Perc_Cryst^2

  return(min.all)
}
