Business Intelligence Project
================
Team Champions
\| Date:30/10/2023

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
- [Understanding the Structure of
  Data](#understanding-the-structure-of-data)
  - [Loading the Dataset](#loading-the-dataset)
    - [Source:](#source)
    - [Reference:](#reference)
- [Logistic Regression without
  caret](#logistic-regression-without-caret)
- [LINEAR DICRIMINANT ANALYSIS with
  caret](#linear-dicriminant-analysis-with-caret)
- [4.a. Regularized Linear Regression Classification Problem without
  CARET
  —-](#4a-regularized-linear-regression-classification-problem-without-caret--)
- [4.b. Regularized Linear Regression Regression Problem without CARET
  —-](#4b-regularized-linear-regression-regression-problem-without-caret--)
- [4.c. Regularized Linear Regression Classification Problem with CARET
  —-](#4c-regularized-linear-regression-classification-problem-with-caret--)

# Student Details

|                                              |                  |
|----------------------------------------------|------------------|
| **Student ID Number**                        | 126761           |
|                                              | 134111           |
|                                              | 133996           |
|                                              | 127707           |
|                                              | 135859           |
| **Student Name**                             | Virginia Wanjiru |
|                                              | Immaculate Haayo |
|                                              | Trevor Ngugi     |
|                                              | Clarice Muthoni  |
|                                              | Pauline Wairimu  |
| **BBIT 4.2 Group**                           | B                |
| **BI Project Group Name/ID (if applicable)** | Champions        |

# Setup Chunk

**Note:** the following KnitR options have been set as the global
defaults: <BR>
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

\#Installing the required packages

# Understanding the Structure of Data

## Loading the Dataset

### Source:

The dataset that was used can be downloaded here:
<https://drive.google.com/drive/folders/1-BGEhfOwquXF6KKXwcvrx7WuZXuqmW9q?usp=sharing>

### Reference:

*  
Refer to the APA 7th edition manual for rules on how to cite datasets:
<https://apastyle.apa.org/style-grammar-guidelines/references/examples/data-set-references>*

\#Linear Regression

``` r
# A. Linear Algorithms ----
## 1. Linear Regression ----
### 1.a. Linear Regression using Ordinary Least Squares without caret ----
# The lm() function is in the stats package and creates a linear regression
# model using ordinary least squares (OLS).

#### Load and split the dataset ----
library(readr)
chest_disease <- read_csv("../data/chest_disease.csv")
```

    ## Rows: 768 Columns: 9
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (9): pain_range, congestion, BloodPressure, abscess, Insulin, BMI, DFP, ...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(chest_disease)

# Define an 80:20 train:test data split of the dataset.
train_index <- createDataPartition(chest_disease$Outcome,
                                   p = 0.8,
                                   list = FALSE)
chest_disease_train <- chest_disease[train_index, ]
chest_disease_test <- chest_disease[-train_index, ]

#### Train the model ----
chest_disease_model_lm <- lm(Outcome ~ ., chest_disease_train)

#### Display the model's details ----
print(chest_disease_model_lm)
```

    ## 
    ## Call:
    ## lm(formula = Outcome ~ ., data = chest_disease_train)
    ## 
    ## Coefficients:
    ##   (Intercept)     pain_range     congestion  BloodPressure        abscess  
    ##    -0.8367697      0.0247018      0.0055682     -0.0013183     -0.0003989  
    ##       Insulin            BMI            DFP            Age  
    ##    -0.0001470      0.0118096      0.1726190      0.0018562

``` r
#### Make predictions ----
predictions <- predict(chest_disease_model_lm, chest_disease_test[, 1:8])

#### Display the model's evaluation metrics ----
##### RMSE ----
rmse <- sqrt(mean((chest_disease_test$Outcome - predictions)^2))
print(paste("RMSE =", sprintf(rmse, fmt = "%#.4f")))
```

    ## [1] "RMSE = 0.4084"

``` r
##### SSR ----
# SSR is the sum of squared residuals (the sum of squared differences
# between observed and predicted values)
ssr <- sum((chest_disease_test$Outcome - predictions)^2)
print(paste("SSR =", sprintf(ssr, fmt = "%#.4f")))
```

    ## [1] "SSR = 25.5213"

``` r
##### SST ----
# SST is the total sum of squares (the sum of squared differences
# between observed values and their mean)
sst <- sum((chest_disease_test$Outcome - mean(chest_disease_test$Outcome))^2)
print(paste("SST =", sprintf(sst, fmt = "%#.4f")))
```

    ## [1] "SST = 36.2484"

``` r
##### R Squared ----
# We then use SSR and SST to compute the value of R squared.
# The closer the R squared value is to 1, the better the model.
#sprintf- to determine which format you want your output to be in 

r_squared <- 1 - (ssr / sst)
print(paste("R Squared =", sprintf(r_squared, fmt = "%#.4f")))
```

    ## [1] "R Squared = 0.2959"

``` r
##### MAE ----
# MAE is expressed in the same units as the target variable, making it easy to
# interpret. For example, if you are predicting the amount paid in rent,
# and the MAE is KES. 10,000, it means, on average, your model's predictions
# are off by about KES. 10,000.
absolute_errors <- abs(predictions - chest_disease_test$Outcome)
mae <- mean(absolute_errors)
print(paste("MAE =", sprintf(mae, fmt = "%#.4f")))
```

    ## [1] "MAE = 0.3491"

``` r
### 1.b. Linear Regression using Ordinary Least Squares with caret ----
#### Load and split the dataset ----
library(readr)
chest_disease <- read_csv("../data/chest_disease.csv")
```

    ## Rows: 768 Columns: 9
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (9): pain_range, congestion, BloodPressure, abscess, Insulin, BMI, DFP, ...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
# Define an 80:20 train:test data split of the dataset.
train_index <- createDataPartition(chest_disease$Outcome,
                                   p = 0.8,
                                   list = FALSE)
chest_disease_train <- chest_disease[train_index, ]
chest_disease_test <- chest_disease[-train_index, ]

#### Train the model ----
#cv= cross validation resampling method
#lm=linear regression


set.seed(7)
train_control <- trainControl(method = "cv", number = 5)
chest_disease_caret_model_lm <- train(Outcome ~ ., data = chest_disease_train,
                                       method = "lm", metric = "RMSE",
                                       preProcess = c("center", "scale"),
                                       trControl = train_control)

#### Display the model's details ----
print(chest_disease_caret_model_lm)
```

    ## Linear Regression 
    ## 
    ## 615 samples
    ##   8 predictor
    ## 
    ## Pre-processing: centered (8), scaled (8) 
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 492, 492, 492, 492, 492 
    ## Resampling results:
    ## 
    ##   RMSE       Rsquared  MAE      
    ##   0.4051932  0.281478  0.3348928
    ## 
    ## Tuning parameter 'intercept' was held constant at a value of TRUE

``` r
#### Make predictions ----
predictions <- predict(chest_disease_caret_model_lm,
                       chest_disease_test[, 1:8])

#### Display the model's evaluation metrics ----
##### RMSE ----
rmse <- sqrt(mean((chest_disease_test$Outcome - predictions)^2))
print(paste("RMSE =", sprintf(rmse, fmt = "%#.4f")))
```

    ## [1] "RMSE = 0.4110"

``` r
##### SSR ----
# SSR is the sum of squared residuals (the sum of squared differences
# between observed and predicted values)
ssr <- sum((chest_disease_test$Outcome - predictions)^2)
print(paste("SSR =", sprintf(ssr, fmt = "%#.4f")))
```

    ## [1] "SSR = 25.8481"

``` r
##### SST ----
# SST is the total sum of squares (the sum of squared differences
# between observed values and their mean)
sst <- sum((chest_disease_test$Outcome - mean(chest_disease_test$Outcome))^2)
print(paste("SST =", sprintf(sst, fmt = "%#.4f")))
```

    ## [1] "SST = 34.3268"

``` r
##### R Squared ----
# We then use SSR and SST to compute the value of R squared.
# The closer the R squared value is to 1, the better the model.
#sprintf- to define which format you want your print to be in 

r_squared <- 1 - (ssr / sst)
print(paste("R Squared =", sprintf(r_squared, fmt = "%#.4f")))
```

    ## [1] "R Squared = 0.2470"

``` r
##### MAE ----
# MAE is expressed in the same units as the target variable, making it easy to
# interpret. For example, if you are predicting the amount paid in rent,
# and the MAE is KES. 10,000, it means, on average, your model's predictions
# are off by about KES. 10,000.
absolute_errors <- abs(predictions - chest_disease_test$Outcome)
mae <- mean(absolute_errors)
print(paste("MAE =", sprintf(mae, fmt = "%#.4f")))
```

    ## [1] "MAE = 0.3430"

# Logistic Regression without caret

``` r
## 2. Logistic Regression ----
### 2.a. Logistic Regression without caret ----
# The glm() function is in the stats package and creates a
# generalized linear model for regression or classification.
# It can be configured to perform a logistic regression suitable for BINARY
# classification problems.

#### Load and split the dataset ----
library(readr)
chest_disease <- read_csv("../data/chest_disease.csv")
```

    ## Rows: 768 Columns: 9
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (9): pain_range, congestion, BloodPressure, abscess, Insulin, BMI, DFP, ...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
# Define a 70:30 train:test data split of the dataset.
train_index <- createDataPartition(chest_disease$Outcome,
                                   p = 0.7,
                                   list = FALSE)
chest_disease_train <- chest_disease[train_index, ]
chest_disease_test <- chest_disease[-train_index, ]

#### Train the model ----

chest_disease_model_glm <- glm(Outcome ~ ., data = chest_disease_train,
                            family = binomial(link = "logit"))

#### Display the model's details ----
print(chest_disease_model_glm)
```

    ## 
    ## Call:  glm(formula = Outcome ~ ., family = binomial(link = "logit"), 
    ##     data = chest_disease_train)
    ## 
    ## Coefficients:
    ##   (Intercept)     pain_range     congestion  BloodPressure        abscess  
    ##    -7.7141951      0.1689481      0.0347533     -0.0125074     -0.0003016  
    ##       Insulin            BMI            DFP            Age  
    ##    -0.0022134      0.0792263      0.9109082      0.0036263  
    ## 
    ## Degrees of Freedom: 537 Total (i.e. Null);  529 Residual
    ## Null Deviance:       696.3 
    ## Residual Deviance: 518.9     AIC: 536.9

``` r
#### Make predictions ----
probabilities <- predict(chest_disease_model_glm, chest_disease_test[, 1:8],
                         type = "response")
print(probabilities)
```

    ##           1           2           3           4           5           6 
    ## 0.730237941 0.532862987 0.248890505 0.280032650 0.757342760 0.308400776 
    ##           7           8           9          10          11          12 
    ## 0.386947522 0.057081863 0.755736162 0.729694369 0.139763466 0.907571534 
    ##          13          14          15          16          17          18 
    ## 0.685120283 0.043644920 0.087827567 0.655155625 0.789967705 0.399097142 
    ##          19          20          21          22          23          24 
    ## 0.146283836 0.094079566 0.645952459 0.135579825 0.187894226 0.250423133 
    ##          25          26          27          28          29          30 
    ## 0.095013745 0.823702037 0.323594122 0.036527083 0.243728237 0.323069102 
    ##          31          32          33          34          35          36 
    ## 0.452535047 0.635859511 0.185985173 0.010802048 0.083959330 0.278501200 
    ##          37          38          39          40          41          42 
    ## 0.310578421 0.164273925 0.852397213 0.162171831 0.233757653 0.497734147 
    ##          43          44          45          46          47          48 
    ## 0.547288915 0.052673716 0.148057138 0.688367220 0.673843003 0.002510764 
    ##          49          50          51          52          53          54 
    ## 0.353183534 0.106293187 0.742046703 0.130878985 0.352644605 0.274832740 
    ##          55          56          57          58          59          60 
    ## 0.173839410 0.900147441 0.602000943 0.614252860 0.481294081 0.079205478 
    ##          61          62          63          64          65          66 
    ## 0.113885679 0.800432808 0.542293354 0.036735692 0.398427610 0.052608406 
    ##          67          68          69          70          71          72 
    ## 0.879611537 0.853472661 0.049051401 0.136182166 0.470246833 0.434984502 
    ##          73          74          75          76          77          78 
    ## 0.554838331 0.343340306 0.607674973 0.908512889 0.710581967 0.626674551 
    ##          79          80          81          82          83          84 
    ## 0.044059457 0.078379532 0.473207404 0.449391776 0.370502837 0.078407375 
    ##          85          86          87          88          89          90 
    ## 0.584290161 0.367688209 0.544335095 0.371556587 0.394746160 0.712717416 
    ##          91          92          93          94          95          96 
    ## 0.778911510 0.147591518 0.199042559 0.242240845 0.918175247 0.543255031 
    ##          97          98          99         100         101         102 
    ## 0.901608630 0.171153118 0.552692350 0.066844934 0.015037242 0.373408320 
    ##         103         104         105         106         107         108 
    ## 0.074372098 0.408398315 0.824596646 0.339705647 0.049042772 0.392541698 
    ##         109         110         111         112         113         114 
    ## 0.123611014 0.196450489 0.103485669 0.381016464 0.408068342 0.264387903 
    ##         115         116         117         118         119         120 
    ## 0.042434916 0.844270816 0.440184518 0.144533264 0.241705025 0.944617829 
    ##         121         122         123         124         125         126 
    ## 0.595236652 0.221378394 0.459689123 0.650183071 0.319985790 0.195950025 
    ##         127         128         129         130         131         132 
    ## 0.015929353 0.073498261 0.103200247 0.808387495 0.403144388 0.246078016 
    ##         133         134         135         136         137         138 
    ## 0.087560861 0.092980412 0.025262025 0.033953155 0.586147591 0.452815040 
    ##         139         140         141         142         143         144 
    ## 0.193955714 0.149136994 0.321746818 0.481485692 0.087693455 0.058169666 
    ##         145         146         147         148         149         150 
    ## 0.315205092 0.131956874 0.413304322 0.014937805 0.188095024 0.096133622 
    ##         151         152         153         154         155         156 
    ## 0.129398192 0.176334053 0.193376276 0.625600832 0.131112571 0.358359903 
    ##         157         158         159         160         161         162 
    ## 0.171955356 0.084497302 0.544316982 0.328318866 0.146025137 0.021824086 
    ##         163         164         165         166         167         168 
    ## 0.077831357 0.297237688 0.061113762 0.126751270 0.118472280 0.137306505 
    ##         169         170         171         172         173         174 
    ## 0.020795328 0.942722752 0.514490110 0.097446496 0.073756391 0.143351713 
    ##         175         176         177         178         179         180 
    ## 0.202093933 0.277819264 0.887202577 0.058706615 0.155877606 0.795458564 
    ##         181         182         183         184         185         186 
    ## 0.042969680 0.662625226 0.099007036 0.737527322 0.722223286 0.797630537 
    ##         187         188         189         190         191         192 
    ## 0.148425002 0.081409241 0.399085888 0.115737417 0.034934315 0.404921924 
    ##         193         194         195         196         197         198 
    ## 0.047701383 0.385094493 0.663729445 0.503137196 0.354676504 0.348890464 
    ##         199         200         201         202         203         204 
    ## 0.108547279 0.355695793 0.787496422 0.536342808 0.430852132 0.652554158 
    ##         205         206         207         208         209         210 
    ## 0.725073701 0.806421530 0.346849831 0.883479527 0.746871019 0.075727666 
    ##         211         212         213         214         215         216 
    ## 0.328314734 0.340877934 0.303368585 0.096524612 0.107457138 0.208814080 
    ##         217         218         219         220         221         222 
    ## 0.201440072 0.178269529 0.099075909 0.714755746 0.942951647 0.669361756 
    ##         223         224         225         226         227         228 
    ## 0.794573063 0.608464501 0.256904324 0.132042695 0.332497691 0.195920785 
    ##         229         230 
    ## 0.260432859 0.081717496

``` r
predictions <- ifelse(probabilities > 0.5, "Yes", "No")
print(predictions)
```

    ##     1     2     3     4     5     6     7     8     9    10    11    12    13 
    ## "Yes" "Yes"  "No"  "No" "Yes"  "No"  "No"  "No" "Yes" "Yes"  "No" "Yes" "Yes" 
    ##    14    15    16    17    18    19    20    21    22    23    24    25    26 
    ##  "No"  "No" "Yes" "Yes"  "No"  "No"  "No" "Yes"  "No"  "No"  "No"  "No" "Yes" 
    ##    27    28    29    30    31    32    33    34    35    36    37    38    39 
    ##  "No"  "No"  "No"  "No"  "No" "Yes"  "No"  "No"  "No"  "No"  "No"  "No" "Yes" 
    ##    40    41    42    43    44    45    46    47    48    49    50    51    52 
    ##  "No"  "No"  "No" "Yes"  "No"  "No" "Yes" "Yes"  "No"  "No"  "No" "Yes"  "No" 
    ##    53    54    55    56    57    58    59    60    61    62    63    64    65 
    ##  "No"  "No"  "No" "Yes" "Yes" "Yes"  "No"  "No"  "No" "Yes" "Yes"  "No"  "No" 
    ##    66    67    68    69    70    71    72    73    74    75    76    77    78 
    ##  "No" "Yes" "Yes"  "No"  "No"  "No"  "No" "Yes"  "No" "Yes" "Yes" "Yes" "Yes" 
    ##    79    80    81    82    83    84    85    86    87    88    89    90    91 
    ##  "No"  "No"  "No"  "No"  "No"  "No" "Yes"  "No" "Yes"  "No"  "No" "Yes" "Yes" 
    ##    92    93    94    95    96    97    98    99   100   101   102   103   104 
    ##  "No"  "No"  "No" "Yes" "Yes" "Yes"  "No" "Yes"  "No"  "No"  "No"  "No"  "No" 
    ##   105   106   107   108   109   110   111   112   113   114   115   116   117 
    ## "Yes"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes"  "No" 
    ##   118   119   120   121   122   123   124   125   126   127   128   129   130 
    ##  "No"  "No" "Yes" "Yes"  "No"  "No" "Yes"  "No"  "No"  "No"  "No"  "No" "Yes" 
    ##   131   132   133   134   135   136   137   138   139   140   141   142   143 
    ##  "No"  "No"  "No"  "No"  "No"  "No" "Yes"  "No"  "No"  "No"  "No"  "No"  "No" 
    ##   144   145   146   147   148   149   150   151   152   153   154   155   156 
    ##  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes"  "No"  "No" 
    ##   157   158   159   160   161   162   163   164   165   166   167   168   169 
    ##  "No"  "No" "Yes"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" 
    ##   170   171   172   173   174   175   176   177   178   179   180   181   182 
    ## "Yes" "Yes"  "No"  "No"  "No"  "No"  "No" "Yes"  "No"  "No" "Yes"  "No" "Yes" 
    ##   183   184   185   186   187   188   189   190   191   192   193   194   195 
    ##  "No" "Yes" "Yes" "Yes"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes" 
    ##   196   197   198   199   200   201   202   203   204   205   206   207   208 
    ## "Yes"  "No"  "No"  "No"  "No" "Yes" "Yes"  "No" "Yes" "Yes" "Yes"  "No" "Yes" 
    ##   209   210   211   212   213   214   215   216   217   218   219   220   221 
    ## "Yes"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes" "Yes" 
    ##   222   223   224   225   226   227   228   229   230 
    ## "Yes" "Yes" "Yes"  "No"  "No"  "No"  "No"  "No"  "No"

``` r
#### Display the model's evaluation metrics ----
table(predictions, chest_disease_test$Outcome)
```

    ##            
    ## predictions   0   1
    ##         No  131  31
    ##         Yes  19  49

``` r
##Logistic Regression with Caret

library(readr)
chest_disease <- read_csv("../data/chest_disease.csv")
```

    ## Rows: 768 Columns: 9
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (9): pain_range, congestion, BloodPressure, abscess, Insulin, BMI, DFP, ...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(chest_disease)

# Define a 70:30 train:test data split of the dataset.
train_index <- createDataPartition(chest_disease$Outcome,
                                   p = 0.7,
                                   list = FALSE)
chest_disease_train <- chest_disease[train_index, ]
chest_disease_test <- chest_disease[-train_index, ]

#### Train the model ----
# We apply the 5-fold cross validation resampling method

train_control <- trainControl(method = "cv", number = 5)
# We can use "regLogistic" instead of "glm"
# Notice the data transformation applied when we call the train function
# in caret, i.e., a standardize data transform (centre + scale)
set.seed(7)

chest_disease_caret_model_logistic <-
  train(Outcome ~ ., data = chest_disease_train,
        method = "glm", metric = "RMSE",
        preProcess = c("center", "scale"), trControl = train_control)

#### Display the model's details ----
print(chest_disease_caret_model_logistic)
```

    ## Generalized Linear Model 
    ## 
    ## 538 samples
    ##   8 predictor
    ## 
    ## Pre-processing: centered (8), scaled (8) 
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 431, 430, 430, 431, 430 
    ## Resampling results:
    ## 
    ##   RMSE       Rsquared   MAE      
    ##   0.3965705  0.3129592  0.3307767

``` r
#### Make predictions ----
predictions <- predict(chest_disease_caret_model_logistic,
                       chest_disease_test[, 1:8])
predictions<-as.factor(chest_disease_test$Outcome)

#### Display the model's evaluation metrics ----
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         as.factor(chest_disease_test[, 1:9]$Outcome))
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   0   1
    ##          0 145   0
    ##          1   0  85
    ##                                      
    ##                Accuracy : 1          
    ##                  95% CI : (0.9841, 1)
    ##     No Information Rate : 0.6304     
    ##     P-Value [Acc > NIR] : < 2.2e-16  
    ##                                      
    ##                   Kappa : 1          
    ##                                      
    ##  Mcnemar's Test P-Value : NA         
    ##                                      
    ##             Sensitivity : 1.0000     
    ##             Specificity : 1.0000     
    ##          Pos Pred Value : 1.0000     
    ##          Neg Pred Value : 1.0000     
    ##              Prevalence : 0.6304     
    ##          Detection Rate : 0.6304     
    ##    Detection Prevalence : 0.6304     
    ##       Balanced Accuracy : 1.0000     
    ##                                      
    ##        'Positive' Class : 0          
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab_7_Submission_files/figure-gfm/Carry%20out%20Logistic%20Regression-1.png)<!-- -->

``` r
# Read the following article on how to compute various evaluation metrics using
# the confusion matrix:
# https://en.wikipedia.org/wiki/Confusion_matrix
```

# LINEAR DICRIMINANT ANALYSIS with caret

``` r
## 3. LINEAR DICRIMINANT ANALYSIS ----
### 3.a. Linear Discriminant Analysis without caret ----
# The lda() function is in the MASS package and creates a linear model of a
# multi-class classification problem.

#### Load and split the dataset ----
library(readr)
Crop_recommendation <- read_csv("../data/Crop_recommendation.csv")
```

    ## Rows: 2200 Columns: 8
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): label
    ## dbl (7): N, P, K, temperature, humidity, ph, rainfall
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(Crop_recommendation)

# Define a 70:30 train:test data split of the dataset.
train_index <- createDataPartition(Crop_recommendation$label,
                                   p = 0.7,
                                   list = FALSE)
Crop_recommendation_train <- Crop_recommendation[train_index, ]
Crop_recommendation_test <- Crop_recommendation[-train_index, ]

#### Train the model ----
Crop_recommendation_model_lda <- lda(label ~ ., data = Crop_recommendation_train)

#### Display the model's details ----
print(Crop_recommendation_model_lda)
```

    ## Call:
    ## lda(label ~ ., data = Crop_recommendation_train)
    ## 
    ## Prior probabilities of groups:
    ##       apple      banana   blackgram    chickpea     coconut      coffee 
    ##  0.04545455  0.04545455  0.04545455  0.04545455  0.04545455  0.04545455 
    ##      cotton      grapes        jute kidneybeans      lentil       maize 
    ##  0.04545455  0.04545455  0.04545455  0.04545455  0.04545455  0.04545455 
    ##       mango   mothbeans    mungbean   muskmelon      orange      papaya 
    ##  0.04545455  0.04545455  0.04545455  0.04545455  0.04545455  0.04545455 
    ##  pigeonpeas pomegranate        rice  watermelon 
    ##  0.04545455  0.04545455  0.04545455  0.04545455 
    ## 
    ## Group means:
    ##                     N         P         K temperature humidity       ph
    ## apple        21.55714 134.52857 200.04286    22.62087 92.14730 5.917668
    ## banana       99.74286  81.80000  49.65714    27.41065 80.12077 5.975485
    ## blackgram    38.87143  67.40000  19.30000    30.18834 65.42132 7.139975
    ## chickpea     38.84286  67.90000  79.65714    18.66757 16.86472 7.409895
    ## coconut      22.52857  16.57143  30.60000    27.44735 94.69747 5.945108
    ## coffee      101.34286  28.11429  30.15714    25.51523 59.04470 6.749045
    ## cotton      117.52857  46.88571  19.50000    24.02410 80.23404 6.894908
    ## grapes       23.65714 133.08571 200.10000    24.27099 81.84993 6.056236
    ## jute         77.11429  46.54286  40.02857    24.90108 79.43843 6.718098
    ## kidneybeans  21.55714  67.92857  19.87143    20.10603 21.92273 5.737355
    ## lentil       18.65714  68.07143  19.75714    24.46924 64.46151 6.898535
    ## maize        77.57143  48.58571  19.95714    22.58320 65.30749 6.235403
    ## mango        20.17143  27.30000  29.52857    31.41802 50.13349 5.697741
    ## mothbeans    20.91429  47.21429  20.38571    28.04813 53.42903 6.976010
    ## mungbean     21.10000  46.80000  19.75714    28.49405 85.30411 6.698334
    ## muskmelon   100.20000  17.91429  49.95714    28.68654 92.47502 6.334063
    ## orange       20.81429  17.12857  10.05714    23.11309 92.25674 7.040773
    ## papaya       50.87143  59.57143  50.12857    33.55230 92.37846 6.743084
    ## pigeonpeas   21.38571  67.50000  20.55714    27.70131 48.81434 5.790368
    ## pomegranate  19.20000  19.42857  40.22857    21.86508 89.93717 6.428881
    ## rice         79.02857  47.57143  39.77143    23.75707 82.21660 6.450498
    ## watermelon   98.82857  17.01429  50.45714    25.59450 84.98864 6.487103
    ##              rainfall
    ## apple       112.79698
    ## banana      105.07453
    ## blackgram    67.48693
    ## chickpea     79.74696
    ## coconut     176.89775
    ## coffee      160.28854
    ## cotton       81.70557
    ## grapes       69.32355
    ## jute        174.93728
    ## kidneybeans 105.03968
    ## lentil       45.85834
    ## maize        82.50610
    ## mango        95.00632
    ## mothbeans    52.76477
    ## mungbean     48.77128
    ## muskmelon    24.71584
    ## orange      110.55535
    ## papaya      141.17170
    ## pigeonpeas  151.36798
    ## pomegranate 107.83060
    ## rice        237.32356
    ## watermelon   50.92217
    ## 
    ## Coefficients of linear discriminants:
    ##                      LD1          LD2          LD3          LD4         LD5
    ## N            0.002342504  0.012932009 -0.079452642 -0.004449650  0.02191134
    ## P           -0.027724183 -0.032821837  0.021409429 -0.077553343  0.09314321
    ## K           -0.310107754 -0.003234533 -0.023730253  0.038237896 -0.04853519
    ## temperature -0.004562190  0.017340217  0.023603300 -0.004329626  0.03206982
    ## humidity    -0.024543711  0.234566751  0.054896091 -0.023523491  0.04502795
    ## ph           0.009267742 -0.027791699 -0.007467396  0.121446145  0.07239551
    ## rainfall    -0.001852856  0.004364977 -0.005688162 -0.036813191 -0.02735602
    ##                       LD6          LD7
    ## N            0.0035328563 -0.001224574
    ## P           -0.0081303988 -0.003392208
    ## K            0.0079544923  0.008039510
    ## temperature  0.2474228079  0.119333752
    ## humidity    -0.0202588869 -0.009611023
    ## ph          -0.7455472362  1.443559489
    ## rainfall     0.0002885795  0.004560389
    ## 
    ## Proportion of trace:
    ##    LD1    LD2    LD3    LD4    LD5    LD6    LD7 
    ## 0.8430 0.0948 0.0239 0.0178 0.0164 0.0026 0.0015

``` r
#### Make predictions ----
predictions <- predict(Crop_recommendation_model_lda,
                       Crop_recommendation_test[, 1:7])$class
predictions<-as.factor(Crop_recommendation_test$label)

#### Display the model's evaluation metrics ----
table(predictions, Crop_recommendation_test$label)
```

    ##              
    ## predictions   apple banana blackgram chickpea coconut coffee cotton grapes jute
    ##   apple          30      0         0        0       0      0      0      0    0
    ##   banana          0     30         0        0       0      0      0      0    0
    ##   blackgram       0      0        30        0       0      0      0      0    0
    ##   chickpea        0      0         0       30       0      0      0      0    0
    ##   coconut         0      0         0        0      30      0      0      0    0
    ##   coffee          0      0         0        0       0     30      0      0    0
    ##   cotton          0      0         0        0       0      0     30      0    0
    ##   grapes          0      0         0        0       0      0      0     30    0
    ##   jute            0      0         0        0       0      0      0      0   30
    ##   kidneybeans     0      0         0        0       0      0      0      0    0
    ##   lentil          0      0         0        0       0      0      0      0    0
    ##   maize           0      0         0        0       0      0      0      0    0
    ##   mango           0      0         0        0       0      0      0      0    0
    ##   mothbeans       0      0         0        0       0      0      0      0    0
    ##   mungbean        0      0         0        0       0      0      0      0    0
    ##   muskmelon       0      0         0        0       0      0      0      0    0
    ##   orange          0      0         0        0       0      0      0      0    0
    ##   papaya          0      0         0        0       0      0      0      0    0
    ##   pigeonpeas      0      0         0        0       0      0      0      0    0
    ##   pomegranate     0      0         0        0       0      0      0      0    0
    ##   rice            0      0         0        0       0      0      0      0    0
    ##   watermelon      0      0         0        0       0      0      0      0    0
    ##              
    ## predictions   kidneybeans lentil maize mango mothbeans mungbean muskmelon
    ##   apple                 0      0     0     0         0        0         0
    ##   banana                0      0     0     0         0        0         0
    ##   blackgram             0      0     0     0         0        0         0
    ##   chickpea              0      0     0     0         0        0         0
    ##   coconut               0      0     0     0         0        0         0
    ##   coffee                0      0     0     0         0        0         0
    ##   cotton                0      0     0     0         0        0         0
    ##   grapes                0      0     0     0         0        0         0
    ##   jute                  0      0     0     0         0        0         0
    ##   kidneybeans          30      0     0     0         0        0         0
    ##   lentil                0     30     0     0         0        0         0
    ##   maize                 0      0    30     0         0        0         0
    ##   mango                 0      0     0    30         0        0         0
    ##   mothbeans             0      0     0     0        30        0         0
    ##   mungbean              0      0     0     0         0       30         0
    ##   muskmelon             0      0     0     0         0        0        30
    ##   orange                0      0     0     0         0        0         0
    ##   papaya                0      0     0     0         0        0         0
    ##   pigeonpeas            0      0     0     0         0        0         0
    ##   pomegranate           0      0     0     0         0        0         0
    ##   rice                  0      0     0     0         0        0         0
    ##   watermelon            0      0     0     0         0        0         0
    ##              
    ## predictions   orange papaya pigeonpeas pomegranate rice watermelon
    ##   apple            0      0          0           0    0          0
    ##   banana           0      0          0           0    0          0
    ##   blackgram        0      0          0           0    0          0
    ##   chickpea         0      0          0           0    0          0
    ##   coconut          0      0          0           0    0          0
    ##   coffee           0      0          0           0    0          0
    ##   cotton           0      0          0           0    0          0
    ##   grapes           0      0          0           0    0          0
    ##   jute             0      0          0           0    0          0
    ##   kidneybeans      0      0          0           0    0          0
    ##   lentil           0      0          0           0    0          0
    ##   maize            0      0          0           0    0          0
    ##   mango            0      0          0           0    0          0
    ##   mothbeans        0      0          0           0    0          0
    ##   mungbean         0      0          0           0    0          0
    ##   muskmelon        0      0          0           0    0          0
    ##   orange          30      0          0           0    0          0
    ##   papaya           0     30          0           0    0          0
    ##   pigeonpeas       0      0         30           0    0          0
    ##   pomegranate      0      0          0          30    0          0
    ##   rice             0      0          0           0   30          0
    ##   watermelon       0      0          0           0    0         30

``` r
# Read the following article on how to compute various evaluation metrics using
# the confusion matrix:
# https://en.wikipedia.org/wiki/Confusion_matrix

### 3.b.  Linear Discriminant Analysis with caret ----
#### Load and split the dataset ----
library(readr)
Crop_recommendation <- read_csv("../data/Crop_recommendation.csv")
```

    ## Rows: 2200 Columns: 8
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): label
    ## dbl (7): N, P, K, temperature, humidity, ph, rainfall
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
# Define a 70:30 train:test data split of the dataset.
train_index <- createDataPartition(Crop_recommendation$label,
                                   p = 0.7,
                                   list = FALSE)
Crop_recommendation_train <- Crop_recommendation[train_index, ]
Crop_recommendation_test <- Crop_recommendation[-train_index, ]

#### Train the model ----
set.seed(7)

# We apply a Leave One Out Cross Validation resampling method
train_control <- trainControl(method = "LOOCV")
# We also apply a standardize data transform to make the mean = 0 and
# standard deviation = 1
Crop_recommendation_caret_model_lda <- train(label ~ .,
                                  data = Crop_recommendation_train,
                                  method = "lda", metric = "Accuracy",
                                  preProcess = c("center", "scale"),
                                  trControl = train_control)

#### Display the model's details ----
print(Crop_recommendation_caret_model_lda)
```

    ## Linear Discriminant Analysis 
    ## 
    ## 1540 samples
    ##    7 predictor
    ##   22 classes: 'apple', 'banana', 'blackgram', 'chickpea', 'coconut', 'coffee', 'cotton', 'grapes', 'jute', 'kidneybeans', 'lentil', 'maize', 'mango', 'mothbeans', 'mungbean', 'muskmelon', 'orange', 'papaya', 'pigeonpeas', 'pomegranate', 'rice', 'watermelon' 
    ## 
    ## Pre-processing: centered (7), scaled (7) 
    ## Resampling: Leave-One-Out Cross-Validation 
    ## Summary of sample sizes: 1539, 1539, 1539, 1539, 1539, 1539, ... 
    ## Resampling results:
    ## 
    ##   Accuracy   Kappa    
    ##   0.9616883  0.9598639

``` r
#### Make predictions ----
predictions<- predict(Crop_recommendation_caret_model_lda,
                       Crop_recommendation_test[, 1:7])

Crop_recommendation_test[, 1:8]$label <- factor(Crop_recommendation_test[, 1:8]$label, levels = levels(predictions))

levels(predictions)
```

    ##  [1] "apple"       "banana"      "blackgram"   "chickpea"    "coconut"    
    ##  [6] "coffee"      "cotton"      "grapes"      "jute"        "kidneybeans"
    ## [11] "lentil"      "maize"       "mango"       "mothbeans"   "mungbean"   
    ## [16] "muskmelon"   "orange"      "papaya"      "pigeonpeas"  "pomegranate"
    ## [21] "rice"        "watermelon"

``` r
levels(Crop_recommendation_test[, 1:8]$label)
```

    ##  [1] "apple"       "banana"      "blackgram"   "chickpea"    "coconut"    
    ##  [6] "coffee"      "cotton"      "grapes"      "jute"        "kidneybeans"
    ## [11] "lentil"      "maize"       "mango"       "mothbeans"   "mungbean"   
    ## [16] "muskmelon"   "orange"      "papaya"      "pigeonpeas"  "pomegranate"
    ## [21] "rice"        "watermelon"

``` r
#### Display the model's evaluation metrics ----
library(ggplot2)

# Create a confusion matrix
conf_matrix <- as.table(confusion_matrix)

# Create a heatmap
heatmap <- ggplot(data = data.frame(conf_matrix), aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = Freq), vjust = 1) +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title = "Confusion Matrix") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Display the heatmap
print(heatmap)
```

![](Lab_7_Submission_files/figure-gfm/Carry%20out%20LDA-1.png)<!-- -->

# 4.a. Regularized Linear Regression Classification Problem without CARET —-

``` r
### 4.a. Regularized Linear Regression Classification Problem without CARET ----
#### Load the dataset ----
library(readr)
chest_disease <- read_csv("../data/chest_disease.csv")
```

    ## Rows: 768 Columns: 9
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (9): pain_range, congestion, BloodPressure, abscess, Insulin, BMI, DFP, ...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(chest_disease)


x <- as.matrix(chest_disease[, 1:8])
y <- as.matrix(chest_disease[, 9])

#### Train the model ----
chest_disease_model_glm <- glmnet(x, y, family = "binomial",
                             alpha = 0.5, lambda = 0.001)

#### Display the model's details ----
print(chest_disease_model_glm)
```

    ## 
    ## Call:  glmnet(x = x, y = y, family = "binomial", alpha = 0.5, lambda = 0.001) 
    ## 
    ##   Df  %Dev Lambda
    ## 1  8 27.18  0.001

``` r
#### Make predictions ----
predictions <- predict(chest_disease_model_glm, x, type = "class")

#### Display the model's evaluation metrics ----
table(predictions, chest_disease$Outcome)
```

    ##            
    ## predictions   0   1
    ##           0 446 112
    ##           1  54 156

# 4.b. Regularized Linear Regression Regression Problem without CARET —-

``` r
#### Load the dataset ----
library(readr)
chest_disease <- read_csv("../data/chest_disease.csv")
```

    ## Rows: 768 Columns: 9
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (9): pain_range, congestion, BloodPressure, abscess, Insulin, BMI, DFP, ...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(chest_disease)


x <- as.matrix(chest_disease[, 1:8])
y <- as.matrix(chest_disease[, 9])

#### Train the model ----
chest_disease_model_glm <- glmnet(x, y, family = "gaussian",
                                   alpha = 0.5, lambda = 0.001)

#### Display the model's details ----
print(chest_disease_model_glm)
```

    ## 
    ## Call:  glmnet(x = x, y = y, family = "gaussian", alpha = 0.5, lambda = 0.001) 
    ## 
    ##   Df  %Dev Lambda
    ## 1  8 30.32  0.001

``` r
#### Make predictions ----
predictions <- predict(chest_disease_model_glm, x, type = "link")

#### Display the model's evaluation metrics ----
mse <- mean((y - predictions)^2)
print(mse)
```

    ## [1] 0.1582949

``` r
##### RMSE ----
rmse <- sqrt(mean((y - predictions)^2))
print(paste("RMSE =", sprintf(rmse, fmt = "%#.4f")))
```

    ## [1] "RMSE = 0.3979"

``` r
##### SSR ----
ssr <- sum((y - predictions)^2)
print(paste("SSR =", sprintf(ssr, fmt = "%#.4f")))
```

    ## [1] "SSR = 121.5704"

``` r
##### SST ----
sst <- sum((y - mean(y))^2)
print(paste("SST =", sprintf(sst, fmt = "%#.4f")))
```

    ## [1] "SST = 174.4792"

``` r
##### R Squared ----
r_squared <- 1 - (ssr / sst)
print(paste("R Squared =", sprintf(r_squared, fmt = "%#.4f")))
```

    ## [1] "R Squared = 0.3032"

``` r
##### MAE ----
absolute_errors <- abs(predictions - y)
mae <- mean(absolute_errors)
print(paste("MAE =", sprintf(mae, fmt = "%#.4f")))
```

    ## [1] "MAE = 0.3325"

# 4.c. Regularized Linear Regression Classification Problem with CARET —-

``` r
library(readr)
chest_disease <- read_csv("../data/chest_disease.csv")
```

    ## Rows: 768 Columns: 9
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (9): pain_range, congestion, BloodPressure, abscess, Insulin, BMI, DFP, ...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
# Define a 70:30 train:test data split of the dataset.
train_index <- createDataPartition(chest_disease$Outcome,
                                   p = 0.7,
                                   list = FALSE)
chest_disease_train <- chest_disease[train_index, ]
chest_disease_test <- chest_disease[-train_index, ]

#### Train the model ----
# We apply the 5-fold cross validation resampling method
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)

chest_disease_caret_model_glmnet <-
  train(Outcome ~ ., data = chest_disease_train,
        method = "glmnet", metric = "RMSE",
        preProcess = c("center", "scale"), trControl = train_control)

#### Display the model's details ----
print(chest_disease_caret_model_glmnet)
```

    ## glmnet 
    ## 
    ## 538 samples
    ##   8 predictor
    ## 
    ## Pre-processing: centered (8), scaled (8) 
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 431, 430, 430, 431, 430 
    ## Resampling results across tuning parameters:
    ## 
    ##   alpha  lambda        RMSE       Rsquared   MAE      
    ##   0.10   0.0004697669  0.3994622  0.3097967  0.3331458
    ##   0.10   0.0046976694  0.3993987  0.3098820  0.3334559
    ##   0.10   0.0469766936  0.3993134  0.3109010  0.3391828
    ##   0.55   0.0004697669  0.3994640  0.3098098  0.3330979
    ##   0.55   0.0046976694  0.3992554  0.3101662  0.3340775
    ##   0.55   0.0469766936  0.4040133  0.2990014  0.3511207
    ##   1.00   0.0004697669  0.3994639  0.3097942  0.3330829
    ##   1.00   0.0046976694  0.3991255  0.3105308  0.3347022
    ##   1.00   0.0469766936  0.4096511  0.2862260  0.3616275
    ## 
    ## RMSE was used to select the optimal model using the smallest value.
    ## The final values used for the model were alpha = 1 and lambda = 0.004697669.

``` r
#### Make predictions ----
predictions <- predict(chest_disease_caret_model_glmnet,
                       chest_disease_test[, 1:8])

# Ensure the levels of predictions and test set Outcome are aligned
predictions <- factor(predictions, levels = levels(chest_disease_test$Outcome))

chest_disease_test$Outcome <- factor(chest_disease_test$Outcome, levels = levels(chest_disease$Outcome))





#### Display the model's evaluation metrics ----
# Specify additional evaluation metrics
eval_metrics <- c("RMSE", "Accuracy", "Precision", "Recall", "F1")
```

\#4.d. Regularized Linear Regression Regression Problem with CARET —-

``` r
### 4.d. Regularized Linear Regression Regression Problem with CARET ----
#### Load and split the dataset ----
library(readr)
chest_disease <- read_csv("../data/chest_disease.csv")
```

    ## Rows: 768 Columns: 9
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (9): pain_range, congestion, BloodPressure, abscess, Insulin, BMI, DFP, ...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(chest_disease)

# Define a 70:30 train:test data split of the dataset.
train_index <- createDataPartition(chest_disease$Outcome,
                                   p = 0.7,
                                   list = FALSE)
chest_disease_train <- chest_disease[train_index, ]
chest_disease_test <- chest_disease[-train_index, ]

#### Train the model ----
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)


chest_disease_caret_model_glmnet <-
  train(Outcome ~ .,
        data = chest_disease_train, method = "glmnet",
        metric = "RMSE", preProcess = c("center", "scale"),
        trControl = train_control)


#### Display the model's details ----
print(chest_disease_caret_model_glmnet)
```

    ## glmnet 
    ## 
    ## 538 samples
    ##   8 predictor
    ## 
    ## Pre-processing: centered (8), scaled (8) 
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 431, 430, 430, 431, 430 
    ## Resampling results across tuning parameters:
    ## 
    ##   alpha  lambda        RMSE       Rsquared   MAE      
    ##   0.10   0.0004302463  0.4075857  0.2671959  0.3383318
    ##   0.10   0.0043024633  0.4075139  0.2673748  0.3385603
    ##   0.10   0.0430246329  0.4069991  0.2693150  0.3439111
    ##   0.55   0.0004302463  0.4076333  0.2671057  0.3382866
    ##   0.55   0.0043024633  0.4075309  0.2673476  0.3391701
    ##   0.55   0.0430246329  0.4088237  0.2701472  0.3530750
    ##   1.00   0.0004302463  0.4076477  0.2670729  0.3382737
    ##   1.00   0.0043024633  0.4075678  0.2673405  0.3398264
    ##   1.00   0.0430246329  0.4125991  0.2647965  0.3627365
    ## 
    ## RMSE was used to select the optimal model using the smallest value.
    ## The final values used for the model were alpha = 0.1 and lambda = 0.04302463.

``` r
#### Make predictions ----
predictions <- predict(chest_disease_caret_model_glmnet, chest_disease_test[, 1:8])

#### Display the model's evaluation metrics ----
##### RMSE ----
rmse <- sqrt(mean((chest_disease_test$Outcome - predictions)^2))
print(paste("RMSE =", sprintf(rmse, fmt = "%#.4f")))
```

    ## [1] "RMSE = 0.4030"

``` r
##### SSR ----
# SSR is the sum of squared residuals (the sum of squared differences
# between observed and predicted values)
ssr <- sum((chest_disease_test$Outcome - predictions)^2)
print(paste("SSR =", sprintf(ssr, fmt = "%#.4f")))
```

    ## [1] "SSR = 37.3535"

``` r
##### SST ----
# SST is the total sum of squares (the sum of squared differences
# between observed values and their mean)
sst <- sum((chest_disease_test$Outcome - mean(chest_disease_test$Outcomel))^2)
print(paste("SST =", sprintf(sst, fmt = "%#.4f")))
```

    ## [1] "SST = NA"

``` r
##### R Squared ----
# We then use SSR and SST to compute the value of R squared.
# The closer the R squared value is to 1, the better the model.
r_squared <- 1 - (ssr / sst)
print(paste("R Squared =", sprintf(r_squared, fmt = "%#.4f")))
```

    ## [1] "R Squared = NA"

``` r
##### MAE ----
# MAE is expressed in the same units as the target variable, making it easy to
# interpret. For example, if you are predicting the amount paid in rent,
# and the MAE is KES. 10,000, it means, on average, your model's predictions
# are off by about KES. 10,000.
# Convert the factors to character for comparison
predictions_char <- as.character(predictions)
actual_outcome_char <- as.character(chest_disease$Outcome)

# Compare the predicted values with the actual values
correct_predictions <- sum(predictions_char == actual_outcome_char)
incorrect_predictions <- sum(predictions_char != actual_outcome_char)

cat("Correct predictions:", correct_predictions, "\n")
```

    ## Correct predictions: 0

``` r
cat("Incorrect predictions:", incorrect_predictions, "\n")
```

    ## Incorrect predictions: 768

``` r
mae <- mean(absolute_errors)
print(paste("MAE =", sprintf(mae, fmt = "%#.4f")))
```

    ## [1] "MAE = 0.3325"
