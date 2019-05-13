# ```{r Anneal Regressions}
# all.UTS <- lm(UTS_FTIR ~ Perc_Cryst, data = min.all)
# summary(all.UTS)
# model_fit_stats(all.UTS)
# ```

#
#
# ```{r Quench Plot, echo = FALSE}
# gg <- ggplot(min.quench, aes(x = Perc_Cryst, y = UTS_FTIR))+
#   geom_point()+
#   geom_smooth(method = lm, formula = y ~ poly(x, 3, raw = TRUE))+
#   xlab("Crystallinity")+
#   ylab("UTS (GPa)")+
#   theme_minimal()
# gg
# ```
#
# ```{r Quench Qegressions}
# quench.UTS <- lm(UTS_FTIR ~ poly(Perc_Cryst , 3, raw = TRUE), data = min.quench)
# summary(quench.UTS)
# model_fit_stats(quench.UTS)
# ```


#
# ```{r PCA, echo = FALSE}
# pca.all <- subset(min.all, select = c(Perc_Cryst, amor_or, cryst_or, tot_or))
# ```
#
# ```{r PCA cont., echo = TRUE}
# pca.all.df  <- prcomp(pca.all, scale = TRUE, center = TRUE)
# ```
#
# ```{r PCA cont2., echo = FALSE}
# pca.all.values <- data.frame(pca.all.df$x, Condition = min.all$condition, temp <- min.all$temp, UTS <- min.all$UTS_FTIR)
# pca.all.loadings <- data.frame(Variables = rownames(pca.all.df$rotation), pca.all.df$rotation)
#
# gg <- ggplot(pca.all.values,aes(x=PC1,y=-PC2, color = Condition))+
#   geom_segment(data = pca.all.loadings, aes(x = 0, y = 0, xend = (PC1*3),
#       yend = (PC2*3)), arrow = arrow(length = unit(1/2, "picas")),
#       color = "black", size = 1, alpha = .3) +
#   geom_point(aes(size=UTS), alpha = .4)+
#   geom_text(aes(label = as.character(temp)), hjust=-.75 ,vjust=1.5, alpha = .8, color = "black")+
#   annotate("text", x = (pca.all.loadings$PC1*3.5), y = (pca.all.loadings$PC2*3.5),#label = pca.loadings$Variables)+
#            label = c("Crystallinity","Amorphous Or.","Crystal Or.","Total Or."))+ #pca.loadings$Variables)+
#   #ggtitle(label = "PC1 vs PC2 of Annealed and Quenched Samples")+
#          # subtitle = "PCA computed using Percent Crystallinity, and amorphous, crystal, and total Orientation")+
#   scale_size_continuous( range = c(3,12),
#              breaks = c(.232, .4 , .6 , .8 , .99),
#              labels = c(.2, .4 , .6 , .8 , 1))+
#   labs(color = "Condition",
#        size = "UTS (GPa)")+
#   guides(colour = guide_legend(override.aes = list(size=10)))+
#  # xlim(-3.5,2.5)+
#   theme_minimal(base_size = 22)
#
# png(filename=paste(getwd(),"/quenchVsAnnealPCA.png", sep = ""),
#     type="cairo",
#     units="in",
#     width=10.5,
#     height=8,
#     pointsize=12,
#     res=1000)
#
# gg
# dev.off()
#
# knitr::include_graphics(paste(getwd(),"/quenchVsAnnealPCA.png", sep = ""))
# ```
#

#

#

#
# ```{r Stress vs Strain Anneal, echo = FALSE}
#
# sequenctial_SS_YManneal(anneal, path = getwd())
# knitr::include_graphics(paste(getwd(),"/ymAndssSequentialanneal.png", sep = ""))
# ```
#

#
# ```{r Stress vs Strain Quench, echo = FALSE}
# sequenctial_SS_YMquench(quench, path = getwd())
#
# knitr::include_graphics(paste(getwd(),"/ymAndssSequentialquench.png", sep = ""))
# ```
#
#

#
#
# ```{r, Alignment vs Temp, echo = FALSE}
# gg <- ggplot(min.all, aes(as.numeric(temp),amor_or))+
#   geom_point(aes(color = condition), size = 4)+
#   geom_line(aes(color = condition))+
#   theme_minimal(base_size = 22)
#
# png(filename=paste(getwd(),"/amor_orVStemp.png", sep = ""),
#     type="cairo",
#     units="in",
#     width=10.5,
#     height=8,
#     pointsize=12,
#     res=1000)
#
# gg
# dev.off()
#
# knitr::include_graphics(paste(getwd(),"/amor_orVStemp.png", sep = ""))
# ```
#

#
#
# ```{r, Alignment vs Temp (crystal), echo = FALSE}
# gg <- ggplot(min.all, aes(as.numeric(temp),cryst_or))+
#   geom_point(aes(color = condition), size = 4)+
#   geom_line(aes(color = condition))+
#   theme_minimal(base_size = 22)
#
# png(filename=paste(getwd(),"/cryst_orVStemp.png", sep = ""),
#     type="cairo",
#     units="in",
#     width=10.5,
#     height=8,
#     pointsize=12,
#     res=1000)
#
# gg
# dev.off()
#
# knitr::include_graphics(paste(getwd(),"/cryst_orVStemp.png", sep = ""))
# ```
#

#
#
# ```{r, Crystallinity, echo = FALSE}
# gg <- ggplot(min.all, aes(as.numeric(temp),Perc_Cryst))+
#   geom_point(aes(color = condition), size = 4)+
#   geom_line(aes(color = condition))+
#   theme_minimal(base_size = 22)
#
# png(filename=paste(getwd(),"/Perc_CrystVStemp.png", sep = ""),
#     type="cairo",
#     units="in",
#     width=10.5,
#     height=8,
#     pointsize=12,
#     res=1000)
#
# gg
# dev.off()
#
# knitr::include_graphics(paste(getwd(),"/Perc_CrystVStemp.png", sep = ""))
# ```
#
#

#
#
# ```{r, Young's Modulus, echo = FALSE}
# gg <- ggplot(min.all, aes(as.numeric(temp),ymMax))+
#   geom_point(aes(color = condition), size = 4)+
#   geom_line(aes(color = condition))+
#   theme_minimal(base_size = 22)
#
# png(filename=paste(getwd(),"/ymVStemp.png", sep = ""),
#     type="cairo",
#     units="in",
#     width=10.5,
#     height=8,
#     pointsize=12,
#     res=1000)
#
# gg
# dev.off()
#
# knitr::include_graphics(paste(getwd(),"/ymVStemp.png", sep = ""))
```
