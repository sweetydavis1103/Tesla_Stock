# Required Libraries
library(tidyverse)
library(lubridate)
library(forecast)
library(TTR)
library(zoo)
library(dplyr)
library(knitr)
library(fable)
library(tsibble)
library(ggplot2)
library(fabletools)
library(feasts) 

# Step 1: Load and Clean Data
# -----------------------------------------------
# Read the dataset
tsla_stck <- read.csv("C:\\Users\\Brighty Davis\\OneDrive\\Desktop\\pREDICTIVE aNALYTICS SEM 2\\Statistical forecasting\\tsla_raw_data_2010_2024.csv", stringsAsFactors = FALSE)

# Convert the 'date' column to Date format
tsla_stck$date <- as.Date(parse_date_time(tsla_stck$date, orders = c("dmy", "mdy", "ymd")))

# Convert numeric columns
numeric_cols <- c("open", "high", "low", "close", "volume", "adjusted_close", 
                  "change_percent", "avg_vol_20d")
tsla_stck[numeric_cols] <- lapply(tsla_stck[numeric_cols], 
                                  function(x) as.numeric(gsub(",", "", x)))

# Handle missing values
# Fill first 19 rows of avg_vol_20d using moving average
for (i in 1:19) {
  tsla_stck$avg_vol_20d[i] <- mean(tsla_stck$avg_vol_20d[20:(20 + i - 1)], 
                                   na.rm = TRUE)
}

# Forward fill for missing values in change_percent
tsla_stck <- tsla_stck %>% fill(change_percent, .direction = "up")

# Step 2: Create Time Series Objects
# -----------------------------------------------
# Create basic time series object
tsla_ts <- ts(tsla_stck$adjusted_close, frequency = 252)  # 252 trading days per year

# Step 3: Exploratory Data Analysis
# -----------------------------------------------
# Basic time series plot
p1 <- autoplot(tsla_ts) +
  labs(title = "Tesla Adjusted Close Price Over Time",
       x = "Date",
       y = "Adjusted Close Price") +
  theme_minimal()
print(p1)

# ACF plot
acf(tsla_stck$change_percent, main = "Autocorrelation of Tesla Stock Change Percent")

# Step 4: Decomposition and Transformation
# -----------------------------------------------
# STL Decomposition
dcmp <- stl(tsla_ts, s.window = "periodic")
print(autoplot(dcmp) + 
        labs(title = "STL Decomposition of Tesla Stock Adjusted Close Price"))

# Box-Cox Transformation
# Convert to tsibble and fill missing gaps
tsla_tsibble <- tsla_stck %>%
  as_tsibble(index = date) %>%
  fill_gaps()

# Calculate optimal lambda and transform the data
lambda <- BoxCox.lambda(tsla_tsibble$adjusted_close)
tsla_tsibble <- tsla_tsibble %>%
  mutate(transformed_close = BoxCox(adjusted_close, lambda))

# Create transformed time series object
ts_transformed <- ts(tsla_tsibble$transformed_close, frequency = 252)

# Plot original vs transformed
par(mfrow = c(2, 1))
plot(tsla_ts, main = "Original Data (Adjusted Close Price)", col = "blue")
plot(ts_transformed, main = "Box-Cox Transformed Data", col = "red")
par(mfrow = c(1, 1))

# Step 5: Modeling and Forecasting
# -----------------------------------------------
# Fit models
tsla_fit <- tsla_tsibble %>%
  model(
    Mean = MEAN(transformed_close),
    Naive = NAIVE(transformed_close),
    Drift = RW(transformed_close ~ drift()),
    SeasonalNaive = SNAIVE(transformed_close)
  )

# Generate forecasts (230 days ahead)
tsla_forecast <- tsla_fit %>%
  forecast(h = 230, level = 95) 

# Calculate accuracy metrics
accuracy_metrics <- tsla_fit %>%
  accuracy() %>%
  arrange(RMSE)
print(accuracy_metrics)

# Step 6: Visualization and Residual Analysis
# -----------------------------------------------
# Plot forecasts (transformed scale)
p2 <- autoplot(tsla_forecast) +
  autolayer(tsla_tsibble, transformed_close, color = "black") +
  labs(title = "Tesla Stock Forecasting",
       x = "Date",
       y = "Transformed Adjusted Close Price") +
  theme_minimal()
print(p2)

# Residual analysis
residuals <- augment(tsla_fit)
p4 <- autoplot(residuals, .innov) +
  labs(title = "Residuals from forecasting models")
print(p4)

# ACF plot of residuals using feasts package
residuals %>%
  ACF(.innov, lag_max = 36) %>%
  autoplot() +
  labs(title = "ACF of Residuals")


# Step 7: Save Results
# -----------------------------------------------
# Save accuracy metrics to CSV
write.csv(accuracy_metrics, "forecast_accuracy_metrics.csv", row.names = FALSE)

# Print summary of best model
best_model <- accuracy_metrics %>%
  slice(1) %>%
  pull(.model)
cat("\nBest performing model based on RMSE:", best_model)