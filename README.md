# Tesla Stock Data Analysis
# Summary
This project analyzes historical stock market data for Tesla Inc. (TSLA) from 2010 to 2024 using time series forecasting techniques. The dataset, sourced from Kaggle, includes daily trading information such as opening price, highest and lowest prices, closing price, volume, adjusted closing price, percentage change, and average volume. The goal of this analysis is to identify trends, detect seasonal patterns, and evaluate forecasting models to predict Tesla’s future stock prices.

# Key Findings
- Trend Analysis: Tesla's stock price exhibited stable movement until 2019, followed by rapid growth in 2020 and high volatility post-2021.
- Autocorrelation Insights: The ACF plot revealed that Tesla’s daily stock return showed minimal correlation with past values, indicating randomness.
- STL Decomposition: The trend component demonstrated long-term growth, while the seasonal component showed minor periodic fluctuations.
- Box-Cox Transformation: Applied to stabilize variance and improve model performance.

# Forecasting Models & Performance
Four fundamental time series models were used for forecasting Tesla’s adjusted closing stock price:

- Mean Model: Assumes future stock prices equal the historical mean.
- Naïve Model: Uses the last observed stock price as the forecast.
- Drift Model: Extends the Naïve model by incorporating a linear trend.
- Seasonal Naïve Model: Assumes future values follow past seasonal cycles.

| Model            | Performance (RMSE)      |  
|-----------------|-------------------|  
| **Drift Model** | Best Performing   |  
| **Seasonal Naïve** | Moderate Accuracy |  
| **Naïve Model** | Higher Error      |  
| **Mean Model** | Least Accurate    |

Drift Model performed the best, but residual analysis showed high autocorrelation, suggesting limitations in capturing complex trends.
Seasonal Naïve Model captured cyclical patterns but still exhibited structured residuals.


# Recommendations & Future Work
- ARIMA Models: To better capture trends and seasonality.
- Exponential Smoothing (ETS): For improved forecasting stability.
- Machine Learning Approaches (LSTMs, Random Forests): To handle non-linear patterns.
- GARCH Models: To model high volatility in Tesla’s stock post-2020.
- Incorporating External Factors: Economic indicators and news sentiment can improve model accuracy.

The analysis shows that while basic models provide insights into Tesla's stock movements, more advanced forecasting techniques are required to capture the dynamic nature of stock prices

