# *****************************************************************************
# Lab 7.c.: Algorithm Selection for Association Rule Learning ----
#
# Course Code: BBT4206
# Course Name: Business Intelligence II
# Semester Duration: 21st August 2023 to 28th November 2023
#
# Lecturer: Allan Omondi
# Contact: aomondi [at] strathmore.edu
#
# Note: The lecture contains both theory and practice. This file forms part of
#       the practice. It has required lab work submissions that are graded for
#       coursework marks.
#
# License: GNU GPL-3.0-or-later
# See LICENSE file for licensing information.
# *****************************************************************************

# **[OPTIONAL] Initialization: Install and use renv ----
# The R Environment ("renv") package helps you create reproducible environments
# for your R projects. This is helpful when working in teams because it makes
# your R projects more isolated, portable and reproducible.

# Further reading:
#   Summary: https://rstudio.github.io/renv/
#   More detailed article: https://rstudio.github.io/renv/articles/renv.html

# "renv" It can be installed as follows:
# if (!is.element("renv", installed.packages()[, 1])) {
# install.packages("renv", dependencies = TRUE,
# repos = "https://cloud.r-project.org") # nolint
# }
# require("renv") # nolint

# Once installed, you can then use renv::init() to initialize renv in a new
# project.

# The prompt received after executing renv::init() is as shown below:
# This project already has a lockfile. What would you like to do?

# 1: Restore the project from the lockfile.
# 2: Discard the lockfile and re-initialize the project.
# 3: Activate the project without snapshotting or installing any packages.
# 4: Abort project initialization.

# Select option 1 to restore the project from the lockfile
# renv::init() # nolint

# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall
# them) are recorded into a lockfile, renv.lock, and a .Rprofile ensures that
# the library is used every time you open the project.

# Consider a library as the location where packages are stored.
# Execute the following command to list all the libraries available in your
# computer:
.libPaths()

# One of the libraries should be a folder inside the project if you are using
# renv

# Then execute the following command to see which packages are available in
# each library:
lapply(.libPaths(), list.files)

# This can also be configured using the RStudio GUI when you click the project
# file, e.g., "BBT4206-R.Rproj" in the case of this project. Then
# navigate to the "Environments" tab and select "Use renv with this project".

# As you continue to work on your project, you can install and upgrade
# packages, using either:
# install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot(), AT THE END, to record the packages and their
# sources in the lockfile.

# Later, if you need to share your code with someone else or run your code on
# a new machine, your collaborator (or you) can call renv::restore() to
# reinstall the specific package versions recorded in the lockfile.

# [OPTIONAL]
# Execute the following code to reinstall the specific package versions
# recorded in the lockfile (restart R after executing the command):
# renv::restore() # nolint

# [OPTIONAL]
# If you get several errors setting up renv and you prefer not to use it, then
# you can deactivate it using the following command (restart R after executing
# the command):
# renv::deactivate() # nolint

# If renv::restore() did not install the "languageserver" package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}



# STEP 1. Install and Load the Required Packages ---- association
## arules ----
if (require("arules")) {
  require("arules")
} else {
  install.packages("arules", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## arulesViz ----
if (require("arulesViz")) {
  require("arulesViz")
} else {
  install.packages("arulesViz", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## tidyverse ----
if (require("tidyverse")) {
  require("tidyverse")
} else {
  install.packages("tidyverse", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## readxl ----
if (require("readxl")) {
  require("readxl")
} else {
  install.packages("readxl", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## knitr ----
if (require("knitr")) {
  require("knitr")
} else {
  install.packages("knitr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

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

## RColorBrewer ----
if (require("RColorBrewer")) {
  require("RColorBrewer")
} else {
  install.packages("RColorBrewer", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

# STEP 2. Load and pre-process the dataset ----

# The "read.transactions" function in the "arules" package is used to read
# transaction data from a file and create a "transactions object".

# The transaction data can be specified in either of the following 2 formats:

## FORMAT 1: Single Format ----
# An example of the single format transaction data is presented
# here: "data/transactions_single_format.csv" and loaded as follows:

transactions_single_format_work <-
  read.transactions("data/Groceries_dataset.csv",
                    format = "single", cols = c(1, 3),
                    header = TRUE,
                    rm.duplicates = TRUE,
                    sep = ",")

View(transactions_single_format_work)
print(transactions_single_format_work)
summary(transactions_single_format_work)
inspect(transactions_single_format_work)

## The grocery dataset ----
# source :https://www.kaggle.com/datasets/heeraldedhia/groceries-dataset
library(readr)
Groceries_dataset <- read_csv("data/Groceries_dataset.csv")
dim(Groceries_dataset)

### Handle missing values ----
# Are there missing values in the dataset?
any_na(Groceries_dataset)

## Identify categorical variables ----
str(Groceries_dataset)
head(Groceries_dataset)

# We can separate the date and the time into 2 different variables.
Groceries_dataset <-
  Groceries_dataset %>%
  mutate_all(~str_replace_all(., ",", " "))

## Create a transaction data frame using the "basket format" ----
str(Groceries_dataset)
# To do this, we group the data by `member_no` and `date`
# We then combine all products from one member  and date as one row and
# separate each item by a comma. (Refer to STEP 2. FORMAT 1).

# The basket format that we want looks
# like this: "data/transactions_basket_format.csv"

# ddply is used to split a data frame, apply a function to the split data,
# and then return the result back in a data frame.
### OPTION 1 ----
grocerie_data <-
  plyr::ddply(Groceries_dataset,
              c("Member_number", "Date"),
              function(df1) {
                paste(df1$itemDescription, collapse = ",")
              }
  )
View(grocerie_data)



## Record only the `items` variable ----
# Notice that at this point, the basket format ensures that each transaction is
# recorded in one row. We therefore no longer require the
# `member_no` variable and all the other variables in the data frame except
# the itemsets.
grocerie_data <-
  grocerie_data %>%
  dplyr::select("items" = V1)
View(grocerie_data)

## Save the transactions in CSV format ----
### OPTION 1 ----
write.csv(grocerie_data,
          "data/grocerie_basket_format.csv",
          quote = FALSE, row.names = FALSE)

## Read the transactions fromm the CSV file ----
# We can now, finally, read the basket format transaction data as a
# transaction object.
### OPTION 1 ----
tr_grocery <-
  read.transactions("data/grocerie_basket_format.csv",
                    format = "basket",
                    header = TRUE,
                    rm.duplicates = TRUE,
                    sep = ","
  )

# This shows there are 14963 transactions that have been identified
# and 167 items
print(tr_grocery)
summary(tr_grocery)

# STEP 2. Basic EDA ----
# Create an item frequency plot for the top 10 items
itemFrequencyPlot(tr_grocery, topN = 10, type = "absolute",
                  col = brewer.pal(8, "Pastel2"),
                  main = "Absolute Item Frequency Plot",
                  horiz = TRUE,
                  mai = c(2, 2, 2, 2))

itemFrequencyPlot(tr_grocery, topN = 10, type = "relative",
                  col = brewer.pal(8, "Pastel2"),
                  main = "Relative Item Frequency Plot",
                  horiz = TRUE,
                  mai = c(2, 2, 2, 2))

# STEP 3. Create the association rules ----
association_rules <- apriori(tr_grocery,
                             parameter = list(support = 0.0001,
                                              confidence = 0.8,
                                              maxlen = 10))

# STEP 3. Print the association rules ----
# Threshold values of support = 0.0001, confidence = 0.8, and
# maxlen = 10 results in a total of 83 rules 
summary(association_rules)
inspect(association_rules)
# To view the top 10 rules
inspect(association_rules[1:10])
plot(association_rules)

### Remove redundant rules ----
# We can remove the redundant rules as follows:
subset_rules <-
  which(colSums(is.subset(association_rules,
                          association_rules)) > 1)
length(subset_rules)
association_rules_no_reps <- association_rules[-subset_rules]

# This results in 40 non-redundant rules (instead of the initial 83 rules)
summary(association_rules_no_reps)
inspect(association_rules_no_reps)

write(association_rules_no_reps,
      file = "rules/association_rules_based_on_grocery_item.csv")

# STEP 4. Find specific rules ----
# Which product(s), if bought, result in a customer purchasing
# "yogurt"?
yogurt_association_rules <- # nolint
  apriori(tr_grocery, parameter = list(supp = 0.0001, conf = 0.2),
          appearance = list(default = "lhs",
                            rhs = "yogurt"))
inspect(head(yogurt_association_rules))

# Which product(s) are bought if a customer purchases
# "pasta,pip fruit"?
pasta_pip_fruit_association_rules <- # nolint
  apriori(tr_grocery, parameter = list(supp = 0.0001, conf = 0.2),
          appearance = list(lhs = c("pasta", "pip fruit"), # nolint
                            default = "rhs"))
inspect(head(pasta_pip_fruit_association_rules))

# STEP 5. Visualize the rules ----
# Filter rules with confidence greater than 0.25 or 25%
rules_to_plot <-
  association_rules_no_reps[quality(association_rules_no_reps)$confidence > 0.25] # nolint

#Plot SubRules
plot(rules_to_plot)
plot(rules_to_plot, method = "two-key plot")

top_10_rules_to_plot <- head(rules_to_plot, n = 10, by = "confidence")
plot(top_10_rules_to_plot, method = "graph",  engine = "htmlwidget")

saveAsGraph(head(rules_to_plot, n = 1000, by = "lift"),
            file = "graph/association_rules_no_reps_grocery.graphml")

## Tools to view .graphml Files ----
# yEd Graph Editor: https://www.yworks.com/products/yed
# Cytoscape: https://cytoscape.org/
# Gephi: https://gephi.org/
# Network Analysis Software: Pajek and NodeXL
# Libraries in Python and R

# Filter top 20 rules with highest lift
rules_to_plot_by_lift <- head(rules_to_plot, n = 20, by = "lift")
plot(rules_to_plot_by_lift, method = "paracoord")

plot(top_10_rules_to_plot, method = "grouped")



