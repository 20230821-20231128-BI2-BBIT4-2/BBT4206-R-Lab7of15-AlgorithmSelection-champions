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
- [Clustering](#clustering)
- [Association](#association)

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

# Understanding the Structure of Data

## Loading the Dataset

### Source:

The dataset that was used can be downloaded here:
<https://drive.google.com/drive/folders/1-BGEhfOwquXF6KKXwcvrx7WuZXuqmW9q?usp=sharing>

### Reference:

*  
Refer to the APA 7th edition manual for rules on how to cite datasets:
<https://apastyle.apa.org/style-grammar-guidelines/references/examples/data-set-references>*
\##### Linear Regression

##### Logistic Regression without caret

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
    ##    -8.1251083      0.1073176      0.0336533     -0.0133862     -0.0047009  
    ##       Insulin            BMI            DFP            Age  
    ##    -0.0008197      0.0912504      0.4608673      0.0208841  
    ## 
    ## Degrees of Freedom: 537 Total (i.e. Null);  529 Residual
    ## Null Deviance:       688.5 
    ## Residual Deviance: 513.9     AIC: 531.9

``` r
#### Make predictions ----
probabilities <- predict(chest_disease_model_glm, chest_disease_test[, 1:8],
                         type = "response")
print(probabilities)
```

    ##           1           2           3           4           5           6 
    ## 0.683590511 0.046902403 0.669677200 0.748070631 0.884555533 0.707311891 
    ##           7           8           9          10          11          12 
    ## 0.406199926 0.046473423 0.550243286 0.053731230 0.153432390 0.643683024 
    ##          13          14          15          16          17          18 
    ## 0.430861224 0.035553275 0.039221845 0.879735758 0.279143403 0.192896084 
    ##          19          20          21          22          23          24 
    ## 0.546505475 0.025728148 0.122792928 0.484946371 0.034491496 0.166593386 
    ##          25          26          27          28          29          30 
    ## 0.330801222 0.089455890 0.110813097 0.051445132 0.712306639 0.168553047 
    ##          31          32          33          34          35          36 
    ## 0.775178133 0.022722412 0.124448617 0.788349203 0.035087757 0.431511245 
    ##          37          38          39          40          41          42 
    ## 0.056554649 0.108525598 0.142997229 0.177445114 0.050943588 0.325155698 
    ##          43          44          45          46          47          48 
    ## 0.006045484 0.700033834 0.323895405 0.953690920 0.401280898 0.253717696 
    ##          49          50          51          52          53          54 
    ## 0.303669816 0.241609736 0.490578002 0.162880769 0.825870021 0.774478834 
    ##          55          56          57          58          59          60 
    ## 0.794971365 0.383437978 0.260319181 0.197142598 0.330635255 0.689084997 
    ##          61          62          63          64          65          66 
    ## 0.969901365 0.074573746 0.043378882 0.944662687 0.863769280 0.725153647 
    ##          67          68          69          70          71          72 
    ## 0.314105440 0.682726736 0.730765030 0.895151183 0.038383439 0.083702840 
    ##          73          74          75          76          77          78 
    ## 0.278611411 0.185217094 0.202499420 0.549482889 0.347211296 0.256467569 
    ##          79          80          81          82          83          84 
    ## 0.622472724 0.223809184 0.173296281 0.429295508 0.593012743 0.403981255 
    ##          85          86          87          88          89          90 
    ## 0.055120559 0.206672809 0.524147923 0.251260161 0.810853090 0.095138167 
    ##          91          92          93          94          95          96 
    ## 0.271277931 0.667819031 0.265355906 0.081495453 0.192748931 0.706601074 
    ##          97          98          99         100         101         102 
    ## 0.272080431 0.166032773 0.664201874 0.177804897 0.891169240 0.737381681 
    ##         103         104         105         106         107         108 
    ## 0.307516256 0.894884907 0.003935219 0.344157549 0.435023145 0.059082048 
    ##         109         110         111         112         113         114 
    ## 0.065371098 0.759888245 0.771187129 0.715453554 0.227873676 0.273237866 
    ##         115         116         117         118         119         120 
    ## 0.086592299 0.361599718 0.850111478 0.104631919 0.108145991 0.414722433 
    ##         121         122         123         124         125         126 
    ## 0.890835454 0.717611888 0.533029378 0.546548268 0.609046090 0.026017527 
    ##         127         128         129         130         131         132 
    ## 0.188857206 0.116815890 0.081290744 0.466973423 0.327873627 0.341501690 
    ##         133         134         135         136         137         138 
    ## 0.274738911 0.123801738 0.904908830 0.023330472 0.083015803 0.140393192 
    ##         139         140         141         142         143         144 
    ## 0.595625140 0.256741889 0.266694929 0.179511618 0.140948818 0.155655037 
    ##         145         146         147         148         149         150 
    ## 0.268072384 0.193217867 0.076367533 0.071053630 0.848853018 0.116709548 
    ##         151         152         153         154         155         156 
    ## 0.375971241 0.120447615 0.189814868 0.209777762 0.212106244 0.616442413 
    ##         157         158         159         160         161         162 
    ## 0.578779795 0.208326173 0.020350833 0.222755887 0.285247958 0.109474080 
    ##         163         164         165         166         167         168 
    ## 0.112709289 0.095638937 0.359615774 0.068805420 0.104347104 0.865816624 
    ##         169         170         171         172         173         174 
    ## 0.084061327 0.175244226 0.100084356 0.132754806 0.244150424 0.272079224 
    ##         175         176         177         178         179         180 
    ## 0.207413472 0.496680133 0.681939103 0.044645939 0.641147660 0.097899955 
    ##         181         182         183         184         185         186 
    ## 0.732199339 0.076414434 0.782610635 0.032953655 0.069876971 0.354879590 
    ##         187         188         189         190         191         192 
    ## 0.194822658 0.124666592 0.079302221 0.104566297 0.535153438 0.047879353 
    ##         193         194         195         196         197         198 
    ## 0.228703650 0.295142318 0.201674459 0.650634894 0.106063349 0.733940921 
    ##         199         200         201         202         203         204 
    ## 0.717899446 0.713837641 0.643647851 0.121484531 0.410323767 0.126299811 
    ##         205         206         207         208         209         210 
    ## 0.363189389 0.798491775 0.204845796 0.085224797 0.665637494 0.199848208 
    ##         211         212         213         214         215         216 
    ## 0.876364368 0.366511045 0.050673975 0.126073938 0.316450037 0.719157821 
    ##         217         218         219         220         221         222 
    ## 0.788643215 0.159688376 0.693909672 0.068283659 0.377584832 0.232400791 
    ##         223         224         225         226         227         228 
    ## 0.669450516 0.618763858 0.694648354 0.360965176 0.393577693 0.100987345 
    ##         229         230 
    ## 0.175083866 0.333672736

``` r
predictions <- ifelse(probabilities > 0.5, "Yes", "No")
print(predictions)
```

    ##     1     2     3     4     5     6     7     8     9    10    11    12    13 
    ## "Yes"  "No" "Yes" "Yes" "Yes" "Yes"  "No"  "No" "Yes"  "No"  "No" "Yes"  "No" 
    ##    14    15    16    17    18    19    20    21    22    23    24    25    26 
    ##  "No"  "No" "Yes"  "No"  "No" "Yes"  "No"  "No"  "No"  "No"  "No"  "No"  "No" 
    ##    27    28    29    30    31    32    33    34    35    36    37    38    39 
    ##  "No"  "No" "Yes"  "No" "Yes"  "No"  "No" "Yes"  "No"  "No"  "No"  "No"  "No" 
    ##    40    41    42    43    44    45    46    47    48    49    50    51    52 
    ##  "No"  "No"  "No"  "No" "Yes"  "No" "Yes"  "No"  "No"  "No"  "No"  "No"  "No" 
    ##    53    54    55    56    57    58    59    60    61    62    63    64    65 
    ## "Yes" "Yes" "Yes"  "No"  "No"  "No"  "No" "Yes" "Yes"  "No"  "No" "Yes" "Yes" 
    ##    66    67    68    69    70    71    72    73    74    75    76    77    78 
    ## "Yes"  "No" "Yes" "Yes" "Yes"  "No"  "No"  "No"  "No"  "No" "Yes"  "No"  "No" 
    ##    79    80    81    82    83    84    85    86    87    88    89    90    91 
    ## "Yes"  "No"  "No"  "No" "Yes"  "No"  "No"  "No" "Yes"  "No" "Yes"  "No"  "No" 
    ##    92    93    94    95    96    97    98    99   100   101   102   103   104 
    ## "Yes"  "No"  "No"  "No" "Yes"  "No"  "No" "Yes"  "No" "Yes" "Yes"  "No" "Yes" 
    ##   105   106   107   108   109   110   111   112   113   114   115   116   117 
    ##  "No"  "No"  "No"  "No"  "No" "Yes" "Yes" "Yes"  "No"  "No"  "No"  "No" "Yes" 
    ##   118   119   120   121   122   123   124   125   126   127   128   129   130 
    ##  "No"  "No"  "No" "Yes" "Yes" "Yes" "Yes" "Yes"  "No"  "No"  "No"  "No"  "No" 
    ##   131   132   133   134   135   136   137   138   139   140   141   142   143 
    ##  "No"  "No"  "No"  "No" "Yes"  "No"  "No"  "No" "Yes"  "No"  "No"  "No"  "No" 
    ##   144   145   146   147   148   149   150   151   152   153   154   155   156 
    ##  "No"  "No"  "No"  "No"  "No" "Yes"  "No"  "No"  "No"  "No"  "No"  "No" "Yes" 
    ##   157   158   159   160   161   162   163   164   165   166   167   168   169 
    ## "Yes"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes"  "No" 
    ##   170   171   172   173   174   175   176   177   178   179   180   181   182 
    ##  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes"  "No" "Yes"  "No" "Yes"  "No" 
    ##   183   184   185   186   187   188   189   190   191   192   193   194   195 
    ## "Yes"  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes"  "No"  "No"  "No"  "No" 
    ##   196   197   198   199   200   201   202   203   204   205   206   207   208 
    ## "Yes"  "No" "Yes" "Yes" "Yes" "Yes"  "No"  "No"  "No"  "No" "Yes"  "No"  "No" 
    ##   209   210   211   212   213   214   215   216   217   218   219   220   221 
    ## "Yes"  "No" "Yes"  "No"  "No"  "No"  "No" "Yes" "Yes"  "No" "Yes"  "No"  "No" 
    ##   222   223   224   225   226   227   228   229   230 
    ##  "No" "Yes" "Yes" "Yes"  "No"  "No"  "No"  "No"  "No"

``` r
#### Display the model's evaluation metrics ----
table(predictions, chest_disease_test$Outcome)
```

    ##            
    ## predictions   0   1
    ##         No  125  35
    ##         Yes  19  51

``` r
# Read the following article on how to compute various evaluation metrics using
# the confusion matrix:
# https://en.wikipedia.org/wiki/Confusion_matrix
```

##### Logistic Regression with caret

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
    ##   RMSE      Rsquared   MAE      
    ##   0.402058  0.2981502  0.3366076

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
    ##          0 151   0
    ##          1   0  79
    ##                                      
    ##                Accuracy : 1          
    ##                  95% CI : (0.9841, 1)
    ##     No Information Rate : 0.6565     
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
    ##              Prevalence : 0.6565     
    ##          Detection Rate : 0.6565     
    ##    Detection Prevalence : 0.6565     
    ##       Balanced Accuracy : 1.0000     
    ##                                      
    ##        'Positive' Class : 0          
    ## 

``` r
fourfoldplot(as.table(confusion_matrix), color = c("grey", "lightblue"),
             main = "Confusion Matrix")
```

![](Lab_7_Submission_files/figure-gfm/Carry%20out%20Logistic%20Regression%20with%20caret-1.png)<!-- -->

# Clustering

# Association
