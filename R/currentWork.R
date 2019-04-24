

min.quench <- quench1
min.quench <- unique(subset(min.quench, select = -c(time, index, forces,stroke,ym, strain, stressSEM, stressFTIR, stressHyb, dstrain, dstress )))
min.quench <- min.quench[!(min.quench$temp == 54),]

min.anneal <- anneal
min.anneal <- unique(subset(min.anneal, select = -c(time, index, forces,stroke,ym, strain, stressSEM, stressFTIR, stressHyb, dstrain, dstress )))


min.quench$wamor_or <-min.quench$amor_or*(1-min.quench$Perc_Cryst)
min.quench$wcryst_or <-min.quench$cryst_or*min.quench$Perc_Cryst

min.anneal$wamor_or <-min.anneal$amor_or*(1-min.anneal$Perc_Cryst)
min.anneal$wcryst_or <-min.anneal$cryst_or*min.anneal$Perc_Cryst

############################################################
#         Structure    ---> Function                       #
############################################################

###Multivariate Linear model predicting function (YM) from structure

#Anneal
UTS.quench <- lm(UTS_FTIR ~ poly(Perc_Cryst, 2 ,raw = TRUE), data = min.quench)
summary(UTS.quench)
model_fit_stats(UTS.quench)

gg <- ggplot(min.quench, aes(x = Perc_Cryst,y = UTS_FTIR))+
  geom_smooth(method = lm, formula = y ~ poly(x, 2, raw = TRUE), alpha = .1, color = "black")+
  geom_point(aes(fill = temp), pch=21, size = 8, color = "black")+
  scale_fill_brewer(palette = "RdBu", direction=-1)+
  labs(title = "UTS vs Percent Crystallinity",
       fill = 'Temp (C)')+
  xlab("% Crystallinity")+
  ylab("UTS (GPa)") +
  theme_minimal(base_size = 22)

gg

png(filename=paste(getwd(),"/testregression.png", sep = ""),
    type="cairo",
    units="in",
    width=10.5,
    height=8,
    pointsize=12,
    res=1000)

gg
dev.off()



quench.UTS <- lm(UTS_FTIR ~ poly(Perc_Cryst, 3 ,raw = TRUE), data = min.quench)
summary(quench.UTS)
model_fit_stats(quench.UTS)

gg <- ggplot(min.quench, aes(Perc_Cryst,UTS_FTIR))+
  geom_point()+
  #geom_line(aes(color = condition))+
  theme_minimal(base_size = 22)

png(filename=paste(getwd(),"/testregression.png", sep = ""),
    type="cairo",
    units="in",
    width=10.5,
    height=8,
    pointsize=12,
    res=1000)

gg
dev.off()

