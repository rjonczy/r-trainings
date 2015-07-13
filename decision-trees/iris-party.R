# #######################################################################################
library(party)

# load iris dataset
data(iris)

set.seed(1234)
ind <- sample(2, nrow(iris), replace = T, prob = c(0.7, 0.3))
iris_ctree <- ctree(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = trainData)
table(predict(iris_ctree), trainData$Species)

plot(iris_ctree, type="simple")

testPred <- predict(iris_ctree, newdata = testData)
table(testPred, testData$Species)

# #######################################################################################
library(rpart)
# load bodyfat dataset
data('bodyfat', package='TH.data')

set.seed(1234)
ind <- sample(2, nrow(bodyfat), replace = T, prob = c(0.7, 0.3))
bodyfat.train <- bodyfat[ind==1,]
bodyfat.test <- bodyfat[ind==2,]

myFormula <- DEXfat ~ age + waistcirc + hipcirc + elbowbreadth + kneebreadth
bodyfat_rpart <- rpart(myFormula, data = bodyfat.train, control = rpart.control(minsplit = 10))
#select tree with lowest error rate
opt <- which.min(bodyfat_rpart$cptable[,'xerror'])
cp <- bodyfat_rpart$cptable[opt,'CP']
bodyfat_prune <- prune(bodyfat_rpart, cp = cp)
# #######################################################################################