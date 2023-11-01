Business Intelligence Project
================
<Champions>
\<22/10/2023\>

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
- [STEP 1 : Install and Load the Required
  Packages](#step-1--install-and-load-the-required-packages)
  - [Load the datasets](#load-the-datasets)
- [Algorithm Selection for
  Classification](#algorithm-selection-for-classification)
- [A. Linear Algorithms](#a-linear-algorithms)
  - [1. Linear Discriminant Analysis](#1-linear-discriminant-analysis)
    - [1.a. Linear Discriminant Analysis without
      caret](#1a-linear-discriminant-analysis-without-caret)
      - [Display the model’s details](#display-the-models-details)
      - [Make predictions](#make-predictions)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics)
    - [1.b. Linear Discriminant Analysis with
      caret](#1b-linear-discriminant-analysis-with-caret)
      - [Train the model](#train-the-model)
      - [Display the model’s details](#display-the-models-details-1)
      - [Make predictions](#make-predictions-1)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-1)
      - [Train the model](#train-the-model-1)
      - [Display the model’s details](#display-the-models-details-2)
      - [Make predictions](#make-predictions-2)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-2)
  - [3. Logistic Regression](#3-logistic-regression)
    - [3.a. Logistic Regression without
      caret](#3a-logistic-regression-without-caret)
      - [Load and split the dataset](#load-and-split-the-dataset)
      - [Train the model](#train-the-model-2)
      - [Display the model’s details](#display-the-models-details-3)
      - [Make predictions](#make-predictions-3)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-3)
    - [3.b. Logistic Regression with
      caret](#3b-logistic-regression-with-caret)
      - [Load and split the dataset](#load-and-split-the-dataset-1)
      - [Split the dataset into training and
        testing](#split-the-dataset-into-training-and-testing)
      - [Train the model](#train-the-model-3)
      - [Display the model’s details](#display-the-models-details-4)
      - [Make predictions](#make-predictions-4)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-4)
- [B. Non-Linear Algorithms](#b-non-linear-algorithms)
  - [1. Classification and Regression
    Trees](#1-classification-and-regression-trees)
    - [1.a. Decision tree for a classification problem without
      caret](#1a-decision-tree-for-a-classification-problem-without-caret)
      - [Load and split the dataset](#load-and-split-the-dataset-2)
      - [Train the model](#train-the-model-4)
      - [Display the model’s details](#display-the-models-details-5)
      - [Make predictions](#make-predictions-5)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-5)
    - [1.b. Decision tree for a classification problem with
      caret](#1b-decision-tree-for-a-classification-problem-with-caret)
      - [Load and split the dataset](#load-and-split-the-dataset-3)
      - [Train the model](#train-the-model-5)
      - [Display the model’s details](#display-the-models-details-6)
      - [Make predictions](#make-predictions-6)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-6)
  - [2. Naïve Bayes](#2-naïve-bayes)
    - [2.a. Naïve Bayes Classifier for a Classification Problem without
      CARET](#2a-naïve-bayes-classifier-for-a-classification-problem-without-caret)
      - [Load and split the dataset](#load-and-split-the-dataset-4)
      - [Train the model](#train-the-model-6)
      - [Display the model’s details](#display-the-models-details-7)
      - [Make predictions](#make-predictions-7)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-7)
  - [3. k-Nearest Neighbours](#3-k-nearest-neighbours)
    - [3.a. kNN for a classification problem without CARET’s train
      function](#3a-knn-for-a-classification-problem-without-carets-train-function)
      - [Load and split the dataset](#load-and-split-the-dataset-5)
      - [Split the dataset into training and
        testing](#split-the-dataset-into-training-and-testing-1)
      - [Train the model](#train-the-model-7)
      - [Display the model’s details](#display-the-models-details-8)
      - [Make predictions](#make-predictions-8)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-8)
    - [3.b. kNN for a classification problem with CARET’s train
      function](#3b-knn-for-a-classification-problem-with-carets-train-function)
      - [Load and split the dataset](#load-and-split-the-dataset-6)
      - [Train the model](#train-the-model-8)
      - [Display the model’s details](#display-the-models-details-9)
      - [Make predictions](#make-predictions-9)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-9)
  - [4. Support Vector Machine](#4-support-vector-machine)
    - [4.a. SVM Classifier for a classification problem without
      CARET](#4a-svm-classifier-for-a-classification-problem-without-caret)
      - [Load and split the dataset](#load-and-split-the-dataset-7)
      - [Train the model](#train-the-model-9)
      - [Display the model’s details](#display-the-models-details-10)
      - [Make predictions](#make-predictions-10)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-10)
    - [4.b. SVM Classifier for a classification problem with CARET
      —-](#4b-svm-classifier-for-a-classification-problem-with-caret--)
      - [Load and split the dataset](#load-and-split-the-dataset-8)
      - [Train the model](#train-the-model-10)
      - [Display the model’s details](#display-the-models-details-11)
      - [Make predictions](#make-predictions-11)
      - [Display the model’s evaluation
        metrics](#display-the-models-evaluation-metrics-11)

# Student Details

<table style="width:99%;">
<colgroup>
<col style="width: 65%" />
<col style="width: 33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><strong>Student ID Number</strong></td>
<td><p>134111</p>
<p>133996</p>
<p>126761</p>
<p>135859</p>
<p>127707</p></td>
</tr>
<tr class="even">
<td><strong>Student Name</strong></td>
<td><p>Juma Immaculate Haayo</p>
<p>Trevor Ngugi</p>
<p>Virginia Wanjiru</p>
<p>Pauline Wang’ombe</p>
<p>Clarice Gitonga</p></td>
</tr>
<tr class="odd">
<td><strong>BBIT 4.2 Group</strong></td>
<td>B</td>
</tr>
<tr class="even">
<td><strong>BI Project Group Name/ID (if applicable)</strong></td>
<td>Champions</td>
</tr>
</tbody>
</table>

# Setup Chunk

**Note:** the following KnitR options have been set as the global
defaults: <BR>
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

# STEP 1 : Install and Load the Required Packages

We installed all the packages that will enable us execute this lab.

``` r
## stats ----
if (require("stats")) {
  require("stats")
} else {
  install.packages("stats", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## mlbench ----
if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: mlbench

``` r
## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: caret

    ## Loading required package: ggplot2

    ## Loading required package: lattice

``` r
## MASS ----
if (require("MASS")) {
  require("MASS")
} else {
  install.packages("MASS", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: MASS

``` r
## glmnet ----
if (require("glmnet")) {
  require("glmnet")
} else {
  install.packages("glmnet", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: glmnet

    ## Loading required package: Matrix

    ## Loaded glmnet 4.1-8

``` r
## e1071 ----
if (require("e1071")) {
  require("e1071")
} else {
  install.packages("e1071", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: e1071

``` r
## kernlab ----
if (require("kernlab")) {
  require("kernlab")
} else {
  install.packages("kernlab", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: kernlab

    ## 
    ## Attaching package: 'kernlab'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     alpha

``` r
## rpart ----
if (require("rpart")) {
  require("rpart")
} else {
  install.packages("rpart", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: rpart

## Load the datasets

We proceeded to load the ToothGrowth dataset which is inbult

``` r
data(ToothGrowth)
View(ToothGrowth)
```

# Algorithm Selection for Classification

# A. Linear Algorithms

## 1. Linear Discriminant Analysis

### 1.a. Linear Discriminant Analysis without caret

70% of the dataset is used in training the dataset and 30% for testing.

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_train <- ToothGrowth[train_index, ]
ToothGrowth_test <- ToothGrowth[-train_index, ]
```

\####Train the model

``` r
ToothGrowth_model_lda <- lda(supp ~ ., data = ToothGrowth_train)
```

#### Display the model’s details

``` r
print(ToothGrowth_model_lda)
```

    ## Call:
    ## lda(supp ~ ., data = ToothGrowth_train)
    ## 
    ## Prior probabilities of groups:
    ##  OJ  VC 
    ## 0.5 0.5 
    ## 
    ## Group means:
    ##         len     dose
    ## OJ 20.12381 1.095238
    ## VC 15.54762 1.071429
    ## 
    ## Coefficients of linear discriminants:
    ##             LD1
    ## len  -0.2403164
    ## dose  2.2212059

#### Make predictions

``` r
predictions <- predict(ToothGrowth_model_lda,
                       ToothGrowth_test[, 1:3])$class
```

#### Display the model’s evaluation metrics

The result of running the code below is 7 for OJ to OJ and 8 for VC to
VC

``` r
table(predictions, ToothGrowth_test$supp)
```

    ##            
    ## predictions OJ VC
    ##          OJ  7  4
    ##          VC  2  5

### 1.b. Linear Discriminant Analysis with caret

70% of the dataset is used in training the dataset and 30% for testing.

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_train <- ToothGrowth[train_index, ]
ToothGrowth_test <- ToothGrowth[-train_index, ]
```

#### Train the model

We apply a Leave One Out Cross Validation resampling method We also
apply a standardize data transform to make the mean = 0 and standard
deviation = 1

``` r
set.seed(7)
train_control <- trainControl(method = "LOOCV")
ToothGrowth_caret_model_lda <- train(supp ~ .,
                                     data = ToothGrowth_train,
                                     method = "lda", metric = "Accuracy",
                                     preProcess = c("center", "scale"),
                                     trControl = train_control)
```

#### Display the model’s details

``` r
print(ToothGrowth_caret_model_lda)
```

    ## Linear Discriminant Analysis 
    ## 
    ## 42 samples
    ##  2 predictor
    ##  2 classes: 'OJ', 'VC' 
    ## 
    ## Pre-processing: centered (2), scaled (2) 
    ## Resampling: Leave-One-Out Cross-Validation 
    ## Summary of sample sizes: 41, 41, 41, 41, 41, 41, ... 
    ## Resampling results:
    ## 
    ##   Accuracy  Kappa
    ##   0.5       0

#### Make predictions

``` r
predictions <- predict(ToothGrowth_caret_model_lda,
                       ToothGrowth_test[, 1:3])
```

#### Display the model’s evaluation metrics

Here, the model’s evaluation is displayed on a Confusion Matrix.

``` r
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         ToothGrowth_test[, 1:2]$supp)
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction OJ VC
    ##         OJ  8  2
    ##         VC  1  7
    ##                                           
    ##                Accuracy : 0.8333          
    ##                  95% CI : (0.5858, 0.9642)
    ##     No Information Rate : 0.5             
    ##     P-Value [Acc > NIR] : 0.003769        
    ##                                           
    ##                   Kappa : 0.6667          
    ##                                           
    ##  Mcnemar's Test P-Value : 1.000000        
    ##                                           
    ##             Sensitivity : 0.8889          
    ##             Specificity : 0.7778          
    ##          Pos Pred Value : 0.8000          
    ##          Neg Pred Value : 0.8750          
    ##              Prevalence : 0.5000          
    ##          Detection Rate : 0.4444          
    ##    Detection Prevalence : 0.5556          
    ##       Balanced Accuracy : 0.8333          
    ##                                           
    ##        'Positive' Class : OJ              
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2012th%20Code%20Chunk-1.png)<!-- -->

\##2. Regularized Linear Regression —- \### 2.a. Regularized Linear
Regression Classification Problem with CARET —- \#### Load and split the
dataset We loaded the ToothGrowth dataset which is inbuilt

``` r
data(ToothGrowth)
```

\####Split the datset into training and testing 70% of the datset is
used for training and the other 30% is used for testing

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_regression_train <- ToothGrowth[train_index, ]
ToothGrowth_regression_test <- ToothGrowth[-train_index, ]
```

#### Train the model

Apply the 5-fold cross validation resampling method

``` r
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)
ToothGrowth_caret_model_glmnet <-
  train(supp ~ ., data = ToothGrowth_regression_train,
        method = "glmnet", metric = "Accuracy",
        preProcess = c("center", "scale"), trControl = train_control)
```

#### Display the model’s details

``` r
print(ToothGrowth_caret_model_glmnet)
```

    ## glmnet 
    ## 
    ## 42 samples
    ##  2 predictor
    ##  2 classes: 'OJ', 'VC' 
    ## 
    ## Pre-processing: centered (2), scaled (2) 
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 34, 33, 34, 34, 33 
    ## Resampling results across tuning parameters:
    ## 
    ##   alpha  lambda        Accuracy   Kappa    
    ##   0.10   0.0003332232  0.6500000  0.3090592
    ##   0.10   0.0033322322  0.6027778  0.2109756
    ##   0.10   0.0333223223  0.6722222  0.3420263
    ##   0.55   0.0003332232  0.6500000  0.3090592
    ##   0.55   0.0033322322  0.6027778  0.2109756
    ##   0.55   0.0333223223  0.6722222  0.3420263
    ##   1.00   0.0003332232  0.6500000  0.3090592
    ##   1.00   0.0033322322  0.6027778  0.2109756
    ##   1.00   0.0333223223  0.6722222  0.3420263
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were alpha = 0.1 and lambda = 0.03332232.

#### Make predictions

``` r
predictions <- predict(ToothGrowth_caret_model_glmnet,
                       ToothGrowth_regression_test[, 1:3])
predictions <- factor(predictions, levels = levels(ToothGrowth_regression_test$supp))
```

#### Display the model’s evaluation metrics

``` r
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         ToothGrowth_regression_test$supp)
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction OJ VC
    ##         OJ  4  2
    ##         VC  5  7
    ##                                          
    ##                Accuracy : 0.6111         
    ##                  95% CI : (0.3575, 0.827)
    ##     No Information Rate : 0.5            
    ##     P-Value [Acc > NIR] : 0.2403         
    ##                                          
    ##                   Kappa : 0.2222         
    ##                                          
    ##  Mcnemar's Test P-Value : 0.4497         
    ##                                          
    ##             Sensitivity : 0.4444         
    ##             Specificity : 0.7778         
    ##          Pos Pred Value : 0.6667         
    ##          Neg Pred Value : 0.5833         
    ##              Prevalence : 0.5000         
    ##          Detection Rate : 0.2222         
    ##    Detection Prevalence : 0.3333         
    ##       Balanced Accuracy : 0.6111         
    ##                                          
    ##        'Positive' Class : OJ             
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2018th%20Code%20Chunk-1.png)<!-- -->

## 3. Logistic Regression

### 3.a. Logistic Regression without caret

#### Load and split the dataset

``` r
data(ToothGrowth)
```

\####Split the dataset into training and testing 70% of the datset is
used for training and 30% is used for testing

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_logistic_train <- ToothGrowth[train_index, ]
ToothGrowth_logistic_test <- ToothGrowth[-train_index, ]
```

#### Train the model

``` r
ToothGrowth_logistic_model_glm <- glm(supp ~ ., data = ToothGrowth_logistic_train,
                                 family = binomial(link = "logit"))
```

#### Display the model’s details

``` r
print(ToothGrowth_logistic_model_glm)
```

    ## 
    ## Call:  glm(formula = supp ~ ., family = binomial(link = "logit"), data = ToothGrowth_logistic_train)
    ## 
    ## Coefficients:
    ## (Intercept)          len         dose  
    ##       2.022       -0.243        2.050  
    ## 
    ## Degrees of Freedom: 41 Total (i.e. Null);  39 Residual
    ## Null Deviance:       58.22 
    ## Residual Deviance: 48.89     AIC: 54.89

#### Make predictions

``` r
probabilities <- predict(ToothGrowth_logistic_model_glm, ToothGrowth_logistic_test[, 1:3],
                         type = "response")
print(probabilities)
```

    ##          7          9         13         14         17         19         23 
    ## 0.58079349 0.85615769 0.59370487 0.46732305 0.68309328 0.37864095 0.10776946 
    ##         27         30         31         36         40         43         44 
    ## 0.40987460 0.26023523 0.34394294 0.64966629 0.66606879 0.15956275 0.08772396 
    ##         46         48         51         58 
    ## 0.11403152 0.25380838 0.48177240 0.37513390

``` r
predictions <- ifelse(probabilities > 0.5, "OJ" ,"VC")
print(predictions)
```

    ##    7    9   13   14   17   19   23   27   30   31   36   40   43   44   46   48 
    ## "OJ" "OJ" "OJ" "VC" "OJ" "VC" "VC" "VC" "VC" "VC" "OJ" "OJ" "VC" "VC" "VC" "VC" 
    ##   51   58 
    ## "VC" "VC"

#### Display the model’s evaluation metrics

``` r
table(predictions, ToothGrowth_logistic_test$supp)
```

    ##            
    ## predictions OJ VC
    ##          OJ  2  4
    ##          VC  7  5

### 3.b. Logistic Regression with caret

#### Load and split the dataset

We load the ToothGrowth dataset which is inbuilt

``` r
data(ToothGrowth)
```

#### Split the dataset into training and testing

70% of the dataset is used for training and the remaining 30% of used
for testing

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_logisticb_train <- ToothGrowth[train_index, ]
ToothGrowth_logisticb_test <- ToothGrowth[-train_index, ]
```

#### Train the model

We apply the 5-fold cross validation resampling method set.seed(7)
ensures we have the same set of values We can use “regLogistic” instead
of “glm” Notice the data transformation applied when we call the train
function in caret, i.e., a standardize data transform (centre + scale)

``` r
train_control <- trainControl(method = "cv", number = 5)

set.seed(7)
ToothGrowth_caret_model_logistic <-
  train(supp ~ ., data = ToothGrowth_logisticb_train,
        method = "regLogistic", metric = "Accuracy",
        preProcess = c("center", "scale"), trControl = train_control)
```

#### Display the model’s details

``` r
print(ToothGrowth_caret_model_logistic)
```

    ## Regularized Logistic Regression 
    ## 
    ## 42 samples
    ##  2 predictor
    ##  2 classes: 'OJ', 'VC' 
    ## 
    ## Pre-processing: centered (2), scaled (2) 
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 34, 33, 34, 34, 33 
    ## Resampling results across tuning parameters:
    ## 
    ##   cost  loss       epsilon  Accuracy   Kappa    
    ##   0.5   L1         0.001    0.5777778  0.1585714
    ##   0.5   L1         0.010    0.5777778  0.1585714
    ##   0.5   L1         0.100    0.5777778  0.1585714
    ##   0.5   L2_dual    0.001    0.6500000  0.3168514
    ##   0.5   L2_dual    0.010    0.6500000  0.3168514
    ##   0.5   L2_dual    0.100    0.6500000  0.3168514
    ##   0.5   L2_primal  0.001    0.6500000  0.3168514
    ##   0.5   L2_primal  0.010    0.6500000  0.3168514
    ##   0.5   L2_primal  0.100    0.6500000  0.3168514
    ##   1.0   L1         0.001    0.6500000  0.3168514
    ##   1.0   L1         0.010    0.6500000  0.3168514
    ##   1.0   L1         0.100    0.6500000  0.3168514
    ##   1.0   L2_dual    0.001    0.6500000  0.3168514
    ##   1.0   L2_dual    0.010    0.6500000  0.3168514
    ##   1.0   L2_dual    0.100    0.6500000  0.3168514
    ##   1.0   L2_primal  0.001    0.6500000  0.3168514
    ##   1.0   L2_primal  0.010    0.6500000  0.3168514
    ##   1.0   L2_primal  0.100    0.6500000  0.3168514
    ##   2.0   L1         0.001    0.6500000  0.3168514
    ##   2.0   L1         0.010    0.6500000  0.3168514
    ##   2.0   L1         0.100    0.6500000  0.3168514
    ##   2.0   L2_dual    0.001    0.6250000  0.2668514
    ##   2.0   L2_dual    0.010    0.6250000  0.2668514
    ##   2.0   L2_dual    0.100    0.6500000  0.3168514
    ##   2.0   L2_primal  0.001    0.6250000  0.2668514
    ##   2.0   L2_primal  0.010    0.6250000  0.2668514
    ##   2.0   L2_primal  0.100    0.6250000  0.2668514
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were cost = 0.5, loss = L2_dual and
    ##  epsilon = 0.001.

#### Make predictions

``` r
predictions <- predict(ToothGrowth_caret_model_logistic,
                       ToothGrowth_logisticb_test[, 1:3])
```

#### Display the model’s evaluation metrics

``` r
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         ToothGrowth_logisticb_test[, 1:2]$supp)
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction OJ VC
    ##         OJ  4  1
    ##         VC  5  8
    ##                                           
    ##                Accuracy : 0.6667          
    ##                  95% CI : (0.4099, 0.8666)
    ##     No Information Rate : 0.5             
    ##     P-Value [Acc > NIR] : 0.1189          
    ##                                           
    ##                   Kappa : 0.3333          
    ##                                           
    ##  Mcnemar's Test P-Value : 0.2207          
    ##                                           
    ##             Sensitivity : 0.4444          
    ##             Specificity : 0.8889          
    ##          Pos Pred Value : 0.8000          
    ##          Neg Pred Value : 0.6154          
    ##              Prevalence : 0.5000          
    ##          Detection Rate : 0.2222          
    ##    Detection Prevalence : 0.2778          
    ##       Balanced Accuracy : 0.6667          
    ##                                           
    ##        'Positive' Class : OJ              
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2030th%20Code%20Chunk-1.png)<!-- -->

# B. Non-Linear Algorithms

## 1. Classification and Regression Trees

### 1.a. Decision tree for a classification problem without caret

#### Load and split the dataset

``` r
data(ToothGrowth)
```

\####Split the datset into training and testing

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_train <- ToothGrowth[train_index, ]
ToothGrowth_test <- ToothGrowth[-train_index, ]
```

#### Train the model

``` r
ToothGrowth_model_rpart <- rpart(supp ~ ., data = ToothGrowth_train)
```

#### Display the model’s details

``` r
print(ToothGrowth_model_rpart)
```

    ## n= 42 
    ## 
    ## node), split, n, loss, yval, (yprob)
    ##       * denotes terminal node
    ## 
    ## 1) root 42 21 OJ (0.5000000 0.5000000)  
    ##   2) len>=8.8 35 15 OJ (0.5714286 0.4285714)  
    ##     4) len>=19.25 22  8 OJ (0.6363636 0.3636364)  
    ##       8) dose< 1.5 9  1 OJ (0.8888889 0.1111111) *
    ##       9) dose>=1.5 13  6 VC (0.4615385 0.5384615) *
    ##     5) len< 19.25 13  6 VC (0.4615385 0.5384615) *
    ##   3) len< 8.8 7  1 VC (0.1428571 0.8571429) *

#### Make predictions

``` r
predictions <- predict(ToothGrowth_model_rpart,
                       ToothGrowth_test[, 1:3],
                       type = "class")
```

#### Display the model’s evaluation metrics

``` r
table(predictions, ToothGrowth_test$supp)
```

    ##            
    ## predictions OJ VC
    ##          OJ  2  0
    ##          VC  7  9

``` r
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         ToothGrowth_test[, 1:3]$supp)
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction OJ VC
    ##         OJ  2  0
    ##         VC  7  9
    ##                                          
    ##                Accuracy : 0.6111         
    ##                  95% CI : (0.3575, 0.827)
    ##     No Information Rate : 0.5            
    ##     P-Value [Acc > NIR] : 0.24034        
    ##                                          
    ##                   Kappa : 0.2222         
    ##                                          
    ##  Mcnemar's Test P-Value : 0.02334        
    ##                                          
    ##             Sensitivity : 0.2222         
    ##             Specificity : 1.0000         
    ##          Pos Pred Value : 1.0000         
    ##          Neg Pred Value : 0.5625         
    ##              Prevalence : 0.5000         
    ##          Detection Rate : 0.1111         
    ##    Detection Prevalence : 0.1111         
    ##       Balanced Accuracy : 0.6111         
    ##                                          
    ##        'Positive' Class : OJ             
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2036th%20Code%20Chunk-1.png)<!-- -->

### 1.b. Decision tree for a classification problem with caret

#### Load and split the dataset

``` r
data(ToothGrowth)
```

\####Split the dataset into training and testing 70% of the dataset is
used for training and the remaining 30% is used for testing

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_train <- ToothGrowth[train_index, ]
ToothGrowth_test <- ToothGrowth[-train_index, ]
```

#### Train the model

We apply the 5-fold cross validation resampling method

``` r
set.seed(7)

train_control <- trainControl(method = "cv", number = 5)
ToothGrowth_caret_model_rpart <- train(supp ~ ., data = ToothGrowth,
                                  method = "rpart", metric = "Accuracy",
                                  trControl = train_control)
```

#### Display the model’s details

``` r
print(ToothGrowth_caret_model_rpart)
```

    ## CART 
    ## 
    ## 60 samples
    ##  2 predictor
    ##  2 classes: 'OJ', 'VC' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 48, 48, 48, 48, 48 
    ## Resampling results across tuning parameters:
    ## 
    ##   cp         Accuracy   Kappa      
    ##   0.0000000  0.4666667  -0.06666667
    ##   0.1666667  0.5833333   0.16666667
    ##   0.3333333  0.4500000  -0.10000000
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was cp = 0.1666667.

#### Make predictions

``` r
predictions <- predict(ToothGrowth_model_rpart,
                       ToothGrowth_test[, 1:3],
                       type = "class")
```

#### Display the model’s evaluation metrics

``` r
table(predictions, ToothGrowth_test$supp)
```

    ##            
    ## predictions OJ VC
    ##          OJ  3  1
    ##          VC  6  8

``` r
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         ToothGrowth_test[, 1:3]$supp)
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction OJ VC
    ##         OJ  3  1
    ##         VC  6  8
    ##                                          
    ##                Accuracy : 0.6111         
    ##                  95% CI : (0.3575, 0.827)
    ##     No Information Rate : 0.5            
    ##     P-Value [Acc > NIR] : 0.2403         
    ##                                          
    ##                   Kappa : 0.2222         
    ##                                          
    ##  Mcnemar's Test P-Value : 0.1306         
    ##                                          
    ##             Sensitivity : 0.3333         
    ##             Specificity : 0.8889         
    ##          Pos Pred Value : 0.7500         
    ##          Neg Pred Value : 0.5714         
    ##              Prevalence : 0.5000         
    ##          Detection Rate : 0.1667         
    ##    Detection Prevalence : 0.2222         
    ##       Balanced Accuracy : 0.6111         
    ##                                          
    ##        'Positive' Class : OJ             
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2042nd%20Code%20Chunk-1.png)<!-- -->

## 2. Naïve Bayes

### 2.a. Naïve Bayes Classifier for a Classification Problem without CARET

#### Load and split the dataset

``` r
data(ToothGrowth)
```

\####Split the dataset into training and testing 70% of the dataset is
used for training and the remaining 30% is used for testing

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_train <- ToothGrowth[train_index, ]
ToothGrowth_test <- ToothGrowth[-train_index, ]
```

#### Train the model

We apply the 5-fold cross validation resampling method

``` r
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)
ToothGrowth_caret_model_nb <- train(supp ~ .,
                               data = ToothGrowth_train,
                               method = "nb", metric = "Accuracy",
                               trControl = train_control)
```

#### Display the model’s details

``` r
print(ToothGrowth_caret_model_nb)
```

    ## Naive Bayes 
    ## 
    ## 42 samples
    ##  2 predictor
    ##  2 classes: 'OJ', 'VC' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 34, 33, 34, 34, 33 
    ## Resampling results across tuning parameters:
    ## 
    ##   usekernel  Accuracy   Kappa      
    ##   FALSE      0.4055556  -0.20076923
    ##    TRUE      0.5527778   0.08846154
    ## 
    ## Tuning parameter 'fL' was held constant at a value of 0
    ## Tuning
    ##  parameter 'adjust' was held constant at a value of 1
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were fL = 0, usekernel = TRUE and adjust
    ##  = 1.

#### Make predictions

``` r
predictions <- predict(ToothGrowth_caret_model_nb,
                       ToothGrowth_test[, 1:3])
```

#### Display the model’s evaluation metrics

``` r
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         ToothGrowth_test[, 1:3]$supp)
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction OJ VC
    ##         OJ  6  2
    ##         VC  3  7
    ##                                           
    ##                Accuracy : 0.7222          
    ##                  95% CI : (0.4652, 0.9031)
    ##     No Information Rate : 0.5             
    ##     P-Value [Acc > NIR] : 0.04813         
    ##                                           
    ##                   Kappa : 0.4444          
    ##                                           
    ##  Mcnemar's Test P-Value : 1.00000         
    ##                                           
    ##             Sensitivity : 0.6667          
    ##             Specificity : 0.7778          
    ##          Pos Pred Value : 0.7500          
    ##          Neg Pred Value : 0.7000          
    ##              Prevalence : 0.5000          
    ##          Detection Rate : 0.3333          
    ##    Detection Prevalence : 0.4444          
    ##       Balanced Accuracy : 0.7222          
    ##                                           
    ##        'Positive' Class : OJ              
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2048th%20Code%20Chunk-1.png)<!-- -->

## 3. k-Nearest Neighbours

### 3.a. kNN for a classification problem without CARET’s train function

#### Load and split the dataset

``` r
data(ToothGrowth)
```

#### Split the dataset into training and testing

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_train <- ToothGrowth[train_index, ]
ToothGrowth_test <- ToothGrowth[-train_index, ]
```

#### Train the model

``` r
ToothGrowth_caret_model_knn <- knn3(supp ~ ., data = ToothGrowth_train, k=3)
```

#### Display the model’s details

``` r
print(ToothGrowth_caret_model_knn)
```

    ## 3-nearest neighbor model
    ## Training set outcome distribution:
    ## 
    ## OJ VC 
    ## 21 21

#### Make predictions

``` r
predictions <- predict(ToothGrowth_caret_model_knn,
                       ToothGrowth_test[, 1:3],
                       type = "class")
```

#### Display the model’s evaluation metrics

``` r
table(predictions, ToothGrowth_test$supp)
```

    ##            
    ## predictions OJ VC
    ##          OJ  6  3
    ##          VC  3  6

### 3.b. kNN for a classification problem with CARET’s train function

#### Load and split the dataset

``` r
data(ToothGrowth)
```

\####Split the dataset into training and testing

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_train <- ToothGrowth[train_index, ]
ToothGrowth_test <- ToothGrowth[-train_index, ]
```

#### Train the model

``` r
set.seed(7)
train_control <- trainControl(method = "cv", number = 10)
ToothGrowth_caret_model_knn <- train(supp ~ ., data = ToothGrowth,
                                method = "knn", metric = "Accuracy",
                                preProcess = c("center", "scale"),
                                trControl = train_control)
```

#### Display the model’s details

``` r
print(ToothGrowth_caret_model_knn)
```

    ## k-Nearest Neighbors 
    ## 
    ## 60 samples
    ##  2 predictor
    ##  2 classes: 'OJ', 'VC' 
    ## 
    ## Pre-processing: centered (2), scaled (2) 
    ## Resampling: Cross-Validated (10 fold) 
    ## Summary of sample sizes: 54, 54, 54, 54, 54, 54, ... 
    ## Resampling results across tuning parameters:
    ## 
    ##   k  Accuracy   Kappa    
    ##   5  0.7000000  0.4000000
    ##   7  0.5833333  0.1666667
    ##   9  0.5833333  0.1666667
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was k = 5.

#### Make predictions

``` r
predictions <- predict(ToothGrowth_caret_model_knn,
                       ToothGrowth_test[, 1:3])
```

#### Display the model’s evaluation metrics

``` r
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         ToothGrowth_test[, 1:2]$supp)
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction OJ VC
    ##         OJ  7  2
    ##         VC  2  7
    ##                                           
    ##                Accuracy : 0.7778          
    ##                  95% CI : (0.5236, 0.9359)
    ##     No Information Rate : 0.5             
    ##     P-Value [Acc > NIR] : 0.01544         
    ##                                           
    ##                   Kappa : 0.5556          
    ##                                           
    ##  Mcnemar's Test P-Value : 1.00000         
    ##                                           
    ##             Sensitivity : 0.7778          
    ##             Specificity : 0.7778          
    ##          Pos Pred Value : 0.7778          
    ##          Neg Pred Value : 0.7778          
    ##              Prevalence : 0.5000          
    ##          Detection Rate : 0.3889          
    ##    Detection Prevalence : 0.5000          
    ##       Balanced Accuracy : 0.7778          
    ##                                           
    ##        'Positive' Class : OJ              
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2060th%20Code%20Chunk-1.png)<!-- -->

## 4. Support Vector Machine

### 4.a. SVM Classifier for a classification problem without CARET

#### Load and split the dataset

``` r
data(ToothGrowth)
```

\####Split the dataset into training and testing

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_train <- ToothGrowth[train_index, ]
ToothGrowth_test <- ToothGrowth[-train_index, ]
```

#### Train the model

``` r
ToothGrowth_model_svm <- ksvm(supp ~ ., data = ToothGrowth_train,
                         kernel = "rbfdot")
```

#### Display the model’s details

``` r
print(ToothGrowth_model_svm)
```

    ## Support Vector Machine object of class "ksvm" 
    ## 
    ## SV type: C-svc  (classification) 
    ##  parameter : cost C = 1 
    ## 
    ## Gaussian Radial Basis kernel function. 
    ##  Hyperparameter : sigma =  0.761304902559983 
    ## 
    ## Number of Support Vectors : 32 
    ## 
    ## Objective Function Value : -26.3147 
    ## Training error : 0.214286

#### Make predictions

``` r
predictions <- predict(ToothGrowth_model_svm, ToothGrowth_test[, 1:3],
                       type = "response")
```

#### Display the model’s evaluation metrics

``` r
table(predictions, ToothGrowth_test$supp)
```

    ##            
    ## predictions OJ VC
    ##          OJ  6  5
    ##          VC  3  4

``` r
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         ToothGrowth_test[, 1:3]$supp)
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction OJ VC
    ##         OJ  6  5
    ##         VC  3  4
    ##                                           
    ##                Accuracy : 0.5556          
    ##                  95% CI : (0.3076, 0.7847)
    ##     No Information Rate : 0.5             
    ##     P-Value [Acc > NIR] : 0.4073          
    ##                                           
    ##                   Kappa : 0.1111          
    ##                                           
    ##  Mcnemar's Test P-Value : 0.7237          
    ##                                           
    ##             Sensitivity : 0.6667          
    ##             Specificity : 0.4444          
    ##          Pos Pred Value : 0.5455          
    ##          Neg Pred Value : 0.5714          
    ##              Prevalence : 0.5000          
    ##          Detection Rate : 0.3333          
    ##    Detection Prevalence : 0.6111          
    ##       Balanced Accuracy : 0.5556          
    ##                                           
    ##        'Positive' Class : OJ              
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2066th%20Code%20Chunk-1.png)<!-- -->

### 4.b. SVM Classifier for a classification problem with CARET —-

#### Load and split the dataset

``` r
data(ToothGrowth)
```

\####Split the dataset into training and testing

``` r
train_index <- createDataPartition(ToothGrowth$supp,
                                   p = 0.7,
                                   list = FALSE)
ToothGrowth_train <- ToothGrowth[train_index, ]
ToothGrowth_test <- ToothGrowth[-train_index, ]
```

#### Train the model

``` r
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)
ToothGrowth_caret_model_svm_radial <- # nolint: object_length_linter.
  train(supp ~ ., data = ToothGrowth_train, method = "svmRadial",
        metric = "Accuracy", trControl = train_control)
```

#### Display the model’s details

``` r
print(ToothGrowth_caret_model_svm_radial)
```

    ## Support Vector Machines with Radial Basis Function Kernel 
    ## 
    ## 42 samples
    ##  2 predictor
    ##  2 classes: 'OJ', 'VC' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 34, 33, 34, 34, 33 
    ## Resampling results across tuning parameters:
    ## 
    ##   C     Accuracy   Kappa       
    ##   0.25  0.4555556  -0.070000000
    ##   0.50  0.5000000   0.004418605
    ##   1.00  0.5472222   0.085263158
    ## 
    ## Tuning parameter 'sigma' was held constant at a value of 0.6987905
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were sigma = 0.6987905 and C = 1.

#### Make predictions

``` r
predictions <- predict(ToothGrowth_caret_model_svm_radial,
                       ToothGrowth_test[, 1:3])
```

#### Display the model’s evaluation metrics

``` r
table(predictions, ToothGrowth_test$supp)
```

    ##            
    ## predictions OJ VC
    ##          OJ  6  3
    ##          VC  3  6

``` r
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         ToothGrowth_test[, 1:3]$supp)
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction OJ VC
    ##         OJ  6  3
    ##         VC  3  6
    ##                                           
    ##                Accuracy : 0.6667          
    ##                  95% CI : (0.4099, 0.8666)
    ##     No Information Rate : 0.5             
    ##     P-Value [Acc > NIR] : 0.1189          
    ##                                           
    ##                   Kappa : 0.3333          
    ##                                           
    ##  Mcnemar's Test P-Value : 1.0000          
    ##                                           
    ##             Sensitivity : 0.6667          
    ##             Specificity : 0.6667          
    ##          Pos Pred Value : 0.6667          
    ##          Neg Pred Value : 0.6667          
    ##              Prevalence : 0.5000          
    ##          Detection Rate : 0.3333          
    ##    Detection Prevalence : 0.5000          
    ##       Balanced Accuracy : 0.6667          
    ##                                           
    ##        'Positive' Class : OJ              
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2072nd%20Code%20Chunk-1.png)<!-- -->
