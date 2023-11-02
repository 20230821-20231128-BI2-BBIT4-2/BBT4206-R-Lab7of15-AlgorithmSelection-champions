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
- [Association](#association)
- [STEP 1. Install and Load the Required Packages —-
  association](#step-1-install-and-load-the-required-packages---association)
- [STEP 2. Load and pre-process the
  dataset](#step-2-load-and-pre-process-the-dataset)
  - [Create a transaction data frame using the “basket
    format”](#create-a-transaction-data-frame-using-the-basket-format)
  - [Read the transactions fromm the CSV
    file](#read-the-transactions-fromm-the-csv-file)
  - [Basic EDA](#basic-eda)
- [STEP 3. Create the association
  rules](#step-3-create-the-association-rules)
  - [Print the association rules](#print-the-association-rules)
    - [To view the top 10 rules](#to-view-the-top-10-rules)
  - [Remove redundant rules](#remove-redundant-rules)
- [STEP 4. Find specific rules](#step-4-find-specific-rules)
- [STEP 5. Visualize the rules](#step-5-visualize-the-rules)
  - [Filter top 20 rules with highest
    lift](#filter-top-20-rules-with-highest-lift)

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
<https://www.kaggle.com/datasets/heeraldedhia/groceries-dataset>

### Reference:

*  
Refer to the APA 7th edition manual for rules on how to cite datasets:
<https://apastyle.apa.org/style-grammar-guidelines/references/examples/data-set-references>*

# Association

# STEP 1. Install and Load the Required Packages —- association

``` r
## arules ----
if (require("arules")) {
  require("arules")
} else {
  install.packages("arules", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: arules

    ## 
    ## Attaching package: 'arules'

    ## The following object is masked from 'package:kernlab':
    ## 
    ##     size

    ## The following objects are masked from 'package:base':
    ## 
    ##     abbreviate, write

``` r
## arulesViz ----
if (require("arulesViz")) {
  require("arulesViz")
} else {
  install.packages("arulesViz", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: arulesViz

``` r
## tidyverse ----
if (require("tidyverse")) {
  require("tidyverse")
} else {
  install.packages("tidyverse", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: tidyverse

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.3     ✔ readr     2.1.4
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.0
    ## ✔ lubridate 1.9.3     ✔ tibble    3.2.1
    ## ✔ purrr     1.0.2     ✔ tidyr     1.3.0
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ kernlab::alpha() masks ggplot2::alpha()
    ## ✖ purrr::cross()   masks kernlab::cross()
    ## ✖ tidyr::expand()  masks Matrix::expand()
    ## ✖ dplyr::filter()  masks stats::filter()
    ## ✖ dplyr::lag()     masks stats::lag()
    ## ✖ purrr::lift()    masks caret::lift()
    ## ✖ tidyr::pack()    masks Matrix::pack()
    ## ✖ dplyr::recode()  masks arules::recode()
    ## ✖ dplyr::select()  masks MASS::select()
    ## ✖ tidyr::unpack()  masks Matrix::unpack()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
## readxl ----
if (require("readxl")) {
  require("readxl")
} else {
  install.packages("readxl", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: readxl

``` r
## knitr ----
if (require("knitr")) {
  require("knitr")
} else {
  install.packages("knitr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: knitr

``` r
## ggplot2 ----
if (require("ggplot2")) {
  require("ggplot2")
} else {
  install.packages("ggplot2", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## lubridate ----
if (require("lubridate")) {
  require("lubridate")
} else {
  install.packages("lubridate", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## plyr ----
if (require("plyr")) {
  require("plyr")
} else {
  install.packages("plyr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: plyr
    ## ------------------------------------------------------------------------------
    ## You have loaded plyr after dplyr - this is likely to cause problems.
    ## If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
    ## library(plyr); library(dplyr)
    ## ------------------------------------------------------------------------------
    ## 
    ## Attaching package: 'plyr'
    ## 
    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     arrange, count, desc, failwith, id, mutate, rename, summarise,
    ##     summarize
    ## 
    ## The following object is masked from 'package:purrr':
    ## 
    ##     compact

``` r
## dplyr ----
if (require("dplyr")) {
  require("dplyr")
} else {
  install.packages("dplyr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

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
## RColorBrewer ----
if (require("RColorBrewer")) {
  require("RColorBrewer")
} else {
  install.packages("RColorBrewer", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: RColorBrewer

# STEP 2. Load and pre-process the dataset

``` r
library(readr)
Groceries_dataset <- read_csv("../data/Groceries_dataset.csv")
```

    ## Rows: 38765 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (2): Date, itemDescription
    ## dbl (1): Member_number
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
dim(Groceries_dataset)
```

    ## [1] 38765     3

``` r
### Handle missing values ----
# Are there missing values in the dataset?
any_na(Groceries_dataset)
```

    ## [1] FALSE

``` r
## Identify categorical variables ----
str(Groceries_dataset)
```

    ## spc_tbl_ [38,765 × 3] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ Member_number  : num [1:38765] 1808 2552 2300 1187 3037 ...
    ##  $ Date           : chr [1:38765] "21-07-2015" "05-01-2015" "19-09-2015" "12-12-2015" ...
    ##  $ itemDescription: chr [1:38765] "tropical fruit" "whole milk" "pip fruit" "other vegetables" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   Member_number = col_double(),
    ##   ..   Date = col_character(),
    ##   ..   itemDescription = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

``` r
head(Groceries_dataset)
```

    ## # A tibble: 6 × 3
    ##   Member_number Date       itemDescription 
    ##           <dbl> <chr>      <chr>           
    ## 1          1808 21-07-2015 tropical fruit  
    ## 2          2552 05-01-2015 whole milk      
    ## 3          2300 19-09-2015 pip fruit       
    ## 4          1187 12-12-2015 other vegetables
    ## 5          3037 01-02-2015 whole milk      
    ## 6          4941 14-02-2015 rolls/buns

``` r
# We can separate the date and the time into 2 different variables.
Groceries_dataset <-
  Groceries_dataset %>%
  mutate_all(~str_replace_all(., ",", " "))

## check the column types
str(Groceries_dataset)
```

    ## tibble [38,765 × 3] (S3: tbl_df/tbl/data.frame)
    ##  $ Member_number  : chr [1:38765] "1808" "2552" "2300" "1187" ...
    ##  $ Date           : chr [1:38765] "21-07-2015" "05-01-2015" "19-09-2015" "12-12-2015" ...
    ##  $ itemDescription: chr [1:38765] "tropical fruit" "whole milk" "pip fruit" "other vegetables" ...

## Create a transaction data frame using the “basket format”

``` r
# ddply is used to split a data frame, apply a function to the split data,
# and then return the result back in a data frame.
grocerie_data <-
  plyr::ddply(Groceries_dataset,
              c("Member_number", "Date"),
              function(df1) {
                paste(df1$itemDescription, collapse = ",")
              }
  )
View(grocerie_data)

## Record only the `items` variable 
grocerie_data <-
  grocerie_data %>%
  dplyr::select("items" = V1)
View(grocerie_data)

## Save the transactions in CSV format 
write.csv(grocerie_data,
          "../data/grocerie_basket_format.csv",
          quote = FALSE, row.names = FALSE)
```

## Read the transactions fromm the CSV file

``` r
# We can now, finally, read the basket format transaction data as a
# transaction object.
tr_grocery <-
  read.transactions("../data/grocerie_basket_format.csv",
                    format = "basket",
                    header = TRUE,
                    rm.duplicates = TRUE,
                    sep = ","
  )
```

    ## distribution of transactions with duplicates:
    ## items
    ##   1   2   3   4 
    ## 662  39   5   1

``` r
# This shows there are 14963 transactions that have been identified
# and 167 items
print(tr_grocery)
```

    ## transactions in sparse format with
    ##  14963 transactions (rows) and
    ##  167 items (columns)

``` r
summary(tr_grocery)
```

    ## transactions as itemMatrix in sparse format with
    ##  14963 rows (elements/itemsets/transactions) and
    ##  167 columns (items) and a density of 0.01520957 
    ## 
    ## most frequent items:
    ##       whole milk other vegetables       rolls/buns             soda 
    ##             2363             1827             1646             1453 
    ##           yogurt          (Other) 
    ##             1285            29432 
    ## 
    ## element (itemset/transaction) length distribution:
    ## sizes
    ##     1     2     3     4     5     6     7     8     9    10 
    ##   205 10012  2727  1273   338   179   113    96    19     1 
    ## 
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    1.00    2.00    2.00    2.54    3.00   10.00 
    ## 
    ## includes extended item information - examples:
    ##             labels
    ## 1 abrasive cleaner
    ## 2 artif. sweetener
    ## 3   baby cosmetics

## Basic EDA

``` r
# Create an item frequency plot for the top 10 items
```

# STEP 3. Create the association rules

``` r
# The default action is to create rules with a minimum support of 0.1
# and a minimum confidence of 0.8. These parameters can be adjusted (lowered)
# if the algorithm does not lead to the creation of any rules.
# We also set maxlen = 10 which refers to the maximum number of items per
# item set.
association_rules <- apriori(tr_grocery,
                             parameter = list(support = 0.0001,
                                              confidence = 0.8,
                                              maxlen = 10))
```

    ## Apriori
    ## 
    ## Parameter specification:
    ##  confidence minval smax arem  aval originalSupport maxtime support minlen
    ##         0.8    0.1    1 none FALSE            TRUE       5   1e-04      1
    ##  maxlen target  ext
    ##      10  rules TRUE
    ## 
    ## Algorithmic control:
    ##  filter tree heap memopt load sort verbose
    ##     0.1 TRUE TRUE  FALSE TRUE    2    TRUE
    ## 
    ## Absolute minimum support count: 1 
    ## 
    ## set item appearances ...[0 item(s)] done [0.00s].
    ## set transactions ...[167 item(s), 14963 transaction(s)] done [0.01s].
    ## sorting and recoding items ... [165 item(s)] done [0.00s].
    ## creating transaction tree ... done [0.01s].
    ## checking subsets of size 1 2 3 4 5 done [0.01s].
    ## writing ... [647 rule(s)] done [0.00s].
    ## creating S4 object  ... done [0.00s].

## Print the association rules

Threshold values of support = 0.0001, confidence = 0.8, and maxlen = 10
results in a total of 647 rules when using the item name to identify the
products.

``` r
summary(association_rules)
```

    ## set of 647 rules
    ## 
    ## rule length distribution (lhs + rhs):sizes
    ##   3   4   5 
    ## 135 438  74 
    ## 
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   3.000   4.000   4.000   3.906   4.000   5.000 
    ## 
    ## summary of quality measures:
    ##     support            confidence        coverage              lift        
    ##  Min.   :0.0001337   Min.   :0.8000   Min.   :0.0001337   Min.   :  5.066  
    ##  1st Qu.:0.0001337   1st Qu.:1.0000   1st Qu.:0.0001337   1st Qu.:  8.190  
    ##  Median :0.0001337   Median :1.0000   Median :0.0001337   Median : 11.644  
    ##  Mean   :0.0001373   Mean   :0.9988   Mean   :0.0001377   Mean   : 19.285  
    ##  3rd Qu.:0.0001337   3rd Qu.:1.0000   3rd Qu.:0.0001337   3rd Qu.: 20.386  
    ##  Max.   :0.0003342   Max.   :1.0000   Max.   :0.0004010   Max.   :364.951  
    ##      count      
    ##  Min.   :2.000  
    ##  1st Qu.:2.000  
    ##  Median :2.000  
    ##  Mean   :2.054  
    ##  3rd Qu.:2.000  
    ##  Max.   :5.000  
    ## 
    ## mining info:
    ##        data ntransactions support confidence
    ##  tr_grocery         14963   1e-04        0.8
    ##                                                                                          call
    ##  apriori(data = tr_grocery, parameter = list(support = 1e-04, confidence = 0.8, maxlen = 10))

``` r
inspect(association_rules)
```

    ##       lhs                            rhs                             support confidence     coverage       lift count
    ## [1]   {domestic eggs,                                                                                                
    ##        rubbing alcohol}           => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [2]   {frankfurter,                                                                                                  
    ##        rubbing alcohol}           => {domestic eggs}            0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [3]   {soap,                                                                                                         
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [4]   {soap,                                                                                                         
    ##        whole milk}                => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [5]   {domestic eggs,                                                                                                
    ##        skin care}                 => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [6]   {bottled water,                                                                                                
    ##        cookware}                  => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [7]   {frankfurter,                                                                                                  
    ##        potato products}           => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [8]   {syrup,                                                                                                        
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [9]   {ice cream,                                                                                                    
    ##        prosecco}                  => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [10]  {prosecco,                                                                                                     
    ##        waffles}                   => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [11]  {prosecco,                                                                                                     
    ##        waffles}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [12]  {prosecco,                                                                                                     
    ##        waffles}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [13]  {prosecco,                                                                                                     
    ##        whole milk}                => {waffles}                  0.0001336630  1.0000000 0.0001336630  54.018051     2
    ## [14]  {prosecco,                                                                                                     
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [15]  {prosecco,                                                                                                     
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [16]  {canned fruit,                                                                                                 
    ##        sausage}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [17]  {cat food,                                                                                                     
    ##        tea}                       => {frozen vegetables}        0.0001336630  1.0000000 0.0001336630  35.711217     2
    ## [18]  {frozen vegetables,                                                                                            
    ##        tea}                       => {cat food}                 0.0001336630  1.0000000 0.0001336630  84.536723     2
    ## [19]  {cream cheese,                                                                                                 
    ##        nut snack}                 => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [20]  {curd,                                                                                                         
    ##        nut snack}                 => {cream cheese}             0.0001336630  1.0000000 0.0001336630  42.268362     2
    ## [21]  {newspapers,                                                                                                   
    ##        nut snack}                 => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [22]  {nut snack,                                                                                                    
    ##        other vegetables}          => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [23]  {jam,                                                                                                          
    ##        pip fruit}                 => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [24]  {cereals,                                                                                                      
    ##        packaged fruit/vegetables} => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [25]  {artif. sweetener,                                                                                             
    ##        bottled water}             => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [26]  {dental care,                                                                                                  
    ##        napkins}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [27]  {dental care,                                                                                                  
    ##        pip fruit}                 => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [28]  {brown bread,                                                                                                  
    ##        sauces}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [29]  {shopping bags,                                                                                                
    ##        spices}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [30]  {softener,                                                                                                     
    ##        vinegar}                   => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [31]  {softener,                                                                                                     
    ##        vinegar}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [32]  {pip fruit,                                                                                                    
    ##        softener}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [33]  {house keeping products,                                                                                       
    ##        semi-finished bread}       => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [34]  {house keeping products,                                                                                       
    ##        margarine}                 => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [35]  {canned beer,                                                                                                  
    ##        house keeping products}    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [36]  {bottled water,                                                                                                
    ##        house keeping products}    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [37]  {house keeping products,                                                                                       
    ##        other vegetables}          => {whole milk}               0.0002673261  1.0000000 0.0002673261   6.332205     4
    ## [38]  {citrus fruit,                                                                                                 
    ##        soups}                     => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [39]  {ice cream,                                                                                                    
    ##        popcorn}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [40]  {oil,                                                                                                          
    ##        popcorn}                   => {pork}                     0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [41]  {grapes,                                                                                                       
    ##        vinegar}                   => {frozen vegetables}        0.0001336630  1.0000000 0.0001336630  35.711217     2
    ## [42]  {frozen vegetables,                                                                                            
    ##        vinegar}                   => {grapes}                   0.0001336630  1.0000000 0.0001336630  69.273148     2
    ## [43]  {vinegar,                                                                                                      
    ##        white bread}               => {beef}                     0.0001336630  1.0000000 0.0001336630  29.454724     2
    ## [44]  {beef,                                                                                                         
    ##        vinegar}                   => {white bread}              0.0001336630  1.0000000 0.0001336630  41.679666     2
    ## [45]  {sausage,                                                                                                      
    ##        vinegar}                   => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [46]  {canned beer,                                                                                                  
    ##        Instant food products}     => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [47]  {chocolate marshmallow,                                                                                        
    ##        sugar}                     => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [48]  {chocolate marshmallow,                                                                                        
    ##        domestic eggs}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [49]  {frankfurter,                                                                                                  
    ##        liver loaf}                => {condensed milk}           0.0001336630  1.0000000 0.0001336630 152.683673     2
    ## [50]  {liver loaf,                                                                                                   
    ##        sausage}                   => {white bread}              0.0001336630  1.0000000 0.0001336630  41.679666     2
    ## [51]  {liver loaf,                                                                                                   
    ##        shopping bags}             => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [52]  {berries,                                                                                                      
    ##        zwieback}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [53]  {frankfurter,                                                                                                  
    ##        zwieback}                  => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [54]  {flower (seeds),                                                                                               
    ##        pork}                      => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [55]  {candles,                                                                                                      
    ##        white bread}               => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [56]  {candles,                                                                                                      
    ##        curd}                      => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [57]  {finished products,                                                                                            
    ##        onions}                    => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [58]  {chocolate,                                                                                                    
    ##        finished products}         => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [59]  {chocolate,                                                                                                    
    ##        finished products}         => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [60]  {curd,                                                                                                         
    ##        finished products}         => {whipped/sour cream}       0.0001336630  1.0000000 0.0001336630  22.879205     2
    ## [61]  {butter,                                                                                                       
    ##        finished products}         => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [62]  {fruit/vegetable juice,                                                                                        
    ##        specialty cheese}          => {long life bakery product} 0.0001336630  1.0000000 0.0001336630  55.832090     2
    ## [63]  {frozen potato products,                                                                                       
    ##        UHT-milk}                  => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [64]  {dog food,                                                                                                     
    ##        sliced cheese}             => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [65]  {dog food,                                                                                                     
    ##        fruit/vegetable juice}     => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [66]  {dog food,                                                                                                     
    ##        fruit/vegetable juice}     => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [67]  {cling film/bags,                                                                                              
    ##        newspapers}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [68]  {cling film/bags,                                                                                              
    ##        shopping bags}             => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [69]  {mayonnaise,                                                                                                   
    ##        oil}                       => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [70]  {mayonnaise,                                                                                                   
    ##        newspapers}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [71]  {mayonnaise,                                                                                                   
    ##        pip fruit}                 => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [72]  {curd,                                                                                                         
    ##        pet care}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [73]  {specialty chocolate,                                                                                          
    ##        sweet spreads}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [74]  {butter milk,                                                                                                  
    ##        sweet spreads}             => {berries}                  0.0001336630  1.0000000 0.0001336630  45.898773     2
    ## [75]  {hamburger meat,                                                                                               
    ##        sweet spreads}             => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [76]  {curd,                                                                                                         
    ##        sweet spreads}             => {hamburger meat}           0.0001336630  1.0000000 0.0001336630  45.758410     2
    ## [77]  {napkins,                                                                                                      
    ##        sweet spreads}             => {chocolate}                0.0001336630  1.0000000 0.0001336630  42.388102     2
    ## [78]  {canned vegetables,                                                                                            
    ##        domestic eggs}             => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [79]  {bottled beer,                                                                                                 
    ##        salt}                      => {misc. beverages}          0.0001336630  1.0000000 0.0001336630  63.402542     2
    ## [80]  {misc. beverages,                                                                                              
    ##        turkey}                    => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [81]  {bottled beer,                                                                                                 
    ##        turkey}                    => {misc. beverages}          0.0001336630  1.0000000 0.0001336630  63.402542     2
    ## [82]  {ham,                                                                                                          
    ##        turkey}                    => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [83]  {ham,                                                                                                          
    ##        turkey}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [84]  {beef,                                                                                                         
    ##        turkey}                    => {shopping bags}            0.0001336630  1.0000000 0.0001336630  21.015449     2
    ## [85]  {pork,                                                                                                         
    ##        turkey}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [86]  {pork,                                                                                                         
    ##        turkey}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [87]  {citrus fruit,                                                                                                 
    ##        turkey}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [88]  {hamburger meat,                                                                                               
    ##        mustard}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [89]  {cake bar,                                                                                                     
    ##        frozen vegetables}         => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [90]  {frozen dessert,                                                                                               
    ##        pip fruit}                 => {pork}                     0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [91]  {flour,                                                                                                        
    ##        liquor}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [92]  {flour,                                                                                                        
    ##        liquor}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [93]  {frankfurter,                                                                                                  
    ##        liquor}                    => {bottled water}            0.0001336630  1.0000000 0.0001336630  16.479075     2
    ## [94]  {frozen fish,                                                                                                  
    ##        napkins}                   => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [95]  {frozen meals,                                                                                                 
    ##        spread cheese}             => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [96]  {frozen meals,                                                                                                 
    ##        spread cheese}             => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [97]  {spread cheese,                                                                                                
    ##        UHT-milk}                  => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [98]  {frankfurter,                                                                                                  
    ##        spread cheese}             => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [99]  {canned beer,                                                                                                  
    ##        spread cheese}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [100] {condensed milk,                                                                                               
    ##        pip fruit}                 => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [101] {canned fish,                                                                                                  
    ##        pasta}                     => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [102] {canned fish,                                                                                                  
    ##        chocolate}                 => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [103] {hygiene articles,                                                                                             
    ##        pot plants}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [104] {pork,                                                                                                         
    ##        pot plants}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [105] {baking powder,                                                                                                
    ##        specialty bar}             => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [106] {baking powder,                                                                                                
    ##        sliced cheese}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [107] {pickled vegetables,                                                                                           
    ##        processed cheese}          => {bottled water}            0.0001336630  1.0000000 0.0001336630  16.479075     2
    ## [108] {detergent,                                                                                                    
    ##        oil}                       => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [109] {cream cheese,                                                                                                 
    ##        detergent}                 => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [110] {citrus fruit,                                                                                                 
    ##        detergent}                 => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [111] {cat food,                                                                                                     
    ##        dishes}                    => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [112] {fruit/vegetable juice,                                                                                        
    ##        semi-finished bread}       => {rolls/buns}               0.0002673261  0.8000000 0.0003341576   7.272418     4
    ## [113] {flour,                                                                                                        
    ##        salty snack}               => {bottled water}            0.0001336630  1.0000000 0.0001336630  16.479075     2
    ## [114] {flour,                                                                                                        
    ##        margarine}                 => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [115] {butter,                                                                                                       
    ##        processed cheese}          => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [116] {pastry,                                                                                                       
    ##        processed cheese}          => {whole milk}               0.0002673261  0.8000000 0.0003341576   5.065764     4
    ## [117] {soft cheese,                                                                                                  
    ##        specialty bar}             => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [118] {cat food,                                                                                                     
    ##        long life bakery product}  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [119] {chewing gum,                                                                                                  
    ##        white bread}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [120] {coffee,                                                                                                       
    ##        specialty bar}             => {shopping bags}            0.0001336630  1.0000000 0.0001336630  21.015449     2
    ## [121] {hygiene articles,                                                                                             
    ##        misc. beverages}           => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [122] {frozen meals,                                                                                                 
    ##        hygiene articles}          => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [123] {frozen meals,                                                                                                 
    ##        hygiene articles}          => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [124] {hygiene articles,                                                                                             
    ##        salty snack}               => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [125] {butter milk,                                                                                                  
    ##        candy}                     => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [126] {beverages,                                                                                                    
    ##        ice cream}                 => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [127] {fruit/vegetable juice,                                                                                        
    ##        grapes}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [128] {oil,                                                                                                          
    ##        specialty chocolate}       => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [129] {ham,                                                                                                          
    ##        oil}                       => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [130] {hard cheese,                                                                                                  
    ##        specialty chocolate}       => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [131] {beverages,                                                                                                    
    ##        hard cheese}               => {fruit/vegetable juice}    0.0001336630  1.0000000 0.0001336630  29.396857     2
    ## [132] {berries,                                                                                                      
    ##        specialty chocolate}       => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [133] {ham,                                                                                                          
    ##        salty snack}               => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [134] {ham,                                                                                                          
    ##        pip fruit}                 => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [135] {hamburger meat,                                                                                               
    ##        long life bakery product}  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [136] {prosecco,                                                                                                     
    ##        sausage,                                                                                                      
    ##        waffles}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [137] {other vegetables,                                                                                             
    ##        prosecco,                                                                                                     
    ##        waffles}                   => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [138] {other vegetables,                                                                                             
    ##        prosecco,                                                                                                     
    ##        sausage}                   => {waffles}                  0.0001336630  1.0000000 0.0001336630  54.018051     2
    ## [139] {prosecco,                                                                                                     
    ##        sausage,                                                                                                      
    ##        waffles}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [140] {prosecco,                                                                                                     
    ##        waffles,                                                                                                      
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [141] {prosecco,                                                                                                     
    ##        sausage,                                                                                                      
    ##        whole milk}                => {waffles}                  0.0001336630  1.0000000 0.0001336630  54.018051     2
    ## [142] {other vegetables,                                                                                             
    ##        prosecco,                                                                                                     
    ##        waffles}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [143] {prosecco,                                                                                                     
    ##        waffles,                                                                                                      
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [144] {other vegetables,                                                                                             
    ##        prosecco,                                                                                                     
    ##        whole milk}                => {waffles}                  0.0001336630  1.0000000 0.0001336630  54.018051     2
    ## [145] {other vegetables,                                                                                             
    ##        prosecco,                                                                                                     
    ##        sausage}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [146] {prosecco,                                                                                                     
    ##        sausage,                                                                                                      
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [147] {other vegetables,                                                                                             
    ##        prosecco,                                                                                                     
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [148] {nuts/prunes,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        sausage}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [149] {nuts/prunes,                                                                                                  
    ##        sausage,                                                                                                      
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [150] {nuts/prunes,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [151] {frankfurter,                                                                                                  
    ##        softener,                                                                                                     
    ##        vinegar}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [152] {softener,                                                                                                     
    ##        vinegar,                                                                                                      
    ##        whole milk}                => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [153] {frankfurter,                                                                                                  
    ##        softener,                                                                                                     
    ##        whole milk}                => {vinegar}                  0.0001336630  1.0000000 0.0001336630 293.392157     2
    ## [154] {frankfurter,                                                                                                  
    ##        vinegar,                                                                                                      
    ##        whole milk}                => {softener}                 0.0001336630  1.0000000 0.0001336630 364.951220     2
    ## [155] {other vegetables,                                                                                             
    ##        rolls/buns,                                                                                                   
    ##        softener}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [156] {rolls/buns,                                                                                                   
    ##        softener,                                                                                                     
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [157] {bottled water,                                                                                                
    ##        pip fruit,                                                                                                    
    ##        popcorn}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [158] {pip fruit,                                                                                                    
    ##        popcorn,                                                                                                      
    ##        rolls/buns}                => {bottled water}            0.0001336630  1.0000000 0.0001336630  16.479075     2
    ## [159] {bottled water,                                                                                                
    ##        pip fruit,                                                                                                    
    ##        rolls/buns}                => {popcorn}                  0.0001336630  1.0000000 0.0001336630 311.729167     2
    ## [160] {canned beer,                                                                                                  
    ##        sausage,                                                                                                      
    ##        zwieback}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [161] {canned beer,                                                                                                  
    ##        whole milk,                                                                                                   
    ##        zwieback}                  => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [162] {sausage,                                                                                                      
    ##        whole milk,                                                                                                   
    ##        zwieback}                  => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [163] {chocolate,                                                                                                    
    ##        finished products,                                                                                            
    ##        other vegetables}          => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [164] {chocolate,                                                                                                    
    ##        finished products,                                                                                            
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [165] {dog food,                                                                                                     
    ##        fruit/vegetable juice,                                                                                        
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [166] {dog food,                                                                                                     
    ##        fruit/vegetable juice,                                                                                        
    ##        rolls/buns}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [167] {dog food,                                                                                                     
    ##        rolls/buns,                                                                                                   
    ##        yogurt}                    => {fruit/vegetable juice}    0.0001336630  1.0000000 0.0001336630  29.396857     2
    ## [168] {dog food,                                                                                                     
    ##        rolls/buns,                                                                                                   
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [169] {dog food,                                                                                                     
    ##        soda,                                                                                                         
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [170] {dog food,                                                                                                     
    ##        rolls/buns,                                                                                                   
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [171] {bottled water,                                                                                                
    ##        other vegetables,                                                                                             
    ##        pet care}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [172] {bottled water,                                                                                                
    ##        pet care,                                                                                                     
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [173] {berries,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        sweet spreads}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [174] {berries,                                                                                                      
    ##        sweet spreads,                                                                                                
    ##        whole milk}                => {pip fruit}                0.0001336630  1.0000000 0.0001336630  20.385559     2
    ## [175] {berries,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        whole milk}                => {sweet spreads}            0.0001336630  1.0000000 0.0001336630 220.044118     2
    ## [176] {other vegetables,                                                                                             
    ##        soda,                                                                                                         
    ##        sweet spreads}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [177] {other vegetables,                                                                                             
    ##        sweet spreads,                                                                                                
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [178] {meat,                                                                                                         
    ##        roll products,                                                                                                
    ##        tropical fruit}            => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [179] {meat,                                                                                                         
    ##        other vegetables,                                                                                             
    ##        roll products}             => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [180] {other vegetables,                                                                                             
    ##        roll products,                                                                                                
    ##        tropical fruit}            => {meat}                     0.0001336630  1.0000000 0.0001336630  59.376984     2
    ## [181] {ham,                                                                                                          
    ##        pastry,                                                                                                       
    ##        turkey}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [182] {ham,                                                                                                          
    ##        soda,                                                                                                         
    ##        turkey}                    => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [183] {pastry,                                                                                                       
    ##        soda,                                                                                                         
    ##        turkey}                    => {ham}                      0.0001336630  1.0000000 0.0001336630  58.449219     2
    ## [184] {ham,                                                                                                          
    ##        pastry,                                                                                                       
    ##        soda}                      => {turkey}                   0.0001336630  1.0000000 0.0001336630 187.037500     2
    ## [185] {pork,                                                                                                         
    ##        soda,                                                                                                         
    ##        turkey}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [186] {pork,                                                                                                         
    ##        turkey,                                                                                                       
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [187] {mustard,                                                                                                      
    ##        other vegetables,                                                                                             
    ##        root vegetables}           => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [188] {mustard,                                                                                                      
    ##        root vegetables,                                                                                              
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [189] {mustard,                                                                                                      
    ##        other vegetables,                                                                                             
    ##        whole milk}                => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [190] {cake bar,                                                                                                     
    ##        curd,                                                                                                         
    ##        tropical fruit}            => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [191] {cake bar,                                                                                                     
    ##        curd,                                                                                                         
    ##        rolls/buns}                => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [192] {cake bar,                                                                                                     
    ##        rolls/buns,                                                                                                   
    ##        tropical fruit}            => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [193] {cake bar,                                                                                                     
    ##        curd,                                                                                                         
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [194] {cake bar,                                                                                                     
    ##        curd,                                                                                                         
    ##        whole milk}                => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [195] {cake bar,                                                                                                     
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [196] {cake bar,                                                                                                     
    ##        curd,                                                                                                         
    ##        rolls/buns}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [197] {cake bar,                                                                                                     
    ##        curd,                                                                                                         
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [198] {brown bread,                                                                                                  
    ##        cake bar,                                                                                                     
    ##        canned beer}               => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [199] {brown bread,                                                                                                  
    ##        cake bar,                                                                                                     
    ##        sausage}                   => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [200] {cake bar,                                                                                                     
    ##        canned beer,                                                                                                  
    ##        sausage}                   => {brown bread}              0.0001336630  1.0000000 0.0001336630  26.577265     2
    ## [201] {cake bar,                                                                                                     
    ##        rolls/buns,                                                                                                   
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [202] {cake bar,                                                                                                     
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [203] {flour,                                                                                                        
    ##        liquor,                                                                                                       
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [204] {flour,                                                                                                        
    ##        liquor,                                                                                                       
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [205] {liquor,                                                                                                       
    ##        soda,                                                                                                         
    ##        whole milk}                => {flour}                    0.0001336630  1.0000000 0.0001336630 102.486301     2
    ## [206] {frozen meals,                                                                                                 
    ##        root vegetables,                                                                                              
    ##        spread cheese}             => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [207] {frozen meals,                                                                                                 
    ##        soda,                                                                                                         
    ##        spread cheese}             => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [208] {root vegetables,                                                                                              
    ##        soda,                                                                                                         
    ##        spread cheese}             => {frozen meals}             0.0001336630  1.0000000 0.0001336630  59.613546     2
    ## [209] {frozen meals,                                                                                                 
    ##        root vegetables,                                                                                              
    ##        soda}                      => {spread cheese}            0.0001336630  1.0000000 0.0001336630 149.630000     2
    ## [210] {condensed milk,                                                                                               
    ##        root vegetables,                                                                                              
    ##        tropical fruit}            => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [211] {condensed milk,                                                                                               
    ##        rolls/buns,                                                                                                   
    ##        root vegetables}           => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [212] {condensed milk,                                                                                               
    ##        rolls/buns,                                                                                                   
    ##        tropical fruit}            => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [213] {coffee,                                                                                                       
    ##        pastry,                                                                                                       
    ##        seasonal products}         => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [214] {coffee,                                                                                                       
    ##        seasonal products,                                                                                            
    ##        whole milk}                => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [215] {pastry,                                                                                                       
    ##        seasonal products,                                                                                            
    ##        whole milk}                => {coffee}                   0.0001336630  1.0000000 0.0001336630  31.634249     2
    ## [216] {bottled beer,                                                                                                 
    ##        canned fish,                                                                                                  
    ##        onions}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [217] {canned fish,                                                                                                  
    ##        onions,                                                                                                       
    ##        whole milk}                => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [218] {bottled beer,                                                                                                 
    ##        canned fish,                                                                                                  
    ##        whole milk}                => {onions}                   0.0001336630  1.0000000 0.0001336630  49.382838     2
    ## [219] {bottled beer,                                                                                                 
    ##        onions,                                                                                                       
    ##        whole milk}                => {canned fish}              0.0001336630  1.0000000 0.0001336630 130.113043     2
    ## [220] {canned fish,                                                                                                  
    ##        frankfurter,                                                                                                  
    ##        UHT-milk}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [221] {canned fish,                                                                                                  
    ##        UHT-milk,                                                                                                     
    ##        whole milk}                => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [222] {frankfurter,                                                                                                  
    ##        UHT-milk,                                                                                                     
    ##        whole milk}                => {canned fish}              0.0001336630  1.0000000 0.0001336630 130.113043     2
    ## [223] {other vegetables,                                                                                             
    ##        pot plants,                                                                                                   
    ##        shopping bags}             => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [224] {other vegetables,                                                                                             
    ##        pot plants,                                                                                                   
    ##        tropical fruit}            => {shopping bags}            0.0001336630  1.0000000 0.0001336630  21.015449     2
    ## [225] {pastry,                                                                                                       
    ##        pot plants,                                                                                                   
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [226] {pastry,                                                                                                       
    ##        pot plants,                                                                                                   
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [227] {fruit/vegetable juice,                                                                                        
    ##        pasta,                                                                                                        
    ##        pip fruit}                 => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [228] {fruit/vegetable juice,                                                                                        
    ##        pasta,                                                                                                        
    ##        rolls/buns}                => {pip fruit}                0.0001336630  1.0000000 0.0001336630  20.385559     2
    ## [229] {pasta,                                                                                                        
    ##        pastry,                                                                                                       
    ##        soda}                      => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [230] {pasta,                                                                                                        
    ##        soda,                                                                                                         
    ##        tropical fruit}            => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [231] {detergent,                                                                                                    
    ##        dishes,                                                                                                       
    ##        sausage}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [232] {detergent,                                                                                                    
    ##        dishes,                                                                                                       
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [233] {dishes,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        whipped/sour cream}        => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [234] {citrus fruit,                                                                                                 
    ##        dishes,                                                                                                       
    ##        frankfurter}               => {whipped/sour cream}       0.0001336630  1.0000000 0.0001336630  22.879205     2
    ## [235] {dishes,                                                                                                       
    ##        whipped/sour cream,                                                                                           
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [236] {dishes,                                                                                                       
    ##        pip fruit,                                                                                                    
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [237] {dishes,                                                                                                       
    ##        rolls/buns,                                                                                                   
    ##        whole milk}                => {pip fruit}                0.0001336630  1.0000000 0.0001336630  20.385559     2
    ## [238] {fruit/vegetable juice,                                                                                        
    ##        semi-finished bread,                                                                                          
    ##        tropical fruit}            => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [239] {rolls/buns,                                                                                                   
    ##        semi-finished bread,                                                                                          
    ##        tropical fruit}            => {fruit/vegetable juice}    0.0001336630  1.0000000 0.0001336630  29.396857     2
    ## [240] {sausage,                                                                                                      
    ##        semi-finished bread,                                                                                          
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [241] {flour,                                                                                                        
    ##        specialty chocolate,                                                                                          
    ##        whipped/sour cream}        => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [242] {flour,                                                                                                        
    ##        onions,                                                                                                       
    ##        tropical fruit}            => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [243] {flour,                                                                                                        
    ##        onions,                                                                                                       
    ##        yogurt}                    => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [244] {flour,                                                                                                        
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {onions}                   0.0001336630  1.0000000 0.0001336630  49.382838     2
    ## [245] {flour,                                                                                                        
    ##        rolls/buns,                                                                                                   
    ##        whipped/sour cream}        => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [246] {flour,                                                                                                        
    ##        rolls/buns,                                                                                                   
    ##        tropical fruit}            => {whipped/sour cream}       0.0001336630  1.0000000 0.0001336630  22.879205     2
    ## [247] {citrus fruit,                                                                                                 
    ##        herbs,                                                                                                        
    ##        pork}                      => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [248] {citrus fruit,                                                                                                 
    ##        herbs,                                                                                                        
    ##        other vegetables}          => {pork}                     0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [249] {frankfurter,                                                                                                  
    ##        herbs,                                                                                                        
    ##        yogurt}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [250] {frankfurter,                                                                                                  
    ##        herbs,                                                                                                        
    ##        other vegetables}          => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [251] {pastry,                                                                                                       
    ##        processed cheese,                                                                                             
    ##        rolls/buns}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [252] {citrus fruit,                                                                                                 
    ##        shopping bags,                                                                                                
    ##        white wine}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [253] {shopping bags,                                                                                                
    ##        white wine,                                                                                                   
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [254] {citrus fruit,                                                                                                 
    ##        white wine,                                                                                                   
    ##        whole milk}                => {shopping bags}            0.0001336630  1.0000000 0.0001336630  21.015449     2
    ## [255] {cat food,                                                                                                     
    ##        citrus fruit,                                                                                                 
    ##        frozen vegetables}         => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [256] {cat food,                                                                                                     
    ##        frozen vegetables,                                                                                            
    ##        other vegetables}          => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [257] {cat food,                                                                                                     
    ##        citrus fruit,                                                                                                 
    ##        other vegetables}          => {frozen vegetables}        0.0001336630  1.0000000 0.0001336630  35.711217     2
    ## [258] {chewing gum,                                                                                                  
    ##        hamburger meat,                                                                                               
    ##        sausage}                   => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [259] {chewing gum,                                                                                                  
    ##        hamburger meat,                                                                                               
    ##        soda}                      => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [260] {chewing gum,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        root vegetables}           => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [261] {chewing gum,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        whole milk}                => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [262] {candy,                                                                                                        
    ##        ham,                                                                                                          
    ##        specialty bar}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [263] {candy,                                                                                                        
    ##        specialty bar,                                                                                                
    ##        whole milk}                => {ham}                      0.0001336630  1.0000000 0.0001336630  58.449219     2
    ## [264] {ham,                                                                                                          
    ##        specialty bar,                                                                                                
    ##        whole milk}                => {candy}                    0.0001336630  1.0000000 0.0001336630  69.595349     2
    ## [265] {beverages,                                                                                                    
    ##        curd,                                                                                                         
    ##        specialty bar}             => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [266] {curd,                                                                                                         
    ##        other vegetables,                                                                                             
    ##        specialty bar}             => {beverages}                0.0001336630  1.0000000 0.0001336630  60.334677     2
    ## [267] {beverages,                                                                                                    
    ##        rolls/buns,                                                                                                   
    ##        specialty bar}             => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [268] {other vegetables,                                                                                             
    ##        rolls/buns,                                                                                                   
    ##        specialty bar}             => {beverages}                0.0001336630  1.0000000 0.0001336630  60.334677     2
    ## [269] {bottled water,                                                                                                
    ##        specialty bar,                                                                                                
    ##        tropical fruit}            => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [270] {soda,                                                                                                         
    ##        specialty bar,                                                                                                
    ##        tropical fruit}            => {bottled water}            0.0001336630  1.0000000 0.0001336630  16.479075     2
    ## [271] {bottled water,                                                                                                
    ##        specialty bar,                                                                                                
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [272] {frozen meals,                                                                                                 
    ##        hygiene articles,                                                                                             
    ##        sausage}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [273] {frozen meals,                                                                                                 
    ##        hygiene articles,                                                                                             
    ##        rolls/buns}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [274] {hygiene articles,                                                                                             
    ##        rolls/buns,                                                                                                   
    ##        sausage}                   => {frozen meals}             0.0001336630  1.0000000 0.0001336630  59.613546     2
    ## [275] {canned beer,                                                                                                  
    ##        chicken,                                                                                                      
    ##        hygiene articles}          => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [276] {chicken,                                                                                                      
    ##        hygiene articles,                                                                                             
    ##        whole milk}                => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [277] {canned beer,                                                                                                  
    ##        curd,                                                                                                         
    ##        hygiene articles}          => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [278] {frankfurter,                                                                                                  
    ##        hygiene articles,                                                                                             
    ##        other vegetables}          => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [279] {frankfurter,                                                                                                  
    ##        hygiene articles,                                                                                             
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [280] {bottled beer,                                                                                                 
    ##        hygiene articles,                                                                                             
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [281] {bottled beer,                                                                                                 
    ##        hygiene articles,                                                                                             
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [282] {canned beer,                                                                                                  
    ##        hygiene articles,                                                                                             
    ##        soda}                      => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [283] {citrus fruit,                                                                                                 
    ##        hygiene articles,                                                                                             
    ##        shopping bags}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [284] {citrus fruit,                                                                                                 
    ##        hygiene articles,                                                                                             
    ##        whole milk}                => {shopping bags}            0.0001336630  1.0000000 0.0001336630  21.015449     2
    ## [285] {pastry,                                                                                                       
    ##        sliced cheese,                                                                                                
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [286] {bottled beer,                                                                                                 
    ##        candy,                                                                                                        
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [287] {candy,                                                                                                        
    ##        rolls/buns,                                                                                                   
    ##        whole milk}                => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [288] {candy,                                                                                                        
    ##        citrus fruit,                                                                                                 
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [289] {candy,                                                                                                        
    ##        root vegetables,                                                                                              
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [290] {candy,                                                                                                        
    ##        rolls/buns,                                                                                                   
    ##        root vegetables}           => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [291] {fruit/vegetable juice,                                                                                        
    ##        ice cream,                                                                                                    
    ##        pip fruit}                 => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [292] {fruit/vegetable juice,                                                                                        
    ##        ice cream,                                                                                                    
    ##        rolls/buns}                => {pip fruit}                0.0001336630  1.0000000 0.0001336630  20.385559     2
    ## [293] {citrus fruit,                                                                                                 
    ##        frankfurter,                                                                                                  
    ##        ice cream}                 => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [294] {frankfurter,                                                                                                  
    ##        ice cream,                                                                                                    
    ##        yogurt}                    => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [295] {frankfurter,                                                                                                  
    ##        ice cream,                                                                                                    
    ##        rolls/buns}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [296] {frankfurter,                                                                                                  
    ##        ice cream,                                                                                                    
    ##        other vegetables}          => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [297] {ice cream,                                                                                                    
    ##        other vegetables,                                                                                             
    ##        rolls/buns}                => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [298] {grapes,                                                                                                       
    ##        meat,                                                                                                         
    ##        other vegetables}          => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [299] {grapes,                                                                                                       
    ##        meat,                                                                                                         
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [300] {dessert,                                                                                                      
    ##        grapes,                                                                                                       
    ##        sausage}                   => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [301] {dessert,                                                                                                      
    ##        grapes,                                                                                                       
    ##        soda}                      => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [302] {frozen meals,                                                                                                 
    ##        oil,                                                                                                          
    ##        pork}                      => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [303] {frozen meals,                                                                                                 
    ##        oil,                                                                                                          
    ##        other vegetables}          => {pork}                     0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [304] {brown bread,                                                                                                  
    ##        oil,                                                                                                          
    ##        pork}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [305] {brown bread,                                                                                                  
    ##        oil,                                                                                                          
    ##        whole milk}                => {pork}                     0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [306] {oil,                                                                                                          
    ##        pork,                                                                                                         
    ##        root vegetables}           => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [307] {oil,                                                                                                          
    ##        pork,                                                                                                         
    ##        rolls/buns}                => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [308] {canned beer,                                                                                                  
    ##        oil,                                                                                                          
    ##        rolls/buns}                => {pork}                     0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [309] {citrus fruit,                                                                                                 
    ##        frankfurter,                                                                                                  
    ##        oil}                       => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [310] {citrus fruit,                                                                                                 
    ##        frankfurter,                                                                                                  
    ##        soda}                      => {oil}                      0.0001336630  1.0000000 0.0001336630  67.098655     2
    ## [311] {oil,                                                                                                          
    ##        root vegetables,                                                                                              
    ##        shopping bags}             => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [312] {oil,                                                                                                          
    ##        shopping bags,                                                                                                
    ##        soda}                      => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [313] {misc. beverages,                                                                                              
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [314] {misc. beverages,                                                                                              
    ##        other vegetables,                                                                                             
    ##        sausage}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [315] {misc. beverages,                                                                                              
    ##        other vegetables,                                                                                             
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [316] {misc. beverages,                                                                                              
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [317] {misc. beverages,                                                                                              
    ##        other vegetables,                                                                                             
    ##        sausage}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [318] {misc. beverages,                                                                                              
    ##        other vegetables,                                                                                             
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [319] {misc. beverages,                                                                                              
    ##        other vegetables,                                                                                             
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [320] {misc. beverages,                                                                                              
    ##        other vegetables,                                                                                             
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [321] {curd,                                                                                                         
    ##        hard cheese,                                                                                                  
    ##        sausage}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [322] {curd,                                                                                                         
    ##        hard cheese,                                                                                                  
    ##        root vegetables}           => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [323] {hard cheese,                                                                                                  
    ##        newspapers,                                                                                                   
    ##        soda}                      => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [324] {hard cheese,                                                                                                  
    ##        other vegetables,                                                                                             
    ##        soda}                      => {newspapers}               0.0001336630  1.0000000 0.0001336630  25.709622     2
    ## [325] {hard cheese,                                                                                                  
    ##        other vegetables,                                                                                             
    ##        pip fruit}                 => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [326] {hard cheese,                                                                                                  
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [327] {citrus fruit,                                                                                                 
    ##        hamburger meat,                                                                                               
    ##        specialty chocolate}       => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [328] {hamburger meat,                                                                                               
    ##        other vegetables,                                                                                             
    ##        specialty chocolate}       => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [329] {citrus fruit,                                                                                                 
    ##        dessert,                                                                                                      
    ##        specialty chocolate}       => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [330] {dessert,                                                                                                      
    ##        sausage,                                                                                                      
    ##        specialty chocolate}       => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [331] {citrus fruit,                                                                                                 
    ##        sausage,                                                                                                      
    ##        specialty chocolate}       => {dessert}                  0.0001336630  1.0000000 0.0001336630  42.388102     2
    ## [332] {citrus fruit,                                                                                                 
    ##        dessert,                                                                                                      
    ##        sausage}                   => {specialty chocolate}      0.0001336630  1.0000000 0.0001336630  62.606695     2
    ## [333] {chicken,                                                                                                      
    ##        cream cheese,                                                                                                 
    ##        specialty chocolate}       => {citrus fruit}             0.0002004946  1.0000000 0.0002004946  18.821384     3
    ## [334] {chicken,                                                                                                      
    ##        citrus fruit,                                                                                                 
    ##        cream cheese}              => {specialty chocolate}      0.0002004946  1.0000000 0.0002004946  62.606695     3
    ## [335] {chicken,                                                                                                      
    ##        curd,                                                                                                         
    ##        specialty chocolate}       => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [336] {chicken,                                                                                                      
    ##        citrus fruit,                                                                                                 
    ##        curd}                      => {specialty chocolate}      0.0001336630  1.0000000 0.0001336630  62.606695     2
    ## [337] {chicken,                                                                                                      
    ##        specialty chocolate,                                                                                          
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [338] {curd,                                                                                                         
    ##        pastry,                                                                                                       
    ##        specialty chocolate}       => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [339] {citrus fruit,                                                                                                 
    ##        pastry,                                                                                                       
    ##        specialty chocolate}       => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [340] {curd,                                                                                                         
    ##        pastry,                                                                                                       
    ##        specialty chocolate}       => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [341] {other vegetables,                                                                                             
    ##        pastry,                                                                                                       
    ##        specialty chocolate}       => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [342] {citrus fruit,                                                                                                 
    ##        pastry,                                                                                                       
    ##        specialty chocolate}       => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [343] {other vegetables,                                                                                             
    ##        pastry,                                                                                                       
    ##        specialty chocolate}       => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [344] {specialty chocolate,                                                                                          
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [345] {beverages,                                                                                                    
    ##        hamburger meat,                                                                                               
    ##        yogurt}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [346] {beverages,                                                                                                    
    ##        soda,                                                                                                         
    ##        yogurt}                    => {hamburger meat}           0.0001336630  1.0000000 0.0001336630  45.758410     2
    ## [347] {beverages,                                                                                                    
    ##        canned beer,                                                                                                  
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [348] {beverages,                                                                                                    
    ##        pip fruit,                                                                                                    
    ##        sausage}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [349] {beverages,                                                                                                    
    ##        pip fruit,                                                                                                    
    ##        rolls/buns}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [350] {beverages,                                                                                                    
    ##        rolls/buns,                                                                                                   
    ##        sausage}                   => {pip fruit}                0.0001336630  1.0000000 0.0001336630  20.385559     2
    ## [351] {beverages,                                                                                                    
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [352] {beverages,                                                                                                    
    ##        other vegetables,                                                                                             
    ##        sausage}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [353] {beverages,                                                                                                    
    ##        other vegetables,                                                                                             
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [354] {citrus fruit,                                                                                                 
    ##        ham,                                                                                                          
    ##        onions}                    => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [355] {ham,                                                                                                          
    ##        onions,                                                                                                       
    ##        yogurt}                    => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [356] {citrus fruit,                                                                                                 
    ##        onions,                                                                                                       
    ##        yogurt}                    => {ham}                      0.0001336630  1.0000000 0.0001336630  58.449219     2
    ## [357] {citrus fruit,                                                                                                 
    ##        frozen vegetables,                                                                                            
    ##        ham}                       => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [358] {frozen vegetables,                                                                                            
    ##        ham,                                                                                                          
    ##        yogurt}                    => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [359] {citrus fruit,                                                                                                 
    ##        frozen vegetables,                                                                                            
    ##        ham}                       => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [360] {frozen vegetables,                                                                                            
    ##        ham,                                                                                                          
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [361] {frozen vegetables,                                                                                            
    ##        ham,                                                                                                          
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [362] {frozen vegetables,                                                                                            
    ##        ham,                                                                                                          
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [363] {canned beer,                                                                                                  
    ##        ham,                                                                                                          
    ##        yogurt}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [364] {ham,                                                                                                          
    ##        other vegetables,                                                                                             
    ##        yogurt}                    => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [365] {canned beer,                                                                                                  
    ##        ham,                                                                                                          
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [366] {ham,                                                                                                          
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [367] {ham,                                                                                                          
    ##        other vegetables,                                                                                             
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [368] {butter milk,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        white bread}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [369] {butter milk,                                                                                                  
    ##        curd,                                                                                                         
    ##        sausage}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [370] {butter milk,                                                                                                  
    ##        curd,                                                                                                         
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [371] {butter milk,                                                                                                  
    ##        curd,                                                                                                         
    ##        rolls/buns}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [372] {butter milk,                                                                                                  
    ##        curd,                                                                                                         
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [373] {brown bread,                                                                                                  
    ##        butter milk,                                                                                                  
    ##        rolls/buns}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [374] {brown bread,                                                                                                  
    ##        butter milk,                                                                                                  
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [375] {butter milk,                                                                                                  
    ##        canned beer,                                                                                                  
    ##        sausage}                   => {yogurt}                   0.0002004946  1.0000000 0.0002004946  11.644358     3
    ## [376] {butter milk,                                                                                                  
    ##        canned beer,                                                                                                  
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [377] {butter milk,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        sausage}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [378] {butter milk,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        sausage}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [379] {frozen meals,                                                                                                 
    ##        long life bakery product,                                                                                     
    ##        sausage}                   => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [380] {frozen meals,                                                                                                 
    ##        long life bakery product,                                                                                     
    ##        soda}                      => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [381] {long life bakery product,                                                                                     
    ##        sausage,                                                                                                      
    ##        soda}                      => {frozen meals}             0.0001336630  1.0000000 0.0001336630  59.613546     2
    ## [382] {frozen meals,                                                                                                 
    ##        other vegetables,                                                                                             
    ##        salty snack}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [383] {frozen meals,                                                                                                 
    ##        salty snack,                                                                                                  
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [384] {frozen meals,                                                                                                 
    ##        margarine,                                                                                                    
    ##        sausage}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [385] {frozen meals,                                                                                                 
    ##        margarine,                                                                                                    
    ##        sausage}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [386] {margarine,                                                                                                    
    ##        other vegetables,                                                                                             
    ##        yogurt}                    => {frozen meals}             0.0001336630  1.0000000 0.0001336630  59.613546     2
    ## [387] {bottled water,                                                                                                
    ##        curd,                                                                                                         
    ##        frozen meals}              => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [388] {bottled water,                                                                                                
    ##        frozen meals,                                                                                                 
    ##        rolls/buns}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [389] {frozen meals,                                                                                                 
    ##        sausage,                                                                                                      
    ##        tropical fruit}            => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [390] {sugar,                                                                                                        
    ##        tropical fruit,                                                                                               
    ##        white bread}               => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [391] {other vegetables,                                                                                             
    ##        sugar,                                                                                                        
    ##        white bread}               => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [392] {rolls/buns,                                                                                                   
    ##        soda,                                                                                                         
    ##        sugar}                     => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [393] {other vegetables,                                                                                             
    ##        rolls/buns,                                                                                                   
    ##        sugar}                     => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [394] {long life bakery product,                                                                                     
    ##        other vegetables,                                                                                             
    ##        rolls/buns}                => {domestic eggs}            0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [395] {curd,                                                                                                         
    ##        waffles,                                                                                                      
    ##        white bread}               => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [396] {frankfurter,                                                                                                  
    ##        waffles,                                                                                                      
    ##        white bread}               => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [397] {sausage,                                                                                                      
    ##        tropical fruit,                                                                                               
    ##        waffles}                   => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [398] {other vegetables,                                                                                             
    ##        root vegetables,                                                                                              
    ##        waffles}                   => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [399] {pip fruit,                                                                                                    
    ##        root vegetables,                                                                                              
    ##        waffles}                   => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [400] {bottled beer,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        salty snack}               => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [401] {canned beer,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        salty snack}               => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [402] {rolls/buns,                                                                                                   
    ##        salty snack,                                                                                                  
    ##        soda}                      => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [403] {root vegetables,                                                                                              
    ##        salty snack,                                                                                                  
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [404] {root vegetables,                                                                                              
    ##        salty snack,                                                                                                  
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [405] {bottled water,                                                                                                
    ##        margarine,                                                                                                    
    ##        onions}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [406] {margarine,                                                                                                    
    ##        onions,                                                                                                       
    ##        other vegetables}          => {bottled water}            0.0001336630  1.0000000 0.0001336630  16.479075     2
    ## [407] {bottled water,                                                                                                
    ##        onions,                                                                                                       
    ##        other vegetables}          => {margarine}                0.0001336630  1.0000000 0.0001336630  31.043568     2
    ## [408] {onions,                                                                                                       
    ##        pork,                                                                                                         
    ##        tropical fruit}            => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [409] {onions,                                                                                                       
    ##        pork,                                                                                                         
    ##        soda}                      => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [410] {onions,                                                                                                       
    ##        sausage,                                                                                                      
    ##        whipped/sour cream}        => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [411] {onions,                                                                                                       
    ##        rolls/buns,                                                                                                   
    ##        whipped/sour cream}        => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [412] {bottled beer,                                                                                                 
    ##        onions,                                                                                                       
    ##        soda}                      => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [413] {bottled beer,                                                                                                 
    ##        onions,                                                                                                       
    ##        other vegetables}          => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [414] {beef,                                                                                                         
    ##        pip fruit,                                                                                                    
    ##        UHT-milk}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [415] {beef,                                                                                                         
    ##        UHT-milk,                                                                                                     
    ##        whole milk}                => {pip fruit}                0.0001336630  1.0000000 0.0001336630  20.385559     2
    ## [416] {berries,                                                                                                      
    ##        fruit/vegetable juice,                                                                                        
    ##        pip fruit}                 => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [417] {berries,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        soda}                      => {fruit/vegetable juice}    0.0001336630  1.0000000 0.0001336630  29.396857     2
    ## [418] {berries,                                                                                                      
    ##        fruit/vegetable juice,                                                                                        
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [419] {hamburger meat,                                                                                               
    ##        other vegetables,                                                                                             
    ##        white bread}               => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [420] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        hamburger meat}            => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [421] {coffee,                                                                                                       
    ##        hamburger meat,                                                                                               
    ##        root vegetables}           => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [422] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        hamburger meat}            => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [423] {coffee,                                                                                                       
    ##        hamburger meat,                                                                                               
    ##        soda}                      => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [424] {coffee,                                                                                                       
    ##        hamburger meat,                                                                                               
    ##        root vegetables}           => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [425] {coffee,                                                                                                       
    ##        hamburger meat,                                                                                               
    ##        soda}                      => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [426] {domestic eggs,                                                                                                
    ##        hamburger meat,                                                                                               
    ##        soda}                      => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [427] {domestic eggs,                                                                                                
    ##        hamburger meat,                                                                                               
    ##        rolls/buns}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [428] {frankfurter,                                                                                                  
    ##        hamburger meat,                                                                                               
    ##        root vegetables}           => {soda}                     0.0002004946  1.0000000 0.0002004946  10.298004     3
    ## [429] {frankfurter,                                                                                                  
    ##        hamburger meat,                                                                                               
    ##        soda}                      => {root vegetables}          0.0002004946  1.0000000 0.0002004946  14.373679     3
    ## [430] {frankfurter,                                                                                                  
    ##        root vegetables,                                                                                              
    ##        soda}                      => {hamburger meat}           0.0002004946  1.0000000 0.0002004946  45.758410     3
    ## [431] {hamburger meat,                                                                                               
    ##        soda,                                                                                                         
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [432] {hamburger meat,                                                                                               
    ##        rolls/buns,                                                                                                   
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [433] {hamburger meat,                                                                                               
    ##        other vegetables,                                                                                             
    ##        rolls/buns}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [434] {curd,                                                                                                         
    ##        dessert,                                                                                                      
    ##        pastry}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [435] {curd,                                                                                                         
    ##        dessert,                                                                                                      
    ##        sausage}                   => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [436] {citrus fruit,                                                                                                 
    ##        curd,                                                                                                         
    ##        dessert}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [437] {butter,                                                                                                       
    ##        dessert,                                                                                                      
    ##        soda}                      => {shopping bags}            0.0001336630  1.0000000 0.0001336630  21.015449     2
    ## [438] {butter,                                                                                                       
    ##        dessert,                                                                                                      
    ##        whole milk}                => {shopping bags}            0.0001336630  1.0000000 0.0001336630  21.015449     2
    ## [439] {dessert,                                                                                                      
    ##        shopping bags,                                                                                                
    ##        whole milk}                => {butter}                   0.0001336630  1.0000000 0.0001336630  28.392789     2
    ## [440] {dessert,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        yogurt}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [441] {dessert,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        soda}                      => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [442] {dessert,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [443] {dessert,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [444] {dessert,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [445] {dessert,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [446] {dessert,                                                                                                      
    ##        pastry,                                                                                                       
    ##        rolls/buns}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [447] {dessert,                                                                                                      
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [448] {chocolate,                                                                                                    
    ##        margarine,                                                                                                    
    ##        napkins}                   => {butter}                   0.0001336630  1.0000000 0.0001336630  28.392789     2
    ## [449] {butter,                                                                                                       
    ##        margarine,                                                                                                    
    ##        napkins}                   => {chocolate}                0.0001336630  1.0000000 0.0001336630  42.388102     2
    ## [450] {butter,                                                                                                       
    ##        chocolate,                                                                                                    
    ##        margarine}                 => {napkins}                  0.0001336630  1.0000000 0.0001336630  45.205438     2
    ## [451] {butter,                                                                                                       
    ##        cream cheese,                                                                                                 
    ##        frankfurter}               => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [452] {cream cheese,                                                                                                 
    ##        frankfurter,                                                                                                  
    ##        soda}                      => {butter}                   0.0001336630  1.0000000 0.0001336630  28.392789     2
    ## [453] {chocolate,                                                                                                    
    ##        frozen vegetables,                                                                                            
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [454] {bottled water,                                                                                                
    ##        chocolate,                                                                                                    
    ##        margarine}                 => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [455] {chocolate,                                                                                                    
    ##        margarine,                                                                                                    
    ##        soda}                      => {bottled water}            0.0001336630  1.0000000 0.0001336630  16.479075     2
    ## [456] {bottled water,                                                                                                
    ##        chocolate,                                                                                                    
    ##        soda}                      => {margarine}                0.0001336630  1.0000000 0.0001336630  31.043568     2
    ## [457] {bottled beer,                                                                                                 
    ##        chocolate,                                                                                                    
    ##        sausage}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [458] {chocolate,                                                                                                    
    ##        pip fruit,                                                                                                    
    ##        yogurt}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [459] {chocolate,                                                                                                    
    ##        pastry,                                                                                                       
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [460] {frozen vegetables,                                                                                            
    ##        sausage,                                                                                                      
    ##        white bread}               => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [461] {frozen vegetables,                                                                                            
    ##        root vegetables,                                                                                              
    ##        white bread}               => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [462] {root vegetables,                                                                                              
    ##        sausage,                                                                                                      
    ##        white bread}               => {frozen vegetables}        0.0001336630  1.0000000 0.0001336630  35.711217     2
    ## [463] {beef,                                                                                                         
    ##        frankfurter,                                                                                                  
    ##        white bread}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [464] {beef,                                                                                                         
    ##        rolls/buns,                                                                                                   
    ##        white bread}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [465] {shopping bags,                                                                                                
    ##        white bread,                                                                                                  
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [466] {sausage,                                                                                                      
    ##        white bread,                                                                                                  
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [467] {rolls/buns,                                                                                                   
    ##        sausage,                                                                                                      
    ##        white bread}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [468] {chicken,                                                                                                      
    ##        margarine,                                                                                                    
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [469] {chicken,                                                                                                      
    ##        margarine,                                                                                                    
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [470] {chicken,                                                                                                      
    ##        domestic eggs,                                                                                                
    ##        frankfurter}               => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [471] {chicken,                                                                                                      
    ##        other vegetables,                                                                                             
    ##        root vegetables}           => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [472] {frozen vegetables,                                                                                            
    ##        margarine,                                                                                                    
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [473] {frozen vegetables,                                                                                            
    ##        margarine,                                                                                                    
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [474] {brown bread,                                                                                                  
    ##        frozen vegetables,                                                                                            
    ##        pip fruit}                 => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [475] {frankfurter,                                                                                                  
    ##        frozen vegetables,                                                                                            
    ##        pip fruit}                 => {brown bread}              0.0001336630  1.0000000 0.0001336630  26.577265     2
    ## [476] {brown bread,                                                                                                  
    ##        frozen vegetables,                                                                                            
    ##        pip fruit}                 => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [477] {frankfurter,                                                                                                  
    ##        frozen vegetables,                                                                                            
    ##        pip fruit}                 => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [478] {beef,                                                                                                         
    ##        coffee,                                                                                                       
    ##        other vegetables}          => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [479] {coffee,                                                                                                       
    ##        pork,                                                                                                         
    ##        root vegetables}           => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [480] {coffee,                                                                                                       
    ##        pork,                                                                                                         
    ##        soda}                      => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [481] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        pastry}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [482] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        pastry}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [483] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        sausage}                   => {soda}                     0.0002004946  1.0000000 0.0002004946  10.298004     3
    ## [484] {coffee,                                                                                                       
    ##        sausage,                                                                                                      
    ##        soda}                      => {frankfurter}              0.0002004946  1.0000000 0.0002004946  26.483186     3
    ## [485] {bottled beer,                                                                                                 
    ##        coffee,                                                                                                       
    ##        rolls/buns}                => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [486] {coffee,                                                                                                       
    ##        pastry,                                                                                                       
    ##        root vegetables}           => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [487] {bottled water,                                                                                                
    ##        coffee,                                                                                                       
    ##        soda}                      => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [488] {coffee,                                                                                                       
    ##        root vegetables,                                                                                              
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [489] {curd,                                                                                                         
    ##        margarine,                                                                                                    
    ##        pip fruit}                 => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [490] {curd,                                                                                                         
    ##        margarine,                                                                                                    
    ##        other vegetables}          => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [491] {butter,                                                                                                       
    ##        citrus fruit,                                                                                                 
    ##        margarine}                 => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [492] {butter,                                                                                                       
    ##        margarine,                                                                                                    
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [493] {citrus fruit,                                                                                                 
    ##        margarine,                                                                                                    
    ##        whole milk}                => {butter}                   0.0001336630  1.0000000 0.0001336630  28.392789     2
    ## [494] {domestic eggs,                                                                                                
    ##        frankfurter,                                                                                                  
    ##        margarine}                 => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [495] {brown bread,                                                                                                  
    ##        frankfurter,                                                                                                  
    ##        margarine}                 => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [496] {brown bread,                                                                                                  
    ##        margarine,                                                                                                    
    ##        soda}                      => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [497] {citrus fruit,                                                                                                 
    ##        margarine,                                                                                                    
    ##        sausage}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [498] {citrus fruit,                                                                                                 
    ##        margarine,                                                                                                    
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [499] {citrus fruit,                                                                                                 
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {margarine}                0.0001336630  1.0000000 0.0001336630  31.043568     2
    ## [500] {margarine,                                                                                                    
    ##        other vegetables,                                                                                             
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [501] {beef,                                                                                                         
    ##        curd,                                                                                                         
    ##        rolls/buns}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [502] {beef,                                                                                                         
    ##        bottled beer,                                                                                                 
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [503] {beef,                                                                                                         
    ##        pip fruit,                                                                                                    
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [504] {curd,                                                                                                         
    ##        fruit/vegetable juice,                                                                                        
    ##        tropical fruit}            => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [505] {fruit/vegetable juice,                                                                                        
    ##        newspapers,                                                                                                   
    ##        pastry}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [506] {fruit/vegetable juice,                                                                                        
    ##        newspapers,                                                                                                   
    ##        whole milk}                => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [507] {bottled beer,                                                                                                 
    ##        fruit/vegetable juice,                                                                                        
    ##        sausage}                   => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [508] {bottled beer,                                                                                                 
    ##        fruit/vegetable juice,                                                                                        
    ##        tropical fruit}            => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [509] {citrus fruit,                                                                                                 
    ##        fruit/vegetable juice,                                                                                        
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [510] {curd,                                                                                                         
    ##        newspapers,                                                                                                   
    ##        sausage}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [511] {curd,                                                                                                         
    ##        newspapers,                                                                                                   
    ##        other vegetables}          => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [512] {newspapers,                                                                                                   
    ##        other vegetables,                                                                                             
    ##        sausage}                   => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [513] {curd,                                                                                                         
    ##        pip fruit,                                                                                                    
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [514] {citrus fruit,                                                                                                 
    ##        curd,                                                                                                         
    ##        pastry}                    => {other vegetables}         0.0002004946  1.0000000 0.0002004946   8.189929     3
    ## [515] {citrus fruit,                                                                                                 
    ##        curd,                                                                                                         
    ##        soda}                      => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [516] {curd,                                                                                                         
    ##        soda,                                                                                                         
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [517] {bottled beer,                                                                                                 
    ##        frankfurter,                                                                                                  
    ##        soda}                      => {butter}                   0.0001336630  1.0000000 0.0001336630  28.392789     2
    ## [518] {bottled beer,                                                                                                 
    ##        butter,                                                                                                       
    ##        citrus fruit}              => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [519] {bottled beer,                                                                                                 
    ##        citrus fruit,                                                                                                 
    ##        soda}                      => {butter}                   0.0001336630  1.0000000 0.0001336630  28.392789     2
    ## [520] {bottled beer,                                                                                                 
    ##        butter,                                                                                                       
    ##        root vegetables}           => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [521] {butter,                                                                                                       
    ##        root vegetables,                                                                                              
    ##        sausage}                   => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [522] {butter,                                                                                                       
    ##        canned beer,                                                                                                  
    ##        sausage}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [523] {butter,                                                                                                       
    ##        rolls/buns,                                                                                                   
    ##        shopping bags}             => {soda}                     0.0002004946  1.0000000 0.0002004946  10.298004     3
    ## [524] {butter,                                                                                                       
    ##        citrus fruit,                                                                                                 
    ##        pip fruit}                 => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [525] {citrus fruit,                                                                                                 
    ##        pip fruit,                                                                                                    
    ##        whole milk}                => {butter}                   0.0001336630  1.0000000 0.0001336630  28.392789     2
    ## [526] {butter,                                                                                                       
    ##        pastry,                                                                                                       
    ##        tropical fruit}            => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [527] {canned beer,                                                                                                  
    ##        pork,                                                                                                         
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [528] {pork,                                                                                                         
    ##        sausage,                                                                                                      
    ##        shopping bags}             => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [529] {pork,                                                                                                         
    ##        sausage,                                                                                                      
    ##        shopping bags}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [530] {citrus fruit,                                                                                                 
    ##        pip fruit,                                                                                                    
    ##        pork}                      => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [531] {citrus fruit,                                                                                                 
    ##        pork,                                                                                                         
    ##        soda}                      => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [532] {pork,                                                                                                         
    ##        root vegetables,                                                                                              
    ##        sausage}                   => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [533] {brown bread,                                                                                                  
    ##        domestic eggs,                                                                                                
    ##        frankfurter}               => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [534] {citrus fruit,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        frankfurter}               => {brown bread}              0.0001336630  1.0000000 0.0001336630  26.577265     2
    ## [535] {brown bread,                                                                                                  
    ##        domestic eggs,                                                                                                
    ##        frankfurter}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [536] {citrus fruit,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        whole milk}                => {brown bread}              0.0001336630  1.0000000 0.0001336630  26.577265     2
    ## [537] {bottled beer,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        shopping bags}             => {newspapers}               0.0001336630  1.0000000 0.0001336630  25.709622     2
    ## [538] {citrus fruit,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        frankfurter}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [539] {citrus fruit,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        whole milk}                => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [540] {domestic eggs,                                                                                                
    ##        sausage,                                                                                                      
    ##        shopping bags}             => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [541] {bottled water,                                                                                                
    ##        domestic eggs,                                                                                                
    ##        sausage}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [542] {bottled water,                                                                                                
    ##        domestic eggs,                                                                                                
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [543] {domestic eggs,                                                                                                
    ##        root vegetables,                                                                                              
    ##        whole milk}                => {other vegetables}         0.0002004946  1.0000000 0.0002004946   8.189929     3
    ## [544] {brown bread,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        shopping bags}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [545] {bottled beer,                                                                                                 
    ##        newspapers,                                                                                                   
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [546] {newspapers,                                                                                                   
    ##        pastry,                                                                                                       
    ##        rolls/buns}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [547] {newspapers,                                                                                                   
    ##        rolls/buns,                                                                                                   
    ##        soda}                      => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [548] {bottled water,                                                                                                
    ##        frankfurter,                                                                                                  
    ##        pastry}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [549] {frankfurter,                                                                                                  
    ##        pastry,                                                                                                       
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [550] {frankfurter,                                                                                                  
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [551] {citrus fruit,                                                                                                 
    ##        frankfurter,                                                                                                  
    ##        rolls/buns}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [552] {bottled water,                                                                                                
    ##        frankfurter,                                                                                                  
    ##        sausage}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [553] {bottled beer,                                                                                                 
    ##        citrus fruit,                                                                                                 
    ##        whipped/sour cream}        => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [554] {other vegetables,                                                                                             
    ##        pip fruit,                                                                                                    
    ##        whipped/sour cream}        => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [555] {citrus fruit,                                                                                                 
    ##        rolls/buns,                                                                                                   
    ##        whipped/sour cream}        => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [556] {other vegetables,                                                                                             
    ##        tropical fruit,                                                                                               
    ##        whipped/sour cream}        => {sausage}                  0.0002004946  1.0000000 0.0002004946  16.570321     3
    ## [557] {soda,                                                                                                         
    ##        whipped/sour cream,                                                                                           
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [558] {bottled beer,                                                                                                 
    ##        rolls/buns,                                                                                                   
    ##        shopping bags}             => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [559] {bottled beer,                                                                                                 
    ##        other vegetables,                                                                                             
    ##        shopping bags}             => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [560] {bottled beer,                                                                                                 
    ##        pastry,                                                                                                       
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [561] {canned beer,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        tropical fruit}            => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [562] {canned beer,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [563] {canned beer,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        yogurt}                    => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [564] {canned beer,                                                                                                  
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [565] {citrus fruit,                                                                                                 
    ##        shopping bags,                                                                                                
    ##        yogurt}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [566] {citrus fruit,                                                                                                 
    ##        pip fruit,                                                                                                    
    ##        soda}                      => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [567] {citrus fruit,                                                                                                 
    ##        pastry,                                                                                                       
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [568] {pastry,                                                                                                       
    ##        root vegetables,                                                                                              
    ##        sausage}                   => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [569] {pastry,                                                                                                       
    ##        rolls/buns,                                                                                                   
    ##        sausage}                   => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [570] {other vegetables,                                                                                             
    ##        pastry,                                                                                                       
    ##        soda}                      => {whole milk}               0.0003341576  0.8333333 0.0004009891   5.276837     5
    ## [571] {bottled water,                                                                                                
    ##        citrus fruit,                                                                                                 
    ##        tropical fruit}            => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [572] {citrus fruit,                                                                                                 
    ##        other vegetables,                                                                                             
    ##        tropical fruit}            => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [573] {rolls/buns,                                                                                                   
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {sausage}                  0.0002673261  0.8000000 0.0003341576  13.256257     4
    ## [574] {other vegetables,                                                                                             
    ##        prosecco,                                                                                                     
    ##        sausage,                                                                                                      
    ##        waffles}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [575] {prosecco,                                                                                                     
    ##        sausage,                                                                                                      
    ##        waffles,                                                                                                      
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [576] {other vegetables,                                                                                             
    ##        prosecco,                                                                                                     
    ##        waffles,                                                                                                      
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [577] {other vegetables,                                                                                             
    ##        prosecco,                                                                                                     
    ##        sausage,                                                                                                      
    ##        whole milk}                => {waffles}                  0.0001336630  1.0000000 0.0001336630  54.018051     2
    ## [578] {cake bar,                                                                                                     
    ##        curd,                                                                                                         
    ##        rolls/buns,                                                                                                   
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [579] {cake bar,                                                                                                     
    ##        curd,                                                                                                         
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [580] {cake bar,                                                                                                     
    ##        curd,                                                                                                         
    ##        rolls/buns,                                                                                                   
    ##        whole milk}                => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [581] {cake bar,                                                                                                     
    ##        rolls/buns,                                                                                                   
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [582] {curd,                                                                                                         
    ##        rolls/buns,                                                                                                   
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {cake bar}                 0.0001336630  1.0000000 0.0001336630 162.641304     2
    ## [583] {misc. beverages,                                                                                              
    ##        other vegetables,                                                                                             
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [584] {misc. beverages,                                                                                              
    ##        sausage,                                                                                                      
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [585] {misc. beverages,                                                                                              
    ##        other vegetables,                                                                                             
    ##        sausage,                                                                                                      
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [586] {misc. beverages,                                                                                              
    ##        other vegetables,                                                                                             
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [587] {citrus fruit,                                                                                                 
    ##        curd,                                                                                                         
    ##        pastry,                                                                                                       
    ##        specialty chocolate}       => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [588] {curd,                                                                                                         
    ##        other vegetables,                                                                                             
    ##        pastry,                                                                                                       
    ##        specialty chocolate}       => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [589] {citrus fruit,                                                                                                 
    ##        curd,                                                                                                         
    ##        other vegetables,                                                                                             
    ##        specialty chocolate}       => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [590] {citrus fruit,                                                                                                 
    ##        other vegetables,                                                                                             
    ##        pastry,                                                                                                       
    ##        specialty chocolate}       => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [591] {citrus fruit,                                                                                                 
    ##        frozen vegetables,                                                                                            
    ##        ham,                                                                                                          
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [592] {citrus fruit,                                                                                                 
    ##        frozen vegetables,                                                                                            
    ##        ham,                                                                                                          
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [593] {frozen vegetables,                                                                                            
    ##        ham,                                                                                                          
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [594] {citrus fruit,                                                                                                 
    ##        ham,                                                                                                          
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {frozen vegetables}        0.0001336630  1.0000000 0.0001336630  35.711217     2
    ## [595] {citrus fruit,                                                                                                 
    ##        frozen vegetables,                                                                                            
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {ham}                      0.0001336630  1.0000000 0.0001336630  58.449219     2
    ## [596] {butter milk,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [597] {butter milk,                                                                                                  
    ##        sausage,                                                                                                      
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [598] {butter milk,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        sausage,                                                                                                      
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [599] {butter milk,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [600] {frozen meals,                                                                                                 
    ##        margarine,                                                                                                    
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [601] {frozen meals,                                                                                                 
    ##        margarine,                                                                                                    
    ##        other vegetables,                                                                                             
    ##        sausage}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [602] {frozen meals,                                                                                                 
    ##        margarine,                                                                                                    
    ##        other vegetables,                                                                                             
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [603] {frozen meals,                                                                                                 
    ##        other vegetables,                                                                                             
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {margarine}                0.0001336630  1.0000000 0.0001336630  31.043568     2
    ## [604] {margarine,                                                                                                    
    ##        other vegetables,                                                                                             
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {frozen meals}             0.0001336630  1.0000000 0.0001336630  59.613546     2
    ## [605] {onions,                                                                                                       
    ##        root vegetables,                                                                                              
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [606] {root vegetables,                                                                                              
    ##        tropical fruit,                                                                                               
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {onions}                   0.0001336630  1.0000000 0.0001336630  49.382838     2
    ## [607] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        hamburger meat,                                                                                               
    ##        root vegetables}           => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [608] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        hamburger meat,                                                                                               
    ##        soda}                      => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [609] {coffee,                                                                                                       
    ##        hamburger meat,                                                                                               
    ##        root vegetables,                                                                                              
    ##        soda}                      => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [610] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        root vegetables,                                                                                              
    ##        soda}                      => {hamburger meat}           0.0001336630  1.0000000 0.0001336630  45.758410     2
    ## [611] {dessert,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        soda,                                                                                                         
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [612] {dessert,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [613] {dessert,                                                                                                      
    ##        pip fruit,                                                                                                    
    ##        soda,                                                                                                         
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [614] {pip fruit,                                                                                                    
    ##        soda,                                                                                                         
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {dessert}                  0.0001336630  1.0000000 0.0001336630  42.388102     2
    ## [615] {brown bread,                                                                                                  
    ##        canned beer,                                                                                                  
    ##        frankfurter,                                                                                                  
    ##        frozen vegetables}         => {pip fruit}                0.0001336630  1.0000000 0.0001336630  20.385559     2
    ## [616] {brown bread,                                                                                                  
    ##        frankfurter,                                                                                                  
    ##        frozen vegetables,                                                                                            
    ##        pip fruit}                 => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [617] {brown bread,                                                                                                  
    ##        canned beer,                                                                                                  
    ##        frozen vegetables,                                                                                            
    ##        pip fruit}                 => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [618] {canned beer,                                                                                                  
    ##        frankfurter,                                                                                                  
    ##        frozen vegetables,                                                                                            
    ##        pip fruit}                 => {brown bread}              0.0001336630  1.0000000 0.0001336630  26.577265     2
    ## [619] {brown bread,                                                                                                  
    ##        canned beer,                                                                                                  
    ##        frankfurter,                                                                                                  
    ##        pip fruit}                 => {frozen vegetables}        0.0001336630  1.0000000 0.0001336630  35.711217     2
    ## [620] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        pastry,                                                                                                       
    ##        sausage}                   => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [621] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        pastry,                                                                                                       
    ##        soda}                      => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [622] {coffee,                                                                                                       
    ##        pastry,                                                                                                       
    ##        sausage,                                                                                                      
    ##        soda}                      => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [623] {frankfurter,                                                                                                  
    ##        pastry,                                                                                                       
    ##        sausage,                                                                                                      
    ##        soda}                      => {coffee}                   0.0001336630  1.0000000 0.0001336630  31.634249     2
    ## [624] {curd,                                                                                                         
    ##        sausage,                                                                                                      
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [625] {curd,                                                                                                         
    ##        rolls/buns,                                                                                                   
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [626] {pork,                                                                                                         
    ##        sausage,                                                                                                      
    ##        shopping bags,                                                                                                
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [627] {pork,                                                                                                         
    ##        sausage,                                                                                                      
    ##        shopping bags,                                                                                                
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [628] {pork,                                                                                                         
    ##        shopping bags,                                                                                                
    ##        soda,                                                                                                         
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [629] {pork,                                                                                                         
    ##        sausage,                                                                                                      
    ##        soda,                                                                                                         
    ##        yogurt}                    => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [630] {pork,                                                                                                         
    ##        soda,                                                                                                         
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {sausage}                  0.0002004946  1.0000000 0.0002004946  16.570321     3
    ## [631] {pork,                                                                                                         
    ##        rolls/buns,                                                                                                   
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [632] {pork,                                                                                                         
    ##        rolls/buns,                                                                                                   
    ##        sausage,                                                                                                      
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [633] {brown bread,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        frankfurter}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [634] {brown bread,                                                                                                  
    ##        domestic eggs,                                                                                                
    ##        frankfurter,                                                                                                  
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [635] {brown bread,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        whole milk}                => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [636] {citrus fruit,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        frankfurter,                                                                                                  
    ##        whole milk}                => {brown bread}              0.0001336630  1.0000000 0.0001336630  26.577265     2
    ## [637] {brown bread,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        frankfurter,                                                                                                  
    ##        whole milk}                => {domestic eggs}            0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [638] {citrus fruit,                                                                                                 
    ##        rolls/buns,                                                                                                   
    ##        whipped/sour cream,                                                                                           
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [639] {citrus fruit,                                                                                                 
    ##        whipped/sour cream,                                                                                           
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [640] {rolls/buns,                                                                                                   
    ##        whipped/sour cream,                                                                                           
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [641] {citrus fruit,                                                                                                 
    ##        rolls/buns,                                                                                                   
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {whipped/sour cream}       0.0001336630  1.0000000 0.0001336630  22.879205     2
    ## [642] {canned beer,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [643] {canned beer,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [644] {other vegetables,                                                                                             
    ##        pastry,                                                                                                       
    ##        sausage,                                                                                                      
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [645] {other vegetables,                                                                                             
    ##        pastry,                                                                                                       
    ##        sausage,                                                                                                      
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [646] {citrus fruit,                                                                                                 
    ##        other vegetables,                                                                                             
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [647] {citrus fruit,                                                                                                 
    ##        other vegetables,                                                                                             
    ##        whole milk,                                                                                                   
    ##        yogurt}                    => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2

### To view the top 10 rules

``` r
inspect(association_rules[1:10])
```

    ##      lhs                                 rhs                support    
    ## [1]  {domestic eggs, rubbing alcohol} => {frankfurter}      0.000133663
    ## [2]  {frankfurter, rubbing alcohol}   => {domestic eggs}    0.000133663
    ## [3]  {soap, tropical fruit}           => {whole milk}       0.000133663
    ## [4]  {soap, whole milk}               => {tropical fruit}   0.000133663
    ## [5]  {domestic eggs, skin care}       => {other vegetables} 0.000133663
    ## [6]  {bottled water, cookware}        => {canned beer}      0.000133663
    ## [7]  {frankfurter, potato products}   => {other vegetables} 0.000133663
    ## [8]  {syrup, tropical fruit}          => {whole milk}       0.000133663
    ## [9]  {ice cream, prosecco}            => {other vegetables} 0.000133663
    ## [10] {prosecco, waffles}              => {sausage}          0.000133663
    ##      confidence coverage    lift      count
    ## [1]  1          0.000133663 26.483186 2    
    ## [2]  1          0.000133663 26.960360 2    
    ## [3]  1          0.000133663  6.332205 2    
    ## [4]  1          0.000133663 14.756410 2    
    ## [5]  1          0.000133663  8.189929 2    
    ## [6]  1          0.000133663 21.314815 2    
    ## [7]  1          0.000133663  8.189929 2    
    ## [8]  1          0.000133663  6.332205 2    
    ## [9]  1          0.000133663  8.189929 2    
    ## [10] 1          0.000133663 16.570321 2

``` r
plot(association_rules)
```

    ## To reduce overplotting, jitter is added! Use jitter = 0 to prevent jitter.

![](Lab7c_Submission_files/figure-gfm/Code%2015-1.png)<!-- -->

## Remove redundant rules

We can remove the redundant rules as follows:

``` r
subset_rules <-
  which(colSums(is.subset(association_rules,
                          association_rules)) > 1)
length(subset_rules)
```

    ## [1] 407

``` r
association_rules_no_reps <- association_rules[-subset_rules]

# This results in 240 non-redundant rules (instead of the initial 647 rules)
summary(association_rules_no_reps)
```

    ## set of 240 rules
    ## 
    ## rule length distribution (lhs + rhs):sizes
    ##   3   4 
    ## 117 123 
    ## 
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   3.000   3.000   4.000   3.513   4.000   4.000 
    ## 
    ## summary of quality measures:
    ##     support            confidence        coverage              lift        
    ##  Min.   :0.0001337   Min.   :0.8000   Min.   :0.0001337   Min.   :  5.066  
    ##  1st Qu.:0.0001337   1st Qu.:1.0000   1st Qu.:0.0001337   1st Qu.:  6.332  
    ##  Median :0.0001337   Median :1.0000   Median :0.0001337   Median :  9.091  
    ##  Mean   :0.0001409   Mean   :0.9968   Mean   :0.0001420   Mean   : 12.789  
    ##  3rd Qu.:0.0001337   3rd Qu.:1.0000   3rd Qu.:0.0001337   3rd Qu.: 15.187  
    ##  Max.   :0.0003342   Max.   :1.0000   Max.   :0.0004010   Max.   :152.684  
    ##      count      
    ##  Min.   :2.000  
    ##  1st Qu.:2.000  
    ##  Median :2.000  
    ##  Mean   :2.108  
    ##  3rd Qu.:2.000  
    ##  Max.   :5.000  
    ## 
    ## mining info:
    ##        data ntransactions support confidence
    ##  tr_grocery         14963   1e-04        0.8
    ##                                                                                          call
    ##  apriori(data = tr_grocery, parameter = list(support = 1e-04, confidence = 0.8, maxlen = 10))

``` r
inspect(association_rules_no_reps)
```

    ##       lhs                            rhs                             support confidence     coverage       lift count
    ## [1]   {domestic eggs,                                                                                                
    ##        skin care}                 => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [2]   {bottled water,                                                                                                
    ##        cookware}                  => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [3]   {frankfurter,                                                                                                  
    ##        potato products}           => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [4]   {syrup,                                                                                                        
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [5]   {ice cream,                                                                                                    
    ##        prosecco}                  => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [6]   {prosecco,                                                                                                     
    ##        waffles}                   => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [7]   {prosecco,                                                                                                     
    ##        waffles}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [8]   {prosecco,                                                                                                     
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [9]   {prosecco,                                                                                                     
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [10]  {canned fruit,                                                                                                 
    ##        sausage}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [11]  {newspapers,                                                                                                   
    ##        nut snack}                 => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [12]  {nut snack,                                                                                                    
    ##        other vegetables}          => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [13]  {jam,                                                                                                          
    ##        pip fruit}                 => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [14]  {cereals,                                                                                                      
    ##        packaged fruit/vegetables} => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [15]  {artif. sweetener,                                                                                             
    ##        bottled water}             => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [16]  {dental care,                                                                                                  
    ##        napkins}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [17]  {dental care,                                                                                                  
    ##        pip fruit}                 => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [18]  {brown bread,                                                                                                  
    ##        sauces}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [19]  {shopping bags,                                                                                                
    ##        spices}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [20]  {softener,                                                                                                     
    ##        vinegar}                   => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [21]  {softener,                                                                                                     
    ##        vinegar}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [22]  {pip fruit,                                                                                                    
    ##        softener}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [23]  {house keeping products,                                                                                       
    ##        semi-finished bread}       => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [24]  {house keeping products,                                                                                       
    ##        margarine}                 => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [25]  {canned beer,                                                                                                  
    ##        house keeping products}    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [26]  {bottled water,                                                                                                
    ##        house keeping products}    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [27]  {house keeping products,                                                                                       
    ##        other vegetables}          => {whole milk}               0.0002673261  1.0000000 0.0002673261   6.332205     4
    ## [28]  {citrus fruit,                                                                                                 
    ##        soups}                     => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [29]  {ice cream,                                                                                                    
    ##        popcorn}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [30]  {oil,                                                                                                          
    ##        popcorn}                   => {pork}                     0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [31]  {sausage,                                                                                                      
    ##        vinegar}                   => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [32]  {canned beer,                                                                                                  
    ##        Instant food products}     => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [33]  {chocolate marshmallow,                                                                                        
    ##        sugar}                     => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [34]  {chocolate marshmallow,                                                                                        
    ##        domestic eggs}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [35]  {frankfurter,                                                                                                  
    ##        liver loaf}                => {condensed milk}           0.0001336630  1.0000000 0.0001336630 152.683673     2
    ## [36]  {liver loaf,                                                                                                   
    ##        sausage}                   => {white bread}              0.0001336630  1.0000000 0.0001336630  41.679666     2
    ## [37]  {liver loaf,                                                                                                   
    ##        shopping bags}             => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [38]  {berries,                                                                                                      
    ##        zwieback}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [39]  {frankfurter,                                                                                                  
    ##        zwieback}                  => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [40]  {flower (seeds),                                                                                               
    ##        pork}                      => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [41]  {candles,                                                                                                      
    ##        white bread}               => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [42]  {candles,                                                                                                      
    ##        curd}                      => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [43]  {finished products,                                                                                            
    ##        onions}                    => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [44]  {chocolate,                                                                                                    
    ##        finished products}         => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [45]  {chocolate,                                                                                                    
    ##        finished products}         => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [46]  {curd,                                                                                                         
    ##        finished products}         => {whipped/sour cream}       0.0001336630  1.0000000 0.0001336630  22.879205     2
    ## [47]  {butter,                                                                                                       
    ##        finished products}         => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [48]  {fruit/vegetable juice,                                                                                        
    ##        specialty cheese}          => {long life bakery product} 0.0001336630  1.0000000 0.0001336630  55.832090     2
    ## [49]  {frozen potato products,                                                                                       
    ##        UHT-milk}                  => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [50]  {dog food,                                                                                                     
    ##        sliced cheese}             => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [51]  {dog food,                                                                                                     
    ##        fruit/vegetable juice}     => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [52]  {dog food,                                                                                                     
    ##        fruit/vegetable juice}     => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [53]  {cling film/bags,                                                                                              
    ##        newspapers}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [54]  {cling film/bags,                                                                                              
    ##        shopping bags}             => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [55]  {mayonnaise,                                                                                                   
    ##        oil}                       => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [56]  {mayonnaise,                                                                                                   
    ##        newspapers}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [57]  {mayonnaise,                                                                                                   
    ##        pip fruit}                 => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [58]  {curd,                                                                                                         
    ##        pet care}                  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [59]  {specialty chocolate,                                                                                          
    ##        sweet spreads}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [60]  {butter milk,                                                                                                  
    ##        sweet spreads}             => {berries}                  0.0001336630  1.0000000 0.0001336630  45.898773     2
    ## [61]  {napkins,                                                                                                      
    ##        sweet spreads}             => {chocolate}                0.0001336630  1.0000000 0.0001336630  42.388102     2
    ## [62]  {canned vegetables,                                                                                            
    ##        domestic eggs}             => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [63]  {bottled beer,                                                                                                 
    ##        salt}                      => {misc. beverages}          0.0001336630  1.0000000 0.0001336630  63.402542     2
    ## [64]  {ham,                                                                                                          
    ##        turkey}                    => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [65]  {ham,                                                                                                          
    ##        turkey}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [66]  {beef,                                                                                                         
    ##        turkey}                    => {shopping bags}            0.0001336630  1.0000000 0.0001336630  21.015449     2
    ## [67]  {pork,                                                                                                         
    ##        turkey}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [68]  {pork,                                                                                                         
    ##        turkey}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [69]  {citrus fruit,                                                                                                 
    ##        turkey}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [70]  {hamburger meat,                                                                                               
    ##        mustard}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [71]  {cake bar,                                                                                                     
    ##        frozen vegetables}         => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [72]  {frozen dessert,                                                                                               
    ##        pip fruit}                 => {pork}                     0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [73]  {flour,                                                                                                        
    ##        liquor}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [74]  {flour,                                                                                                        
    ##        liquor}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [75]  {frankfurter,                                                                                                  
    ##        liquor}                    => {bottled water}            0.0001336630  1.0000000 0.0001336630  16.479075     2
    ## [76]  {frozen fish,                                                                                                  
    ##        napkins}                   => {frankfurter}              0.0001336630  1.0000000 0.0001336630  26.483186     2
    ## [77]  {frozen meals,                                                                                                 
    ##        spread cheese}             => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [78]  {frozen meals,                                                                                                 
    ##        spread cheese}             => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [79]  {spread cheese,                                                                                                
    ##        UHT-milk}                  => {root vegetables}          0.0001336630  1.0000000 0.0001336630  14.373679     2
    ## [80]  {frankfurter,                                                                                                  
    ##        spread cheese}             => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [81]  {canned beer,                                                                                                  
    ##        spread cheese}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [82]  {condensed milk,                                                                                               
    ##        pip fruit}                 => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [83]  {canned fish,                                                                                                  
    ##        pasta}                     => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [84]  {canned fish,                                                                                                  
    ##        chocolate}                 => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [85]  {hygiene articles,                                                                                             
    ##        pot plants}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [86]  {pork,                                                                                                         
    ##        pot plants}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [87]  {baking powder,                                                                                                
    ##        specialty bar}             => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [88]  {baking powder,                                                                                                
    ##        sliced cheese}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [89]  {pickled vegetables,                                                                                           
    ##        processed cheese}          => {bottled water}            0.0001336630  1.0000000 0.0001336630  16.479075     2
    ## [90]  {detergent,                                                                                                    
    ##        oil}                       => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [91]  {cream cheese,                                                                                                 
    ##        detergent}                 => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [92]  {citrus fruit,                                                                                                 
    ##        detergent}                 => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [93]  {cat food,                                                                                                     
    ##        dishes}                    => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [94]  {fruit/vegetable juice,                                                                                        
    ##        semi-finished bread}       => {rolls/buns}               0.0002673261  0.8000000 0.0003341576   7.272418     4
    ## [95]  {flour,                                                                                                        
    ##        salty snack}               => {bottled water}            0.0001336630  1.0000000 0.0001336630  16.479075     2
    ## [96]  {flour,                                                                                                        
    ##        margarine}                 => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [97]  {butter,                                                                                                       
    ##        processed cheese}          => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [98]  {pastry,                                                                                                       
    ##        processed cheese}          => {whole milk}               0.0002673261  0.8000000 0.0003341576   5.065764     4
    ## [99]  {soft cheese,                                                                                                  
    ##        specialty bar}             => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [100] {cat food,                                                                                                     
    ##        long life bakery product}  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [101] {chewing gum,                                                                                                  
    ##        white bread}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [102] {coffee,                                                                                                       
    ##        specialty bar}             => {shopping bags}            0.0001336630  1.0000000 0.0001336630  21.015449     2
    ## [103] {hygiene articles,                                                                                             
    ##        misc. beverages}           => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [104] {frozen meals,                                                                                                 
    ##        hygiene articles}          => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [105] {frozen meals,                                                                                                 
    ##        hygiene articles}          => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [106] {hygiene articles,                                                                                             
    ##        salty snack}               => {curd}                     0.0001336630  1.0000000 0.0001336630  29.688492     2
    ## [107] {butter milk,                                                                                                  
    ##        candy}                     => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [108] {beverages,                                                                                                    
    ##        ice cream}                 => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [109] {fruit/vegetable juice,                                                                                        
    ##        grapes}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [110] {oil,                                                                                                          
    ##        specialty chocolate}       => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [111] {ham,                                                                                                          
    ##        oil}                       => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [112] {hard cheese,                                                                                                  
    ##        specialty chocolate}       => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [113] {beverages,                                                                                                    
    ##        hard cheese}               => {fruit/vegetable juice}    0.0001336630  1.0000000 0.0001336630  29.396857     2
    ## [114] {berries,                                                                                                      
    ##        specialty chocolate}       => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [115] {ham,                                                                                                          
    ##        salty snack}               => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [116] {ham,                                                                                                          
    ##        pip fruit}                 => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [117] {hamburger meat,                                                                                               
    ##        long life bakery product}  => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [118] {dishes,                                                                                                       
    ##        whipped/sour cream,                                                                                           
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [119] {sausage,                                                                                                      
    ##        semi-finished bread,                                                                                          
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [120] {flour,                                                                                                        
    ##        specialty chocolate,                                                                                          
    ##        whipped/sour cream}        => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [121] {bottled water,                                                                                                
    ##        specialty bar,                                                                                                
    ##        whole milk}                => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [122] {canned beer,                                                                                                  
    ##        curd,                                                                                                         
    ##        hygiene articles}          => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [123] {canned beer,                                                                                                  
    ##        hygiene articles,                                                                                             
    ##        soda}                      => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [124] {pastry,                                                                                                       
    ##        sliced cheese,                                                                                                
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [125] {candy,                                                                                                        
    ##        citrus fruit,                                                                                                 
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [126] {oil,                                                                                                          
    ##        pork,                                                                                                         
    ##        root vegetables}           => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [127] {misc. beverages,                                                                                              
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [128] {curd,                                                                                                         
    ##        hard cheese,                                                                                                  
    ##        sausage}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [129] {curd,                                                                                                         
    ##        hard cheese,                                                                                                  
    ##        root vegetables}           => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [130] {hard cheese,                                                                                                  
    ##        other vegetables,                                                                                             
    ##        pip fruit}                 => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [131] {hard cheese,                                                                                                  
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [132] {chicken,                                                                                                      
    ##        specialty chocolate,                                                                                          
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [133] {specialty chocolate,                                                                                          
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [134] {beverages,                                                                                                    
    ##        canned beer,                                                                                                  
    ##        whole milk}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [135] {canned beer,                                                                                                  
    ##        ham,                                                                                                          
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [136] {ham,                                                                                                          
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [137] {ham,                                                                                                          
    ##        other vegetables,                                                                                             
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [138] {butter milk,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        white bread}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [139] {butter milk,                                                                                                  
    ##        canned beer,                                                                                                  
    ##        sausage}                   => {yogurt}                   0.0002004946  1.0000000 0.0002004946  11.644358     3
    ## [140] {butter milk,                                                                                                  
    ##        canned beer,                                                                                                  
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [141] {butter milk,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        sausage}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [142] {butter milk,                                                                                                  
    ##        rolls/buns,                                                                                                   
    ##        sausage}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [143] {frozen meals,                                                                                                 
    ##        margarine,                                                                                                    
    ##        sausage}                   => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [144] {frozen meals,                                                                                                 
    ##        margarine,                                                                                                    
    ##        sausage}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [145] {margarine,                                                                                                    
    ##        other vegetables,                                                                                             
    ##        yogurt}                    => {frozen meals}             0.0001336630  1.0000000 0.0001336630  59.613546     2
    ## [146] {bottled water,                                                                                                
    ##        curd,                                                                                                         
    ##        frozen meals}              => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [147] {bottled water,                                                                                                
    ##        frozen meals,                                                                                                 
    ##        rolls/buns}                => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [148] {frozen meals,                                                                                                 
    ##        sausage,                                                                                                      
    ##        tropical fruit}            => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [149] {long life bakery product,                                                                                     
    ##        other vegetables,                                                                                             
    ##        rolls/buns}                => {domestic eggs}            0.0001336630  1.0000000 0.0001336630  26.960360     2
    ## [150] {sausage,                                                                                                      
    ##        tropical fruit,                                                                                               
    ##        waffles}                   => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [151] {other vegetables,                                                                                             
    ##        root vegetables,                                                                                              
    ##        waffles}                   => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [152] {pip fruit,                                                                                                    
    ##        root vegetables,                                                                                              
    ##        waffles}                   => {tropical fruit}           0.0001336630  1.0000000 0.0001336630  14.756410     2
    ## [153] {bottled beer,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        salty snack}               => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [154] {onions,                                                                                                       
    ##        sausage,                                                                                                      
    ##        whipped/sour cream}        => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [155] {onions,                                                                                                       
    ##        rolls/buns,                                                                                                   
    ##        whipped/sour cream}        => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [156] {berries,                                                                                                      
    ##        fruit/vegetable juice,                                                                                        
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [157] {hamburger meat,                                                                                               
    ##        other vegetables,                                                                                             
    ##        white bread}               => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [158] {hamburger meat,                                                                                               
    ##        soda,                                                                                                         
    ##        whole milk}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [159] {hamburger meat,                                                                                               
    ##        rolls/buns,                                                                                                   
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [160] {hamburger meat,                                                                                               
    ##        other vegetables,                                                                                             
    ##        rolls/buns}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [161] {citrus fruit,                                                                                                 
    ##        curd,                                                                                                         
    ##        dessert}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [162] {butter,                                                                                                       
    ##        dessert,                                                                                                      
    ##        soda}                      => {shopping bags}            0.0001336630  1.0000000 0.0001336630  21.015449     2
    ## [163] {dessert,                                                                                                      
    ##        pastry,                                                                                                       
    ##        rolls/buns}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [164] {dessert,                                                                                                      
    ##        sausage,                                                                                                      
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [165] {chocolate,                                                                                                    
    ##        frozen vegetables,                                                                                            
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [166] {bottled beer,                                                                                                 
    ##        chocolate,                                                                                                    
    ##        sausage}                   => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [167] {chocolate,                                                                                                    
    ##        pip fruit,                                                                                                    
    ##        yogurt}                    => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [168] {chocolate,                                                                                                    
    ##        pastry,                                                                                                       
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [169] {beef,                                                                                                         
    ##        frankfurter,                                                                                                  
    ##        white bread}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [170] {beef,                                                                                                         
    ##        rolls/buns,                                                                                                   
    ##        white bread}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [171] {shopping bags,                                                                                                
    ##        white bread,                                                                                                  
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [172] {sausage,                                                                                                      
    ##        white bread,                                                                                                  
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [173] {rolls/buns,                                                                                                   
    ##        sausage,                                                                                                      
    ##        white bread}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [174] {chicken,                                                                                                      
    ##        domestic eggs,                                                                                                
    ##        frankfurter}               => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [175] {chicken,                                                                                                      
    ##        other vegetables,                                                                                             
    ##        root vegetables}           => {bottled beer}             0.0001336630  1.0000000 0.0001336630  22.069322     2
    ## [176] {brown bread,                                                                                                  
    ##        frozen vegetables,                                                                                            
    ##        pip fruit}                 => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [177] {frankfurter,                                                                                                  
    ##        frozen vegetables,                                                                                            
    ##        pip fruit}                 => {canned beer}              0.0001336630  1.0000000 0.0001336630  21.314815     2
    ## [178] {beef,                                                                                                         
    ##        coffee,                                                                                                       
    ##        other vegetables}          => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [179] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        pastry}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [180] {coffee,                                                                                                       
    ##        frankfurter,                                                                                                  
    ##        pastry}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [181] {bottled beer,                                                                                                 
    ##        coffee,                                                                                                       
    ##        rolls/buns}                => {pastry}                   0.0001336630  1.0000000 0.0001336630  19.332041     2
    ## [182] {coffee,                                                                                                       
    ##        pastry,                                                                                                       
    ##        root vegetables}           => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [183] {bottled water,                                                                                                
    ##        coffee,                                                                                                       
    ##        soda}                      => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [184] {coffee,                                                                                                       
    ##        root vegetables,                                                                                              
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [185] {curd,                                                                                                         
    ##        margarine,                                                                                                    
    ##        pip fruit}                 => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [186] {curd,                                                                                                         
    ##        margarine,                                                                                                    
    ##        other vegetables}          => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [187] {domestic eggs,                                                                                                
    ##        frankfurter,                                                                                                  
    ##        margarine}                 => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [188] {margarine,                                                                                                    
    ##        other vegetables,                                                                                             
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [189] {beef,                                                                                                         
    ##        curd,                                                                                                         
    ##        rolls/buns}                => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [190] {beef,                                                                                                         
    ##        bottled beer,                                                                                                 
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [191] {beef,                                                                                                         
    ##        pip fruit,                                                                                                    
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [192] {curd,                                                                                                         
    ##        fruit/vegetable juice,                                                                                        
    ##        tropical fruit}            => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [193] {citrus fruit,                                                                                                 
    ##        fruit/vegetable juice,                                                                                        
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [194] {curd,                                                                                                         
    ##        pip fruit,                                                                                                    
    ##        yogurt}                    => {sausage}                  0.0001336630  1.0000000 0.0001336630  16.570321     2
    ## [195] {citrus fruit,                                                                                                 
    ##        curd,                                                                                                         
    ##        pastry}                    => {other vegetables}         0.0002004946  1.0000000 0.0002004946   8.189929     3
    ## [196] {citrus fruit,                                                                                                 
    ##        curd,                                                                                                         
    ##        soda}                      => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [197] {curd,                                                                                                         
    ##        soda,                                                                                                         
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [198] {bottled beer,                                                                                                 
    ##        frankfurter,                                                                                                  
    ##        soda}                      => {butter}                   0.0001336630  1.0000000 0.0001336630  28.392789     2
    ## [199] {butter,                                                                                                       
    ##        canned beer,                                                                                                  
    ##        sausage}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [200] {butter,                                                                                                       
    ##        rolls/buns,                                                                                                   
    ##        shopping bags}             => {soda}                     0.0002004946  1.0000000 0.0002004946  10.298004     3
    ## [201] {butter,                                                                                                       
    ##        pastry,                                                                                                       
    ##        tropical fruit}            => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [202] {canned beer,                                                                                                  
    ##        pork,                                                                                                         
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [203] {pork,                                                                                                         
    ##        sausage,                                                                                                      
    ##        shopping bags}             => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [204] {pork,                                                                                                         
    ##        sausage,                                                                                                      
    ##        shopping bags}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [205] {citrus fruit,                                                                                                 
    ##        pip fruit,                                                                                                    
    ##        pork}                      => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [206] {citrus fruit,                                                                                                 
    ##        pork,                                                                                                         
    ##        soda}                      => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [207] {pork,                                                                                                         
    ##        root vegetables,                                                                                              
    ##        sausage}                   => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [208] {brown bread,                                                                                                  
    ##        domestic eggs,                                                                                                
    ##        frankfurter}               => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [209] {citrus fruit,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        whole milk}                => {brown bread}              0.0001336630  1.0000000 0.0001336630  26.577265     2
    ## [210] {bottled beer,                                                                                                 
    ##        domestic eggs,                                                                                                
    ##        shopping bags}             => {newspapers}               0.0001336630  1.0000000 0.0001336630  25.709622     2
    ## [211] {domestic eggs,                                                                                                
    ##        sausage,                                                                                                      
    ##        shopping bags}             => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [212] {bottled water,                                                                                                
    ##        domestic eggs,                                                                                                
    ##        sausage}                   => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [213] {bottled water,                                                                                                
    ##        domestic eggs,                                                                                                
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [214] {domestic eggs,                                                                                                
    ##        root vegetables,                                                                                              
    ##        whole milk}                => {other vegetables}         0.0002004946  1.0000000 0.0002004946   8.189929     3
    ## [215] {brown bread,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        shopping bags}             => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [216] {bottled beer,                                                                                                 
    ##        newspapers,                                                                                                   
    ##        yogurt}                    => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [217] {bottled water,                                                                                                
    ##        frankfurter,                                                                                                  
    ##        pastry}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [218] {frankfurter,                                                                                                  
    ##        pastry,                                                                                                       
    ##        whole milk}                => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [219] {frankfurter,                                                                                                  
    ##        tropical fruit,                                                                                               
    ##        whole milk}                => {citrus fruit}             0.0001336630  1.0000000 0.0001336630  18.821384     2
    ## [220] {citrus fruit,                                                                                                 
    ##        frankfurter,                                                                                                  
    ##        rolls/buns}                => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [221] {bottled water,                                                                                                
    ##        frankfurter,                                                                                                  
    ##        sausage}                   => {other vegetables}         0.0001336630  1.0000000 0.0001336630   8.189929     2
    ## [222] {bottled beer,                                                                                                 
    ##        citrus fruit,                                                                                                 
    ##        whipped/sour cream}        => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [223] {other vegetables,                                                                                             
    ##        pip fruit,                                                                                                    
    ##        whipped/sour cream}        => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [224] {citrus fruit,                                                                                                 
    ##        rolls/buns,                                                                                                   
    ##        whipped/sour cream}        => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [225] {other vegetables,                                                                                             
    ##        tropical fruit,                                                                                               
    ##        whipped/sour cream}        => {sausage}                  0.0002004946  1.0000000 0.0002004946  16.570321     3
    ## [226] {soda,                                                                                                         
    ##        whipped/sour cream,                                                                                           
    ##        yogurt}                    => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [227] {bottled beer,                                                                                                 
    ##        pastry,                                                                                                       
    ##        whole milk}                => {rolls/buns}               0.0001336630  1.0000000 0.0001336630   9.090522     2
    ## [228] {canned beer,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        tropical fruit}            => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [229] {canned beer,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        tropical fruit}            => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [230] {canned beer,                                                                                                  
    ##        citrus fruit,                                                                                                 
    ##        yogurt}                    => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [231] {canned beer,                                                                                                  
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [232] {citrus fruit,                                                                                                 
    ##        shopping bags,                                                                                                
    ##        yogurt}                    => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [233] {citrus fruit,                                                                                                 
    ##        pip fruit,                                                                                                    
    ##        soda}                      => {yogurt}                   0.0001336630  1.0000000 0.0001336630  11.644358     2
    ## [234] {citrus fruit,                                                                                                 
    ##        pastry,                                                                                                       
    ##        soda}                      => {whole milk}               0.0001336630  1.0000000 0.0001336630   6.332205     2
    ## [235] {pastry,                                                                                                       
    ##        root vegetables,                                                                                              
    ##        sausage}                   => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [236] {pastry,                                                                                                       
    ##        rolls/buns,                                                                                                   
    ##        sausage}                   => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [237] {other vegetables,                                                                                             
    ##        pastry,                                                                                                       
    ##        soda}                      => {whole milk}               0.0003341576  0.8333333 0.0004009891   5.276837     5
    ## [238] {bottled water,                                                                                                
    ##        citrus fruit,                                                                                                 
    ##        tropical fruit}            => {soda}                     0.0001336630  1.0000000 0.0001336630  10.298004     2
    ## [239] {citrus fruit,                                                                                                 
    ##        other vegetables,                                                                                             
    ##        tropical fruit}            => {whole milk}               0.0002004946  1.0000000 0.0002004946   6.332205     3
    ## [240] {rolls/buns,                                                                                                   
    ##        tropical fruit,                                                                                               
    ##        yogurt}                    => {sausage}                  0.0002673261  0.8000000 0.0003341576  13.256257     4

``` r
write(association_rules_no_reps,
      file = "../rules/association_rules_based_on_grocery_item.csv")
```

# STEP 4. Find specific rules

Which product(s), if bought, result in a customer purchasing “yogurt”?

``` r
yogurt_association_rules <- # nolint
  apriori(tr_grocery, parameter = list(supp = 0.0001, conf = 0.2),
          appearance = list(default = "lhs",
                            rhs = "yogurt"))
```

    ## Apriori
    ## 
    ## Parameter specification:
    ##  confidence minval smax arem  aval originalSupport maxtime support minlen
    ##         0.2    0.1    1 none FALSE            TRUE       5   1e-04      1
    ##  maxlen target  ext
    ##      10  rules TRUE
    ## 
    ## Algorithmic control:
    ##  filter tree heap memopt load sort verbose
    ##     0.1 TRUE TRUE  FALSE TRUE    2    TRUE
    ## 
    ## Absolute minimum support count: 1 
    ## 
    ## set item appearances ...[1 item(s)] done [0.00s].
    ## set transactions ...[167 item(s), 14963 transaction(s)] done [0.01s].
    ## sorting and recoding items ... [165 item(s)] done [0.00s].
    ## creating transaction tree ... done [0.01s].
    ## checking subsets of size 1 2 3 4 5 done [0.01s].
    ## writing ... [295 rule(s)] done [0.00s].
    ## creating S4 object  ... done [0.00s].

``` r
inspect(head(yogurt_association_rules))
```

    ##     lhs                                rhs      support      confidence
    ## [1] {bags}                          => {yogurt} 0.0001336630 0.5000000 
    ## [2] {liqueur}                       => {yogurt} 0.0001336630 0.2222222 
    ## [3] {specialty vegetables}          => {yogurt} 0.0002004946 0.2727273 
    ## [4] {newspapers, nut snack}         => {yogurt} 0.0001336630 1.0000000 
    ## [5] {nut snack, other vegetables}   => {yogurt} 0.0001336630 1.0000000 
    ## [6] {fruit/vegetable juice, spices} => {yogurt} 0.0001336630 0.5000000 
    ##     coverage     lift      count
    ## [1] 0.0002673261  5.822179 2    
    ## [2] 0.0006014837  2.587635 2    
    ## [3] 0.0007351467  3.175734 3    
    ## [4] 0.0001336630 11.644358 2    
    ## [5] 0.0001336630 11.644358 2    
    ## [6] 0.0002673261  5.822179 2

Which product(s) are bought if a customer purchases “pasta,pip fruit”?

``` r
pasta_pip_fruit_association_rules <- # nolint
  apriori(tr_grocery, parameter = list(supp = 0.0001, conf = 0.2),
          appearance = list(lhs = c("pasta", "pip fruit"), # nolint
                            default = "rhs"))
```

    ## Apriori
    ## 
    ## Parameter specification:
    ##  confidence minval smax arem  aval originalSupport maxtime support minlen
    ##         0.2    0.1    1 none FALSE            TRUE       5   1e-04      1
    ##  maxlen target  ext
    ##      10  rules TRUE
    ## 
    ## Algorithmic control:
    ##  filter tree heap memopt load sort verbose
    ##     0.1 TRUE TRUE  FALSE TRUE    2    TRUE
    ## 
    ## Absolute minimum support count: 1 
    ## 
    ## set item appearances ...[2 item(s)] done [0.00s].
    ## set transactions ...[167 item(s), 14963 transaction(s)] done [0.01s].
    ## sorting and recoding items ... [165 item(s)] done [0.00s].
    ## creating transaction tree ... done [0.01s].
    ## checking subsets of size 1 2 3 done [0.00s].
    ## writing ... [5 rule(s)] done [0.00s].
    ## creating S4 object  ... done [0.00s].

``` r
inspect(head(pasta_pip_fruit_association_rules))
```

    ##     lhs                   rhs                     support      confidence
    ## [1] {pasta, pip fruit} => {fruit/vegetable juice} 0.0001336630 0.2       
    ## [2] {pasta, pip fruit} => {yogurt}                0.0001336630 0.2       
    ## [3] {pasta, pip fruit} => {soda}                  0.0001336630 0.2       
    ## [4] {pasta, pip fruit} => {rolls/buns}            0.0002004946 0.3       
    ## [5] {pasta, pip fruit} => {whole milk}            0.0001336630 0.2       
    ##     coverage     lift     count
    ## [1] 0.0006683152 5.879371 2    
    ## [2] 0.0006683152 2.328872 2    
    ## [3] 0.0006683152 2.059601 2    
    ## [4] 0.0006683152 2.727157 3    
    ## [5] 0.0006683152 1.266441 2

# STEP 5. Visualize the rules

``` r
# Filter rules with confidence greater than 0.25 or 25%
rules_to_plot <-
  association_rules_no_reps[quality(association_rules_no_reps)$confidence > 0.25] # nolint

#Plot SubRules
plot(rules_to_plot)
```

    ## To reduce overplotting, jitter is added! Use jitter = 0 to prevent jitter.

![](Lab7c_Submission_files/figure-gfm/Code%2011-1.png)<!-- -->

``` r
top_10_rules_to_plot <- head(rules_to_plot, n = 10, by = "confidence")
```

## Filter top 20 rules with highest lift

``` r
rules_to_plot_by_lift <- head(rules_to_plot, n = 20, by = "lift")
plot(rules_to_plot_by_lift, method = "paracoord")
```

![](Lab7c_Submission_files/figure-gfm/Code%2013-1.png)<!-- -->

``` r
plot(top_10_rules_to_plot, method = "grouped")
```

    ## Registered S3 methods overwritten by 'registry':
    ##   method               from 
    ##   print.registry_field proxy
    ##   print.registry_entry proxy

![](Lab7c_Submission_files/figure-gfm/Code%2014-1.png)<!-- -->
