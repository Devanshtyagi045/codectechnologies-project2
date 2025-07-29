# Importing necessary libraries
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset
df = pd.read_csv("Unemployment in India.csv")

# Display basic information
print("Dataset Info:")
print(df.info())
print("\nFirst 5 Rows:")
print(df.head())

# Rename columns for consistency
df.columns = ['Region', 'Date', 'Frequency', 'Estimated Unemployment Rate', 'Estimated Employed', 'Estimated Labour Participation Rate', 'Area']

# Convert 'Date' to datetime
df['Date'] = pd.to_datetime(df['Date'])

# Check for missing values
print("\nMissing Values:")
print(df.isnull().sum())

# Basic statistics
print("\nDescriptive Statistics:")
print(df.describe())

# ----------------- Data Visualization -----------------

# Unemployment rate over time (national trend)
plt.figure(figsize=(12, 6))
sns.lineplot(data=df, x='Date', y='Estimated Unemployment Rate', hue='Area')
plt.title("Unemployment Rate Over Time (Urban vs Rural)")
plt.ylabel("Unemployment Rate (%)")
plt.xlabel("Date")
plt.legend(title='Area')
plt.grid(True)
plt.tight_layout()
plt.show()

# Average Unemployment Rate by Region
plt.figure(figsize=(14, 6))
region_avg = df.groupby('Region')['Estimated Unemployment Rate'].mean().sort_values()
sns.barplot(x=region_avg.index, y=region_avg.values, palette='viridis')
plt.xticks(rotation=45)
plt.title("Average Unemployment Rate by Region")
plt.ylabel("Unemployment Rate (%)")
plt.tight_layout()
plt.show()

# Monthly average unemployment rate (seasonal pattern)
df['Month'] = df['Date'].dt.month
monthly_avg = df.groupby('Month')['Estimated Unemployment Rate'].mean()
plt.figure(figsize=(10, 5))
sns.lineplot(x=monthly_avg.index, y=monthly_avg.values, marker='o')
plt.title("Average Monthly Unemployment Rate in India")
plt.xlabel("Month")
plt.ylabel("Unemployment Rate (%)")
plt.xticks(ticks=range(1,13))
plt.grid(True)
plt.tight_layout()
plt.show()

# Covid-19 Impact: Year-wise average unemployment
df['Year'] = df['Date'].dt.year
yearly_avg = df.groupby('Year')['Estimated Unemployment Rate'].mean()
plt.figure(figsize=(10, 5))
sns.barplot(x=yearly_avg.index, y=yearly_avg.values, palette="coolwarm")
plt.title("Year-wise Unemployment Rate (Covid-19 Impact)")
plt.xlabel("Year")
plt.ylabel("Average Unemployment Rate (%)")
plt.tight_layout()
plt.show()

# Heatmap of unemployment by region and month
pivot = df.pivot_table(values='Estimated Unemployment Rate', index='Region', columns='Month', aggfunc='mean')
plt.figure(figsize=(14, 7))
sns.heatmap(pivot, annot=True, cmap="YlGnBu", fmt=".1f")
plt.title("Monthly Unemployment Rate by Region (Heatmap)")
plt.tight_layout()
plt.show()
