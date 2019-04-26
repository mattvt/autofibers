###   plot the derivitive of each plot and color by temp
#' @export
sequentialSS <- function(all, path = getwd(), name = "new"){

width <- length(unique(all$temp)) + 3


  library(ggplot2)
  library(gridExtra)

  gg <- ggplot2::ggplot(all, aes(x = strain, y = ym))+
    geom_line(size = 1.5)+
    #scale_color_brewer(palette = "RdBu", direction=-1)+
    xlab('Strain')+
    ylab('Stress (GPa)')+
    scale_x_continuous(breaks = pretty(all$strain, n = 2))+
    labs(title = "Derivitive of stress with respect to strain",
         subtitle = "",
         color = 'Temp (C)')+
    theme_minimal()+
    theme(legend.position='none', panel.spacing.x=unit(1.2, "lines"))+
    facet_grid(. ~ temp, space = "free")


 #   png(filename=paste(path,"/ymAllanneal500.png", sep = ""),
#        type="cairo",
#        units="in",
#        width=width,
#        height=2,
#        pointsize=12,
#        res=1000)

# print(gg)
#  dev.off()
  ################################
  ##### Stress Strain in a row ###
  ################################


  gg2 <- ggplot2::ggplot(all, aes(x = strain, y = stressFTIR))+
    geom_line(size = 1.5)+
   # scale_color_brewer(palette = "RdBu", direction=-1)+
    xlab('Strain')+
    ylab('Stress (GPa)')+
    scale_x_continuous(breaks = pretty(all$strain, n = 2))+
    labs(title = "Stress vs Strain for each Temp",
         subtitle = "",
         color = 'Temperature')+
    theme_minimal()+
    theme(legend.position='none', panel.spacing.x=unit(1.2, "lines"))+
    facet_grid(. ~ temp, space = "free")


#   png(filename=paste(path,"/ssAllanneal500.png", sep = ""),
#        type="cairo",
#        units="in",
#        width=width,
#        height=2,
#        pointsize=12,
#        res=1000)

#  print(gg2)
#  dev.off()

  ###################
  #Combine the two###
  ###################

  png(filename=paste(path,"/ymAndssSequential_", name, ".png", sep = ""),
      type="cairo",
      units="in",
      width=width,
      height=5,
      pointsize=12,
      res=1000)

  ggcombo <- gridExtra::grid.arrange(gg2, gg, ncol = 1)
  dev.off()
}

