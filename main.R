library(ordinalNet)
library(openxlsx)
DATa <- read.xlsx("DATa.xlsx")
##################################
## without correlation analysis ##
##  without reweight            ##
##################################
str(DATa)
dim(DATa)
DATa <- DATa[,-1]
##########  After data transformation  >>>>
 Y <- as.factor(DATa$cut)
 X <- DATa[,-2]
ScaDat <-  scale(X, center = TRUE , scale = TRUE)
########## Cumilative probability logit link  ############ Rid & Lass
FT.Rid <- ordinalNet:: ordinalNet(ScaDat,Y,family = "cumulative",link = "logit" ,alpha = 0)
FT.Lass <- ordinalNet:: ordinalNet(ScaDat,Y,family = "cumulative",link = "logit" ,alpha = 1)
##################################################################################################
#################################### cross validation   ##########################################
##################################################################################################
##################### Folds ####################################
#  set.seed(123)                                               #
#  nFolds <-5                                                  #
#  n <- nrow(ScaDat)                                           #
#  indeRandomOrder <- sample(n)                                #
#  folds <- split(indeRandomOrder, rep(1:nFolds,length.out=n)) #
################################################################
FT1CvRid <- ordinalNet:: ordinalNetCV(ScaDat,Y,family="cumulative",link="logit",tuneMethod = "cvLoglik", alpha=0)
FT1CvLas <- ordinalNet:: ordinalNetCV(ScaDat,Y,family="cumulative",link="logit",tuneMethod = "cvLoglik", alpha=1)

LGLIK.RID <-FT1CvRid$loglik
LGLIK.LAS <-FT1CvLas$loglik

BSTLMDRid <- FT1CvRid$bestLambdaIndex
BSTLMDLas <- FT1CvLas$bestLambdaIndex



























