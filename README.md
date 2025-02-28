# credit-loan-analysis
R script to analyze the credit-loan dataset using knn
# Credit Loan Analysis with KNN

This repository contains an R script (`credit_analysis.R`) that performs a credit loan analysis using the K-Nearest Neighbors (KNN) algorithm. The analysis aims to predict loan defaults based on client income, age, and loan amount.

## Dataset

The dataset used in this analysis is `credit_data.csv`, which contains the following columns:

* `clientid`: Unique client identifier.
* `income`: Client's income.
* `age`: Client's age.
* `loan`: Loan amount.
* `default`: Binary variable indicating loan default (0 or 1).

## R Script (`credit_analysis.R`)

The `credit_analysis.R` script performs the following steps:

1.  **Data Loading:** Reads the `credit_data.csv` file into an R data frame.
2.  **Data Inspection:** Examines the structure and summary statistics of the data.
3.  **Missing Value Handling:** Removes rows with missing values.
4.  **Duplicate Removal:** Removes duplicate rows.
5.  **Outlier Handling:** Caps income outliers at the 95th percentile.
6.  **Data Splitting:** Splits the data into training and testing sets (70% training, 30% testing).
7.  **KNN Model Training and Evaluation:**
    * Trains a KNN model with k=37 and k=38.
    * Calculates and prints the accuracy of each model.
    * Generates confusion matrices for both models.
    * Uses a loop to find the optimal K value between 1 and 40.
    * Plots the accuracy results for each k value.
8.  **Confusion Matrix:** Uses the caret package to create a confusion matrix.

## Dependencies

The following R packages are required:

* `class`
* `caret`
* `ggplot2` (loaded by `caret`)
* `lattice` (loaded by `caret`)

You can install these packages using:

```R
install.packages(c("class", "caret"))
