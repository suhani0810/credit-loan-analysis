# Load the dataset from the specified file path
loan <- read.csv("D://RProject//credit_data//credit_data.csv")

# Display the structure of the data frame (column names, data types, etc.)
str(loan)

# Display summary statistics for each column (min, max, mean, median, quartiles, etc.)
summary(loan)

# Calculate the number of missing values (NAs) in each column
colSums(is.na(loan))

# Calculate the total number of duplicated rows in the data frame
sum(duplicated(loan))

# Remove rows containing any missing values (NAs)
loan <- na.omit(loan)

# Set plot margins to reduce the default margins (to prevent "figure margins too large" error)
par(mar = c(4, 4, 2, 1) + 0.1)

# Create a boxplot of the 'income' column to visualize its distribution and outliers
boxplot(loan$income, main = "Income Boxplot")

# Create a histogram of the 'income' column to visualize its distribution
hist(loan$income, main = "Income Histogram")

# Create a boxplot of the 'age' column
boxplot(loan$age, main = "Age Boxplot")

# Create a histogram of the 'age' column
hist(loan$age, main = "Age Histogram")

# Create a boxplot of the 'loan' column
boxplot(loan$loan, main = "Loan Boxplot")

# Create a histogram of the 'loan' column
hist(loan$loan, main = "Loan Histogram")

# Calculate the 95th percentile of the 'income' column
quantile_95 <- quantile(loan$income, 0.95)

# Cap income outliers by replacing values above the 95th percentile with the 95th percentile value
loan$income[loan$income > quantile_95] <- quantile_95

# Display the structure of the modified data frame
str(loan)

# Display summary statistics of the modified data frame
summary(loan)

# Set the seed for random number generation to ensure reproducibility
set.seed(123)

# Create a random sample of row indices for the training set (70% of the data)
dat.d <- sample(1:nrow(loan), size = nrow(loan) * 0.7, replace = FALSE)

# Create the training set using the sampled row indices
train.loan <- loan[dat.d, ]

# Create the testing set using the remaining row indices
test.loan <- loan[-dat.d, ]

# Extract the 'default' column as the training labels
train.loan_labels <- loan[dat.d, "default"]

# Extract the 'default' column as the testing labels
test.loan_labels <- loan[-dat.d, "default"]

# Install the 'class' package if it's not already installed
install.packages('class')

# Load the 'class' package for KNN
library(class)

# Display the number of rows in the training labels
NROW(train.loan_labels)

# Train a KNN model with k=37 and predict labels for the test set
knn.37 <- knn(train = train.loan[, -5], test = test.loan[, -5], cl = train.loan_labels, k = 37)

# Train a KNN model with k=38 and predict labels for the test set
knn.38 <- knn(train = train.loan[, -5], test = test.loan[, -5], cl = train.loan_labels, k = 38)

# Calculate the accuracy of the KNN model with k=37
ACC.37 <- 100 * sum(test.loan_labels == knn.37) / NROW(test.loan_labels)

# Calculate the accuracy of the KNN model with k=38
ACC.38 <- 100 * sum(test.loan_labels == knn.38) / NROW(test.loan_labels)

# Create a confusion matrix for the KNN model with k=37
table(knn.37, test.loan_labels)

# Create a confusion matrix for the KNN model with k=38
table(knn.38, test.loan_labels)

# Print the accuracy of the KNN model with k=37
print(ACC.37)

# Print the accuracy of the KNN model with k=38
print(ACC.38)

# Install the 'caret' package if it's not already installed
install.packages("caret")

# Load the 'caret' package for confusion matrix
library(caret)

# Create a confusion matrix using the 'caret' package for the KNN model with k=37
confusionMatrix(table(knn.37, test.loan_labels))

# Initialize variables for the loop to find the optimal k value
i <- 1
k.optm <- 1

# Loop through k values from 1 to 40
for (i in 1:40) {
  # Train a KNN model with the current k value
  knn.mod <- knn(train = train.loan, test = test.loan, cl = train.loan_labels, k = i)
  # Calculate and store the accuracy for the current k value
  k.optm[i] <- 100 * sum(test.loan_labels == knn.mod) / NROW(test.loan_labels)
  # Update the k variable (not strictly necessary, but good practice)
  k <- i
  # Print the k value and its corresponding accuracy
  cat(k, '=', k.optm[i], ' ')
}

# Create a line plot of accuracy vs. k value
plot(k.optm, type = "b", xlab = "K-value", ylab = "Accuracy Level")