Tesla Stock Price Analysis and Forecasting (2010–2024)
Objective
This analysis aims to explore the historical trends, volatility, and seasonality of Tesla Inc.’s stock prices and apply fundamental forecasting models to predict future price movements. By leveraging statistical techniques, we assess different forecasting models' performance to understand Tesla’s market behavior and investment potential.

Dataset
The dataset, 'tsla_raw_data_2010_2024.csv', was sourced from Kaggle and contains daily Tesla stock market data from 2010 to 2024. It includes variables such as open, high, low, close, adjusted close, volume, average volume, and percentage change. The data was processed in R, with necessary cleaning steps like date formatting, missing value imputation, and numeric conversions.

Key Findings
Trend & Volatility:

Tesla's stock price remained stable from 2010 to 2019, followed by an exponential rise starting in 2019, peaking in early 2021, and then experiencing fluctuations.
Post-2020, high volatility was observed, likely due to market speculation, macroeconomic factors, and investor sentiment shifts.
Autocorrelation & Decomposition:

The Autocorrelation Function (ACF) plot revealed little predictive power in past stock changes, aligning with the efficient market hypothesis.
STL decomposition showed that Tesla’s stock primarily follows a strong trend component, with minor seasonal variations.
Forecasting Models & Performance:

Applied Mean, Naïve, Drift, and Seasonal Naïve models to forecast the next 230 days.
Drift Model performed best, capturing linear trends, followed by the Seasonal Naïve Model, which considered cyclic patterns.
Residual analysis indicated that all models exhibited some level of autocorrelation, suggesting that more advanced techniques are needed.
Model	Performance (RMSE, Lower is Better)
Drift Model	Best Performing ✅
Seasonal Naïve	Moderate Accuracy
Naïve Model	Higher Error
Mean Model	Least Accurate ❌
Recommendations & Next Steps
While the Drift Model provided the best forecast among basic models, it still fails to fully capture Tesla’s price dynamics. To enhance prediction accuracy, we recommend:

ARIMA models to capture trends and seasonality.
Exponential Smoothing (ETS) for improved stability.
GARCH models to model increased volatility post-2020.
Machine Learning approaches (e.g., LSTMs, Random Forest) to incorporate external factors like news sentiment and macroeconomic indicators.
This analysis highlights Tesla’s long-term growth trajectory while acknowledging the challenges of stock price prediction due to high volatility. Future work will explore more advanced techniques for improved forecasting accuracy.

