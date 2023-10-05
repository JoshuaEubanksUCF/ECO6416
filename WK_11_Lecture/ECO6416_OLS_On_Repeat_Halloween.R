##################################################
#
# ECO 6416.0028 Applied Business Research Tools
#
# OLS Regression Demo
# Simulation with repeated estimation
# Halloween Edition
#
# Lealand Morin, Ph.D.
# Assistant Professor
# AKA Joshua Eubanks
# Department of Economics
# College of Business
# University of Central Florida
#
# October 31, 2023
#
##################################################
#
# ECO6416_OLS_On_Repeat gives an example of OLS regression
#   using simulated data.
#   It repeats the estimation several times to get a
#   distribution of estimates.
#
# Dependencies:
#   ECO6416_tools.R
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# If you are running this in a project forlder, you need no run 
# the following command.

# Otherwise, you will need to set the working directory to the location
# of your files.
# setwd("/path/to/your/folder")
# Find this path as follows:
# 1. Click on the "File" tab in the bottom right pane.
# 2. Browse to the folder on your computer that contains your R files.
# 3. Click the gear icon and choose the option "Set as Working Directory."
# 4. Copy the command from the Console in the bottom left pane.
# 5. Paste the command below:

# setwd("C:/Users/le279259/OneDrive - University of Central Florida/Desktop/ECO6416_Demos")

# Now, RStudio should know where your files are.



# No libraries required.
# Otherwise would have a command like the following.
# library(name_of_R_package)


# Read function for sampling data.
source('ECO6416_tools.R')
# This is the same as running the ECO6416_tools.R script first.
# It assumes that the script is saved in the same working folder.

# The file ECO6416_tools.R must be in the working directory.
# If you an error message, make sure that the file is
# located in your working directory.
# Also make sure that the name has not changed.


##################################################
# Setting the Parameters
##################################################

# Dependent Variable: Property values (in Millions)

beta_0          <-   0.10    # Intercept
beta_income     <-   5.00    # Slope ceofficient for income
beta_cali       <-   0.25    # Slope coefficient for California
beta_earthquake <- - 0.50    # Slope coefficient for earthquake
# beta_earthquake <- - 0.00    # Slope coefficient for earthquake

# Distribution of incomes (also in millions).
avg_income <- 0.1
sd_income <- 0.01

# Extra parameter for measurement error in income.
measurement_error_income <- 0.01

# Fraction of dataset in California.
pct_in_cali <- 0.5

# Frequency of earthquakes (only in California).
prob_earthquake <- 0.05

# Additional terms:
sigma_2 <- 0.1        # Variance of error term
num_obs <- 100      # Number of observations in dataset

# Set the number of replications in the simulation.
num_replications <- 1000


##################################################
# Generating the Fixed Data
##################################################

# Call the housing_sample function from ECO6416_Sim_Data.R.
housing_data <- housing_sample(beta_0, beta_income, beta_cali, beta_earthquake,
                               avg_income, sd_income, pct_in_cali, prob_earthquake,
                               sigma_2, num_obs)


# Summarize the data.
summary(housing_data)

# Check that earthquakes occurred only in California:
table(housing_data[, 'in_cali'], housing_data[, 'earthquake'])
# Data errors are the largest cause of problems in model-building.


##################################################
# Generating Additional Data
# The extra data that is not in the model
##################################################

#--------------------------------------------------
# Assume that true income is not observed but some variables
# that are correlated with income are available.
#--------------------------------------------------

# Income measure 1.
housing_data[, 'income_1'] <- 0
housing_data[, 'income_1'] <- housing_data[, 'income'] +
  rnorm(n = num_obs, mean = 0, sd = measurement_error_income)

# Income measure 2.
housing_data[, 'income_2'] <- 0
housing_data[, 'income_2'] <- housing_data[, 'income'] +
  rnorm(n = num_obs, mean = 0, sd = measurement_error_income)


##################################################
# Running a Simulation
# Estimating Again and Again
##################################################

# Set the list of variables for the estimation.
# list_of_variables <- c('income', 'in_cali', 'earthquake')
list_of_variables <- c('income_1', 'in_cali', 'earthquake')

# Add beta_0 to the beginning for the full list.
full_list_of_variables <- c('intercept', list_of_variables)

# Create an empty data frame to store the results.
reg_results <- data.frame(reg_num = 1:num_replications)
reg_results[, full_list_of_variables] <- 0
reg_results[, c('income', 'income_1', 'income_2')] <- 0


# Generate repeated realizations of the housing_data dataset.
for (reg_num in 1:num_replications) {

  # Print a progress report.
  # print(sprintf('Now estimating model number %d.', reg_num))

  ##################################################
  # Generating the Random Data
  ##################################################

  # Repeat again and again, replacing only the epsilon values.

  # Generate the error term, which includes everything we do not observe.
  housing_data[, 'epsilon'] <- rnorm(n = num_obs, mean = 0, sd = sigma_2)

  # Finally, recalculate the simulated value of house prices,
  # according to the regression equation.
  housing_data[, 'house_price'] <-
    beta_0 +
    beta_income * housing_data[, 'income'] +
    beta_cali * housing_data[, 'in_cali'] +
    beta_earthquake * housing_data[, 'earthquake'] +
    housing_data[, 'epsilon']
  # Each time, this replaces the house_price with a different version
  # of the error term.


  ##################################################
  # Estimating the Regression Model
  ##################################################

  # Specify the formula to estimate.
  lm_formula <- as.formula(paste('house_price ~ ',
                                 paste(list_of_variables, collapse = ' + ')))

  # Estimate a regression model.
  lm_full_model <- lm(data = housing_data,
                      formula = lm_formula)
  # Note that the normal format is:
  # model_name <- lm(data = name_of_dataset, formula = Y ~ X_1 + x_2 + x_K)
  # but the above is a shortcut for a pre-set list_of_variables.

  ##################################################
  # Saving the Results
  ##################################################

  # Save the estimates in the row for this particular estimation.
  reg_results[reg_num, full_list_of_variables] <- coef(lm_full_model)

}


##################################################
# Analyzing the Results
##################################################

#--------------------------------------------------
# Display some graphs
# Click the arrows in the bottom right pane to
# switch between previous figures.
#--------------------------------------------------

# Plot a histogram for each estimate.
# Note that some will be empty if they were not included in the estimation.

hist(reg_results[, 'intercept'],
     main = 'Distribution of beta_0',
     xlab = 'Estimated Coefficient',
     ylab = 'Frequency',
     breaks = 20)

# This will be blank if income is not in the regression:
hist(reg_results[, 'income'],
     main = 'Distribution of beta_income',
     xlab = 'Estimated Coefficient',
     ylab = 'Frequency',
     breaks = 20)

# This will be blank if income_1 is not in the regression:
hist(reg_results[, 'income_1'],
     main = 'Distribution of beta_income_1',
     xlab = 'Estimated Coefficient',
     ylab = 'Frequency',
     breaks = 20)

# This will be blank if income_2 is not in the regression:
hist(reg_results[, 'income_2'],
     main = 'Distribution of beta_income_2',
     xlab = 'Estimated Coefficient',
     ylab = 'Frequency',
     breaks = 20)

hist(reg_results[, 'in_cali'],
     main = 'Distribution of beta_cali',
     xlab = 'Estimated Coefficient',
     ylab = 'Frequency',
     breaks = 20)

hist(reg_results[, 'earthquake'],
     main = 'Distribution of beta_earthquake',
     xlab = 'Estimated Coefficient',
     ylab = 'Frequency',
     breaks = 20)

#--------------------------------------------------
# Output some statistics to screen
#--------------------------------------------------

# Display some statistics for the result.
summary(reg_results[, full_list_of_variables])

# Calculate the average estimates separately.
print('Average value of the coefficients are:')
sapply(reg_results[, full_list_of_variables], mean)

# Calculate the standard deviation of the estimates.
print('Standard Deviations of the coefficients are:')
sapply(reg_results[, full_list_of_variables], sd)


#--------------------------------------------------
# Compare to one estimate from a single dataset
#--------------------------------------------------

# Compare this with the results from the last model.
summary(lm_full_model)

# Compare the standard errors with the standard deviations
# of the estimates from the (infeasible) distributions
# of parameter estimates.


##################################################
# End
##################################################