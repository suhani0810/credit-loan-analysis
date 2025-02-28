> loan <- read.csv("D://RProject//credit_data//credit_data.csv")
> str(loan)
> summary(loan)
> colSums(is.na(loan))
> sum(duplicated(loan))
> loan <- na.omit(loan)
> par(mar = c(4, 4, 2, 1) + 0.1)
> boxplot(loan$income, main = "Income Boxplot")
> hist(loan$income, main = "Income Histogram")
> boxplot(loan$age, main = "Age Boxplot")
> hist(loan$age, main = "Age Histogram")
> boxplot(loan$loan, main = "Loan Boxplot")
> hist(loan$loan, main = "Loan Histogram")
> quantile_95 <- quantile(loan$income, 0.95)
> loan$income[loan$income > quantile_95] <- quantile_95
> str(loan)
> summary(loan)
> set.seed(123)
> dat.d <- sample(1:nrow(loan), size = nrow(loan) * 0.7, replace = FALSE)
> train.loan <- loan[dat.d, ]
> test.loan <- loan[-dat.d, ] #Corrected loan.n to loan and dat.d to -dat.d.
> train.loan_labels <- loan[dat.d, "default"] # Corrected to default.
> test.loan_labels <- loan[-dat.d, "default"] # Corrected to default.
> install.packages('class')
> library(class)
> NROW(train.loan_labels)
[1] 1397
> knn.37 <- knn(train = train.loan[, -5], test = test.loan[, -5], cl = train.loan_labels, k = 37) #Corrected knn.
> knn.38 <- knn(train = train.loan[, -5], test = test.loan[, -5], cl = train.loan_labels, k = 38) #Corrected knn.
> ACC.37 <- 100 * sum(test.loan_labels == knn.37) / NROW(test.loan_labels) 
> ACC.38 <- 100 * sum(test.loan_labels == knn.38) / NROW(test.loan_labels) 
> table(knn.37, test.loan_labels)
> table(knn.38, test.loan_labels)
> print(ACC.37)
> print(ACC.38)
> install.packages("caret")
> library(caret)
> confusionMatrix(table(knn.37,test.loan_labels))
> i <- 1
> k.optm <- 1
> for (i in 1:40) {
+     knn.mod <- knn(train = train.loan, test = test.loan, cl = train.loan_labels, k = i)
+     k.optm[i] <- 100 * sum(test.loan_labels == knn.mod) / NROW(test.loan_labels)
+     k <- i
+     cat(k, '=', k.optm[i], ' ') #Added a space ' ' instead of ''
+ }
> plot(k.optm, type="b",xlab = "K-value",ylab = "Accuracy Level")

