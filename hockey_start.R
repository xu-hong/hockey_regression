## nhl hockey analysis

## the data is in gamlr.  
## You need to first install this, 
## via install.packages("gamlr")

library(gamlr) # loads Matrix as well
help(hockey) # describes the hockey data and shows an example regression

data(hockey) # load the data

# Combine the covariates all together
x <- cBind(config,team,player) # cBind binds together two sparse matrices

# build 'y': home vs away, binary response
y <- goal$homegoal

nhlreg <- gamlr(x, y, 
	free = 1:(ncol(config)+ncol(team)), ## free denotes unpenalized columns
	family = "binomial", standardize = FALSE,
	verb = TRUE)

plot(nhlreg)

## coefficients (grab only the players)
B <- coef(nhlreg)[colnames(player),]
sum(B!=0) # number of measurable effects (AICc selection)
B[order(-B)[1:10]] # 10 biggest

plot(log(nhlreg$lambda), AICc(nhlreg))

