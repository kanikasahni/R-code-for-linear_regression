# Running MLR using all predictors

# Split the data into testing and training

set.seed(100)
train = sample(1:506,400)
test = -train
test

attach(Boston)
training_data <- Boston[train,]

testing_data <- Boston[test,]

# training the model using all predictors(.,)

model <- lm(medv~ .,data = training_data)

summary(model)

# Since the value of R square is not increased much that means the variables doesnt 
# play much role.They are not dependent much or insignificant variables are there

# We want to use log(lstat) and not lstat

model <- lm(medv~. + log(lstat)-lstat, data = training_data)
summary(model)

# Check for collinearity
# We want to make sure that predictor variable that highly correlated not in the same model together.

#""" There are many ways to check collinearity
# 1. Create the correlation matrix
# 2. Look at the correlation
# 3. Look at the VIF


# Correlation

cor(training_data)
plot(training_data)

round(cor(training_data),2)


# Visualise the correlations 

library(corrplot)
corr_matrix <- cor(training_data)
corrplot(corr_matrix,order="hclust",method = "number")


# VIF

library(car)
vif(model)

#""" According to the VIF output, we can see that tax and rad are affecting the collinearity in the model.
#This is becaouse they have a high VIF(larger than 5). A value of VIF is the best """

# We ned to get rid of either rad or tax from our model


# .............

# Dealing with interaction terms
model <- lm(medv~log(lstat)+rm, data=training_data)
summary(model)

model <- lm(medv~log(lstat)*rm, data=training_data)
summary(model)


# Get all two-way interaction term
# High value of R square is over-fitting


model <- lm(medv~(.)^3,data = training_data)
summary(model)
