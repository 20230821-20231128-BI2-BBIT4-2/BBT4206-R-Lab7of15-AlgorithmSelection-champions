Business Intelligence Project
================
<Champions>
\<15/10/2023\>

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
    ##    -8.7742061      0.1525393      0.0377029     -0.0107230      0.0009724  
    ##       Insulin            BMI            DFP            Age  
    ##    -0.0012535      0.0793970      1.1934715      0.0145110  
    ## 
    ## Degrees of Freedom: 537 Total (i.e. Null);  529 Residual
    ## Null Deviance:       696.3 
    ## Residual Deviance: 488.9     AIC: 506.9

``` r
#### Make predictions ----
probabilities <- predict(chest_disease_model_glm, chest_disease_test[, 1:8],
                         type = "response")
print(probabilities)
```

    ##           1           2           3           4           5           6 
    ## 0.855174426 0.034416382 0.151395208 0.054344539 0.862073621 0.398418635 
    ##           7           8           9          10          11          12 
    ## 0.747529597 0.636258393 0.425495335 0.618764399 0.044331298 0.040459837 
    ##          13          14          15          16          17          18 
    ## 0.500023900 0.168634294 0.149425516 0.611187208 0.130149597 0.964401623 
    ##          19          20          21          22          23          24 
    ## 0.037591271 0.745521254 0.018543081 0.328859731 0.547074986 0.115369081 
    ##          25          26          27          28          29          30 
    ## 0.459164857 0.030323762 0.386989332 0.043909438 0.563929511 0.263532852 
    ##          31          32          33          34          35          36 
    ## 0.292502557 0.528710921 0.394264767 0.856388408 0.275522953 0.063750520 
    ##          37          38          39          40          41          42 
    ## 0.211562278 0.739827400 0.776959461 0.053006761 0.136939097 0.117194132 
    ##          43          44          45          46          47          48 
    ## 0.407893933 0.425069103 0.180661053 0.152268313 0.057169807 0.177440433 
    ##          49          50          51          52          53          54 
    ## 0.334436083 0.331641460 0.519403447 0.882675337 0.084768971 0.043203072 
    ##          55          56          57          58          59          60 
    ## 0.981905022 0.458181073 0.289680936 0.094428064 0.285220804 0.253730298 
    ##          61          62          63          64          65          66 
    ## 0.336445660 0.229923225 0.169847340 0.124764055 0.735993148 0.044655466 
    ##          67          68          69          70          71          72 
    ## 0.281837153 0.379277068 0.968211417 0.175529755 0.395040854 0.037877304 
    ##          73          74          75          76          77          78 
    ## 0.961753220 0.900202869 0.041926579 0.525771813 0.734213188 0.907759957 
    ##          79          80          81          82          83          84 
    ## 0.047363990 0.110728547 0.960064500 0.423590964 0.079725475 0.174749636 
    ##          85          86          87          88          89          90 
    ## 0.230730605 0.941070030 0.157830756 0.316388670 0.687226758 0.634034765 
    ##          91          92          93          94          95          96 
    ## 0.477927112 0.768645899 0.066432652 0.306861637 0.114288960 0.248826730 
    ##          97          98          99         100         101         102 
    ## 0.214796631 0.146874415 0.538434602 0.078422471 0.264090534 0.077802980 
    ##         103         104         105         106         107         108 
    ## 0.181187744 0.224951500 0.166402326 0.276990777 0.831254856 0.242886219 
    ##         109         110         111         112         113         114 
    ## 0.173196117 0.244287587 0.038741076 0.517854285 0.397376512 0.009630811 
    ##         115         116         117         118         119         120 
    ## 0.182574365 0.334874771 0.039925410 0.378056496 0.884843989 0.476908611 
    ##         121         122         123         124         125         126 
    ## 0.230691068 0.288126892 0.940058691 0.140767019 0.817073620 0.436282990 
    ##         127         128         129         130         131         132 
    ## 0.226624206 0.840366540 0.110479114 0.389823061 0.443497154 0.233356772 
    ##         133         134         135         136         137         138 
    ## 0.331654076 0.834115715 0.106785711 0.639642495 0.787664748 0.213406798 
    ##         139         140         141         142         143         144 
    ## 0.238843329 0.075917145 0.079240007 0.122840741 0.021657910 0.432581334 
    ##         145         146         147         148         149         150 
    ## 0.017898699 0.209659879 0.414544348 0.237858078 0.190161169 0.301905087 
    ##         151         152         153         154         155         156 
    ## 0.168865150 0.066451347 0.048883284 0.931164968 0.697735751 0.158478875 
    ##         157         158         159         160         161         162 
    ## 0.242586878 0.154750316 0.069808062 0.549674487 0.015724589 0.049360209 
    ##         163         164         165         166         167         168 
    ## 0.091997453 0.529733240 0.024217291 0.458170433 0.883572435 0.969397542 
    ##         169         170         171         172         173         174 
    ## 0.260240051 0.291151057 0.193214222 0.074498878 0.541359830 0.245165554 
    ##         175         176         177         178         179         180 
    ## 0.415786954 0.527785917 0.071270056 0.151264424 0.310413738 0.867053363 
    ##         181         182         183         184         185         186 
    ## 0.171398725 0.231731910 0.131212507 0.054520710 0.108691672 0.341753405 
    ##         187         188         189         190         191         192 
    ## 0.398304952 0.757244781 0.037077560 0.312083921 0.472139873 0.761045424 
    ##         193         194         195         196         197         198 
    ## 0.762645265 0.358914765 0.578768484 0.298172795 0.829117665 0.380277153 
    ##         199         200         201         202         203         204 
    ## 0.080776084 0.281001317 0.904402848 0.437806962 0.628018002 0.344385745 
    ##         205         206         207         208         209         210 
    ## 0.407175273 0.600870529 0.131470131 0.415625701 0.090017086 0.812564819 
    ##         211         212         213         214         215         216 
    ## 0.247723806 0.374774832 0.351727190 0.314857411 0.283925256 0.064122477 
    ##         217         218         219         220         221         222 
    ## 0.255688136 0.162651282 0.140317684 0.081775241 0.956260831 0.280024148 
    ##         223         224         225         226         227         228 
    ## 0.839337733 0.610972442 0.242951758 0.464337704 0.135834704 0.092820956 
    ##         229         230 
    ## 0.944965460 0.177757189

``` r
predictions <- ifelse(probabilities > 0.5, "Yes", "No")
print(predictions)
```

    ##     1     2     3     4     5     6     7     8     9    10    11    12    13 
    ## "Yes"  "No"  "No"  "No" "Yes"  "No" "Yes" "Yes"  "No" "Yes"  "No"  "No" "Yes" 
    ##    14    15    16    17    18    19    20    21    22    23    24    25    26 
    ##  "No"  "No" "Yes"  "No" "Yes"  "No" "Yes"  "No"  "No" "Yes"  "No"  "No"  "No" 
    ##    27    28    29    30    31    32    33    34    35    36    37    38    39 
    ##  "No"  "No" "Yes"  "No"  "No" "Yes"  "No" "Yes"  "No"  "No"  "No" "Yes" "Yes" 
    ##    40    41    42    43    44    45    46    47    48    49    50    51    52 
    ##  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes" "Yes" 
    ##    53    54    55    56    57    58    59    60    61    62    63    64    65 
    ##  "No"  "No" "Yes"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes" 
    ##    66    67    68    69    70    71    72    73    74    75    76    77    78 
    ##  "No"  "No"  "No" "Yes"  "No"  "No"  "No" "Yes" "Yes"  "No" "Yes" "Yes" "Yes" 
    ##    79    80    81    82    83    84    85    86    87    88    89    90    91 
    ##  "No"  "No" "Yes"  "No"  "No"  "No"  "No" "Yes"  "No"  "No" "Yes" "Yes"  "No" 
    ##    92    93    94    95    96    97    98    99   100   101   102   103   104 
    ## "Yes"  "No"  "No"  "No"  "No"  "No"  "No" "Yes"  "No"  "No"  "No"  "No"  "No" 
    ##   105   106   107   108   109   110   111   112   113   114   115   116   117 
    ##  "No"  "No" "Yes"  "No"  "No"  "No"  "No" "Yes"  "No"  "No"  "No"  "No"  "No" 
    ##   118   119   120   121   122   123   124   125   126   127   128   129   130 
    ##  "No" "Yes"  "No"  "No"  "No" "Yes"  "No" "Yes"  "No"  "No" "Yes"  "No"  "No" 
    ##   131   132   133   134   135   136   137   138   139   140   141   142   143 
    ##  "No"  "No"  "No" "Yes"  "No" "Yes" "Yes"  "No"  "No"  "No"  "No"  "No"  "No" 
    ##   144   145   146   147   148   149   150   151   152   153   154   155   156 
    ##  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes" "Yes"  "No" 
    ##   157   158   159   160   161   162   163   164   165   166   167   168   169 
    ##  "No"  "No"  "No" "Yes"  "No"  "No"  "No" "Yes"  "No"  "No" "Yes" "Yes"  "No" 
    ##   170   171   172   173   174   175   176   177   178   179   180   181   182 
    ##  "No"  "No"  "No" "Yes"  "No"  "No" "Yes"  "No"  "No"  "No" "Yes"  "No"  "No" 
    ##   183   184   185   186   187   188   189   190   191   192   193   194   195 
    ##  "No"  "No"  "No"  "No"  "No" "Yes"  "No"  "No"  "No" "Yes" "Yes"  "No" "Yes" 
    ##   196   197   198   199   200   201   202   203   204   205   206   207   208 
    ##  "No" "Yes"  "No"  "No"  "No" "Yes"  "No" "Yes"  "No"  "No" "Yes"  "No"  "No" 
    ##   209   210   211   212   213   214   215   216   217   218   219   220   221 
    ##  "No" "Yes"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" "Yes" 
    ##   222   223   224   225   226   227   228   229   230 
    ##  "No" "Yes" "Yes"  "No"  "No"  "No"  "No" "Yes"  "No"

``` r
#### Display the model's evaluation metrics ----
table(predictions, chest_disease_test$Outcome)
```

    ##            
    ## predictions   0   1
    ##         No  130  38
    ##         Yes  20  42

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
    ##   RMSE       Rsquared   MAE      
    ##   0.3997604  0.3029654  0.3288056

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
    ##          0 147   0
    ##          1   0  83
    ##                                      
    ##                Accuracy : 1          
    ##                  95% CI : (0.9841, 1)
    ##     No Information Rate : 0.6391     
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
    ##              Prevalence : 0.6391     
    ##          Detection Rate : 0.6391     
    ##    Detection Prevalence : 0.6391     
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
