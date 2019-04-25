## Get unique lines from all, and create the weighted alignments

unique.rows <- function(all){

min.all <- all
min.all <- na.omit(min.all)
min.all <- unique(subset(min.all, select = -c(time, index, forces,stroke,ym, strain, stressSEM, stressFTIR, stressHyb, dstrain, dstress )))
min.all$wamor_or  <- min.all$amor_or  * (1-min.all$Perc_Cryst)^2
min.all$wcryst_or <- min.all$cryst_or * min.all$Perc_Cryst^2

return(min.all)
}
############################################################
#         Structure    ---> Function                       #
############################################################

struc2func <- function(all){ #takes the the "all" dataframe.

#take the unique rows and isolate the anneal and quench data
min.all <- unique.rows(all)
min.anneal <- min.all[min.all$condition == "anneal",]
min.quench <- min.all[min.all$condition == "quench",]

###Multivariate Linear model predicting function (UTS) from structure

#Anneal sjkh fskjdfh sjkdfh skjfh
anneal.UTS <- lm(UTS_FTIR ~ wamor_or + wcryst_or + tot_or, data = min.anneal)
summary(multiUTS)
model_fit_stats(multiUTS)

multiUTS <- lm(UTS_FTIR ~ wcryst_or + wamor_or + tot_or, data = min.quench)
summary(multiUTS)
model_fit_stats(multiUTS)

##this model works well for the quenched data
multiUTS <- lm(UTS_FTIR ~ poly(Perc_Cryst ,3,raw = TRUE), data = min.quench)
summary(multiUTS)
model_fit_stats(multiUTS)

gg <- ggplot(min.quench, aes(x = Perc_Cryst, y = UTS_FTIR))+
  geom_point()+
  geom_smooth(method = lm, formula = y ~ poly(x ,3,raw = TRUE))

png(filename=paste(getwd(),"/quenchRegression.png", sep = ""),
    type="cairo",
    units="in",
    width=10.5,
    height=8,
    pointsize=12,
    res=1000)

gg

dev.off()




###Multivariate Linear model predicting function (YM) from structure

multiYM <- lm(formula = ymMax ~
              poly(Perc_Cryst ,2,raw = TRUE)+
              poly(amor_or    ,2,raw = TRUE)+
              poly(cryst_or   ,2,raw = TRUE)+
              poly(tot_or     ,2,raw = TRUE), data = minusSS) # p-value: < 2.2e-16

summary(multiYM)
model_fit_stats(multiYM)



############################################################
#         Process     --->  Function                       #
############################################################


###Multivariate Linear model predicting function (UTS) from process

pfUTS <- lm(UTS_FTIR ~ poly(as.numeric(temp), 2, raw = TRUE), data = minusSS) # p-value: < 2.2e-16
summary(pfUTS)
model_fit_stats(pfUTS)

###Multivariate Linear model predicting function (YM) from process

pfYM <-lm(ymMax ~ poly(as.numeric(temp), 2, raw = TRUE), data = minusSS)
summary(pfYM)
model_fit_stats(pfYM)
