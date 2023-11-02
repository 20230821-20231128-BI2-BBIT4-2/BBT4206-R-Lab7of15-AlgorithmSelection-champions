Business Intelligence Project
================
Team Champions
\| Date:30/10/2023

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
  - [Reference:](#reference)
- [Clustering](#clustering)

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

### Reference:

Refer to the APA 7th edition manual for rules on how to cite datasets:
<https://apastyle.apa.org/style-grammar-guidelines/references/examples/data-set-references>\*

# Clustering

##### STEP 1. Install and Load the Required Packages —-

``` r
## readr ----
if (require("readr")) {
  require("readr")
} else {
  install.packages("readr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: readr

``` r
## naniar ----
if (require("naniar")) {
  require("naniar")
} else {
  install.packages("naniar", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: naniar

``` r
## ggplot2 ----
if (require("ggplot2")) {
  require("ggplot2")
} else {
  install.packages("ggplot2", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: ggplot2

``` r
## corrplot ----
if (require("corrplot")) {
  require("corrplot")
} else {
  install.packages("corrplot", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: corrplot

    ## corrplot 0.92 loaded

``` r
## ggcorrplot ----
if (require("ggcorrplot")) {
  require("ggcorrplot")
} else {
  install.packages("ggcorrplot", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: ggcorrplot

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

    ## Loading required package: lattice

``` r
## dplyr ----
if (require("dplyr")) {
  require("dplyr")
} else {
  install.packages("dplyr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: dplyr

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

##### STEP 2. Load the Dataset —-

``` r
library(readr)
train <- read_csv("../data/train.csv")
```

    ## Rows: 8068 Columns: 11
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (7): Gender, Ever_Married, Graduated, Profession, Spending_Score, Var_1,...
    ## dbl (4): ID, Age, Work_Experience, Family_Size
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(train)

train <-
  read_csv("../data/train.csv",
           col_types =
             cols(ID = col_double(),
                  Gender = col_character(),
                  Ever_Married = col_character(),
                  Age = col_double(),
                  Graduated = col_character(),
                  Profession = col_character(),
                  Work_Experience = col_double(),
                  Family_Size = col_double(),
                  Spending_Score = col_character(),
                  Var_1 = col_character(),
                  Segmentation = col_character()))


train$Profession <- factor(train$Profession)

str(train)
```

    ## spc_tbl_ [8,068 × 11] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ID             : num [1:8068] 462809 462643 466315 461735 462669 ...
    ##  $ Gender         : chr [1:8068] "Male" "Female" "Female" "Male" ...
    ##  $ Ever_Married   : chr [1:8068] "No" "Yes" "Yes" "Yes" ...
    ##  $ Age            : num [1:8068] 22 38 67 67 40 56 32 33 61 55 ...
    ##  $ Graduated      : chr [1:8068] "No" "Yes" "Yes" "Yes" ...
    ##  $ Profession     : Factor w/ 9 levels "Artist","Doctor",..: 6 3 3 8 4 1 6 6 3 1 ...
    ##  $ Work_Experience: num [1:8068] 1 NA 1 0 NA 0 1 1 0 1 ...
    ##  $ Spending_Score : chr [1:8068] "Low" "Average" "Low" "High" ...
    ##  $ Family_Size    : num [1:8068] 4 3 1 2 6 2 3 3 3 4 ...
    ##  $ Var_1          : chr [1:8068] "Cat_4" "Cat_4" "Cat_6" "Cat_6" ...
    ##  $ Segmentation   : chr [1:8068] "D" "A" "B" "B" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ID = col_double(),
    ##   ..   Gender = col_character(),
    ##   ..   Ever_Married = col_character(),
    ##   ..   Age = col_double(),
    ##   ..   Graduated = col_character(),
    ##   ..   Profession = col_character(),
    ##   ..   Work_Experience = col_double(),
    ##   ..   Spending_Score = col_character(),
    ##   ..   Family_Size = col_double(),
    ##   ..   Var_1 = col_character(),
    ##   ..   Segmentation = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

``` r
dim(train)
```

    ## [1] 8068   11

``` r
head(train)
```

    ## # A tibble: 6 × 11
    ##       ID Gender Ever_Married   Age Graduated Profession    Work_Experience
    ##    <dbl> <chr>  <chr>        <dbl> <chr>     <fct>                   <dbl>
    ## 1 462809 Male   No              22 No        Healthcare                  1
    ## 2 462643 Female Yes             38 Yes       Engineer                   NA
    ## 3 466315 Female Yes             67 Yes       Engineer                    1
    ## 4 461735 Male   Yes             67 Yes       Lawyer                      0
    ## 5 462669 Female Yes             40 Yes       Entertainment              NA
    ## 6 461319 Male   Yes             56 No        Artist                      0
    ## # ℹ 4 more variables: Spending_Score <chr>, Family_Size <dbl>, Var_1 <chr>,
    ## #   Segmentation <chr>

``` r
summary(train)
```

    ##        ID            Gender          Ever_Married            Age       
    ##  Min.   :458982   Length:8068        Length:8068        Min.   :18.00  
    ##  1st Qu.:461241   Class :character   Class :character   1st Qu.:30.00  
    ##  Median :463473   Mode  :character   Mode  :character   Median :40.00  
    ##  Mean   :463479                                         Mean   :43.47  
    ##  3rd Qu.:465744                                         3rd Qu.:53.00  
    ##  Max.   :467974                                         Max.   :89.00  
    ##                                                                        
    ##   Graduated                 Profession   Work_Experience  Spending_Score    
    ##  Length:8068        Artist       :2516   Min.   : 0.000   Length:8068       
    ##  Class :character   Healthcare   :1332   1st Qu.: 0.000   Class :character  
    ##  Mode  :character   Entertainment: 949   Median : 1.000   Mode  :character  
    ##                     Engineer     : 699   Mean   : 2.642                     
    ##                     Doctor       : 688   3rd Qu.: 4.000                     
    ##                     (Other)      :1760   Max.   :14.000                     
    ##                     NA's         : 124   NA's   :829                        
    ##   Family_Size      Var_1           Segmentation      
    ##  Min.   :1.00   Length:8068        Length:8068       
    ##  1st Qu.:2.00   Class :character   Class :character  
    ##  Median :3.00   Mode  :character   Mode  :character  
    ##  Mean   :2.85                                        
    ##  3rd Qu.:4.00                                        
    ##  Max.   :9.00                                        
    ##  NA's   :335

##### STEP 3. Check for Missing Data and Address it —-

``` r
# Are there missing values in the dataset?
any_na(train)
```

    ## [1] TRUE

``` r
# How many?
n_miss(train)
```

    ## [1] 1582

``` r
# What is the proportion of missing data in the entire dataset?
prop_miss(train)
```

    ## [1] 0.01782575

``` r
# What is the number and percentage of missing values grouped by
# each variable?
miss_var_summary(train)
```

    ## # A tibble: 11 × 3
    ##    variable        n_miss pct_miss
    ##    <chr>            <int>    <dbl>
    ##  1 Work_Experience    829   10.3  
    ##  2 Family_Size        335    4.15 
    ##  3 Ever_Married       140    1.74 
    ##  4 Profession         124    1.54 
    ##  5 Graduated           78    0.967
    ##  6 Var_1               76    0.942
    ##  7 ID                   0    0    
    ##  8 Gender               0    0    
    ##  9 Age                  0    0    
    ## 10 Spending_Score       0    0    
    ## 11 Segmentation         0    0

``` r
# Which variables contain the most missing values?
gg_miss_var(train)
```

![](Lab_7B_Submission_files/figure-gfm/Your%20third%20Code%20Chunk-1.png)<!-- -->

``` r
# Which combinations of variables are missing together?
gg_miss_upset(train)
```

![](Lab_7B_Submission_files/figure-gfm/Your%20third%20Code%20Chunk-2.png)<!-- -->

``` r
# Where are missing values located (the shaded regions in the plot)?
vis_miss(train) +
  theme(axis.text.x = element_text(angle = 80))
```

![](Lab_7B_Submission_files/figure-gfm/Your%20third%20Code%20Chunk-3.png)<!-- -->

``` r
## OPTION 1: Remove the observations with missing values ----
# We can decide to remove all the observations that have missing values
# as follows:
train_removed_obs <- train %>% filter(complete.cases(.))

train_removed_obs <-
  train %>%
  dplyr::filter(complete.cases(.))

# The initial dataset had 8068 observations and 11 variables
dim(train)
```

    ## [1] 8068   11

``` r
# The filtered dataset has 6665 observations and 11 variables
dim(train_removed_obs)
```

    ## [1] 6665   11

``` r
# Are there missing values in the dataset?
any_na(train_removed_obs)
```

    ## [1] FALSE

``` r
## OPTION 2: Remove the variables with missing values ----
# Alternatively, we can decide to remove the 2 variables that have missing data
train_removed_vars <-
  train %>%
  dplyr::select(-Work_Experience, -Family_Size)

# The initial dataset had 8068 observations and 11 variables
dim(train)
```

    ## [1] 8068   11

``` r
# The filtered dataset has 8068 observations and 11 variables
dim(train_removed_vars)
```

    ## [1] 8068    9

``` r
# Are there missing values in the dataset?
any_na(train_removed_vars)
```

    ## [1] TRUE

``` r
## OPTION 3: Perform Data Imputation ----

# CAUTION:
# 1. Avoid Over-imputation:
# Be cautious when imputing dates, especially if it is
# Missing Not at Random (MNAR).
# Over-Imputing can introduce bias into your analysis. For example, if dates
# are missing because of a specific event or condition, imputing dates might
# not accurately represent the data.

# 2. Consider the Business Context:
# Dates often have a significant business or domain context. Imputing dates
# may not always be appropriate, as it might distort the interpretation of
# your data. For example, imputing order dates could lead to incorrect insights
# into seasonality trends.
```

##### STEP 4. Perform EDA and Feature Selection —-

Compute the correlations between variables —- We identify the correlated
variables because it is these correlated variables that can then be used
to identify the clusters.

``` r
# Create a correlation matrix
# Option 1: Basic Table
cor(train_removed_obs[, c(1, 4, 7, 9)]) %>%
  View()

# Option 2: Basic Plot
cor(train_removed_obs[, c(1, 4, 7, 9)]) %>%
  corrplot(method = "square")
```

![](Lab_7B_Submission_files/figure-gfm/Your%20fourth%20Code%20Chunk-1.png)<!-- -->

``` r
# Option 3: Fancy Plot using ggplot2
corr_matrix <- cor(train_removed_obs[, c(1, 4, 7, 9)])

p <- ggplot2::ggplot(data = reshape2::melt(corr_matrix),
                     ggplot2::aes(Var1, Var2, fill = value)) +
  ggplot2::geom_tile() +
  ggplot2::geom_text(ggplot2::aes(label = label_wrap(label, width = 10)),
                     size = 4) +
  ggplot2::theme_minimal() +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))

ggcorrplot(corr_matrix, hc.order = TRUE, type = "lower", lab = TRUE)
```

![](Lab_7B_Submission_files/figure-gfm/Your%20fourth%20Code%20Chunk-2.png)<!-- -->

``` r
## Plot the scatter plots ----
# A scatter plot to show a person's Work Experience against Variable
ggplot(train_removed_obs,
       aes(Work_Experience, Var_1,
           color = Age,
           shape = Spending_Score)) +
  geom_point(alpha = 0.5) +
  xlab("Work Experience") +
  ylab("Variable")
```

![](Lab_7B_Submission_files/figure-gfm/Your%20fourth%20Code%20Chunk-3.png)<!-- -->

``` r
# A scatter plot to show Spending Score against Segmentation
ggplot(train_removed_obs,
       aes(Spending_Score, Segmentation,
           color = Graduated, shape = Segmentation)) +
  geom_point(alpha = 0.5) +
  xlab("Spending Score") +
  ylab("Segmentation")
```

![](Lab_7B_Submission_files/figure-gfm/Your%20fourth%20Code%20Chunk-4.png)<!-- -->

``` r
## Transform the data ----
# The K Means Clustering algorithm performs better when data transformation has
# been applied. This helps to standardize the data making it easier to compare
# multiple variables.

summary(train_removed_obs)
```

    ##        ID            Gender          Ever_Married            Age       
    ##  Min.   :458982   Length:6665        Length:6665        Min.   :18.00  
    ##  1st Qu.:461349   Class :character   Class :character   1st Qu.:31.00  
    ##  Median :463575   Mode  :character   Mode  :character   Median :41.00  
    ##  Mean   :463520                                         Mean   :43.54  
    ##  3rd Qu.:465741                                         3rd Qu.:53.00  
    ##  Max.   :467974                                         Max.   :89.00  
    ##                                                                        
    ##   Graduated                 Profession   Work_Experience  Spending_Score    
    ##  Length:6665        Artist       :2192   Min.   : 0.000   Length:6665       
    ##  Class :character   Healthcare   :1077   1st Qu.: 0.000   Class :character  
    ##  Mode  :character   Entertainment: 809   Median : 1.000   Mode  :character  
    ##                     Doctor       : 592   Mean   : 2.629                     
    ##                     Engineer     : 582   3rd Qu.: 4.000                     
    ##                     Executive    : 505   Max.   :14.000                     
    ##                     (Other)      : 908                                      
    ##   Family_Size       Var_1           Segmentation      
    ##  Min.   :1.000   Length:6665        Length:6665       
    ##  1st Qu.:2.000   Class :character   Class :character  
    ##  Median :2.000   Mode  :character   Mode  :character  
    ##  Mean   :2.841                                        
    ##  3rd Qu.:4.000                                        
    ##  Max.   :9.000                                        
    ## 

``` r
model_of_the_transform <- preProcess(train_removed_obs, method = c("scale", "center"))
print(model_of_the_transform)
```

    ## Created from 6665 samples and 11 variables
    ## 
    ## Pre-processing:
    ##   - centered (4)
    ##   - ignored (7)
    ##   - scaled (4)

``` r
train_removed_obs_std <- predict(model_of_the_transform, train_removed_obs)
summary(train_removed_obs_std)  # Use 'train_removed_obs_std' here, not 'train_obs_std'
```

    ##        ID              Gender          Ever_Married            Age         
    ##  Min.   :-1.76815   Length:6665        Length:6665        Min.   :-1.5454  
    ##  1st Qu.:-0.84586   Class :character   Class :character   1st Qu.:-0.7587  
    ##  Median : 0.02149   Mode  :character   Mode  :character   Median :-0.1535  
    ##  Mean   : 0.00000                                         Mean   : 0.0000  
    ##  3rd Qu.: 0.86547                                         3rd Qu.: 0.5727  
    ##  Max.   : 1.73555                                         Max.   : 2.7514  
    ##                                                                            
    ##   Graduated                 Profession   Work_Experience   Spending_Score    
    ##  Length:6665        Artist       :2192   Min.   :-0.7720   Length:6665       
    ##  Class :character   Healthcare   :1077   1st Qu.:-0.7720   Class :character  
    ##  Mode  :character   Entertainment: 809   Median :-0.4784   Mode  :character  
    ##                     Doctor       : 592   Mean   : 0.0000                     
    ##                     Engineer     : 582   3rd Qu.: 0.4026                     
    ##                     Executive    : 505   Max.   : 3.3391                     
    ##                     (Other)      : 908                                       
    ##   Family_Size         Var_1           Segmentation      
    ##  Min.   :-1.2075   Length:6665        Length:6665       
    ##  1st Qu.:-0.5516   Class :character   Class :character  
    ##  Median :-0.5516   Mode  :character   Mode  :character  
    ##  Mean   : 0.0000                                        
    ##  3rd Qu.: 0.7601                                        
    ##  Max.   : 4.0393                                        
    ## 

``` r
sapply(train_removed_obs_std[, c(1, 4, 7, 9)], sd)
```

    ##              ID             Age Work_Experience     Family_Size 
    ##               1               1               1               1

``` r
## Select the features to use to create the clusters ----
# OPTION 1: Use all the numeric variables to create the clusters
train_vars <- train_removed_obs_std[, c(1, 4, 7, 9)]

train_vars <-
  train_removed_obs_std[, c("Age",
                            "Work_Experience")]
```

##### STEP 5. Create the clusters using the K-Means Clustering Algorithm —-

``` r
# We start with a random guess of the number of clusters we need
set.seed(7)
kmeans_cluster <- kmeans(train_vars, centers = 3, nstart = 20)

# We then decide the maximum number of clusters to investigate
n_clusters <- 8

# Initialize total within sum of squares error: wss
wss <- numeric(n_clusters)

set.seed(7)

# Investigate 1 to n possible clusters (where n is the maximum number of 
# clusters that we want to investigate)
for (i in 1:n_clusters) {
  # Use the K Means cluster algorithm to create each cluster
  kmeans_cluster <- kmeans(train_vars, centers = i, nstart = 20)
  # Save the within cluster sum of squares
  wss[i] <- kmeans_cluster$tot.withinss
}

## Plot a scree plot ----
# The scree plot should help you to note when additional clusters do not make
# any significant difference (the plateau).
wss_df <- tibble(clusters = 1:n_clusters, wss = wss)

scree_plot <- ggplot(wss_df, aes(x = clusters, y = wss, group = 1)) +
  geom_point(size = 4) +
  geom_line() +
  scale_x_continuous(breaks = c(2, 4, 6, 8)) +
  xlab("Number of Clusters")


# OPTION 2: Use only the most significant variables to create the clusters
# This can be informed by feature selection, or by the business case.

scree_plot
```

![](Lab_7B_Submission_files/figure-gfm/Your%20fifth%20Code%20Chunk-1.png)<!-- -->

``` r
# We can add guides to make it easier to identify the plateau (or "elbow").
scree_plot +
  geom_hline(
    yintercept = wss,
    linetype = "dashed",
    col = c(rep("#000000", 5), "#FF0000", rep("#000000", 2))
  )
```

![](Lab_7B_Submission_files/figure-gfm/Your%20fifth%20Code%20Chunk-2.png)<!-- -->

``` r
# The plateau is reached at 8 clusters.
# We therefore create the final cluster with 8 clusters
# (not the initial 3 used at the beginning of this STEP.)
k <- 6
set.seed(7)
# Build model with k clusters: kmeans_cluster
kmeans_cluster <- kmeans(train_vars, centers = k, nstart = 20)
```

##### STEP 6. Add the cluster number as a label for each observation —-

``` r
train_removed_obs$cluster_id <- factor(kmeans_cluster$cluster)

## View the results by plotting scatter plots with the labelled cluster ----
ggplot(train_removed_obs, aes(Work_Experience, Var_1,
                              color = cluster_id)) +
  geom_point(alpha = 0.5) +
  xlab("How long a person has worked") +
  ylab("Type of variable")
```

![](Lab_7B_Submission_files/figure-gfm/Your%20sixth%20Code%20Chunk-1.png)<!-- -->

``` r
ggplot(train_removed_obs,
       aes(Spending_Score, Segmentation, color = cluster_id)) +
  geom_point(alpha = 0.5) +
  xlab("Total Spending Amount") +
  ylab("Characteristic of Each Segment")
```

![](Lab_7B_Submission_files/figure-gfm/Your%20sixth%20Code%20Chunk-2.png)<!-- -->

Note on Clustering for both Descriptive and Predictive Data Analytics —-
Clustering can be used for both descriptive and predictive analytics. It
is more commonly used around Exploratory Data Analysis which is
descriptive analytics.

The results of clustering, i.e., a label of the cluster can be fed as
input to a supervised learning algorithm. The trained model can then be
used to predict the cluster that a new observation will belong to.
