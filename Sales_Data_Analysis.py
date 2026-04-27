# ============================================================
# SALES DATA ANALYSIS — Python Analysis Script
# Author  : Hima Bindu
# Dataset : 10,000 Sales Transactions (2024)
# Tools   : Python, Pandas, NumPy, Matplotlib, Seaborn
# ============================================================

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import seaborn as sns
import warnings
warnings.filterwarnings('ignore')

# Plot style
sns.set_theme(style="whitegrid", palette="Blues_d")
plt.rcParams['figure.dpi'] = 120
plt.rcParams['font.family'] = 'DejaVu Sans'

# ──────────────────────────────────────────
# 1. LOAD DATA
# ──────────────────────────────────────────
df = pd.read_csv('sales_data.csv')
print("=" * 55)
print("  SALES DATA ANALYSIS — 2024")
print("=" * 55)
print(f"\n✅ Dataset loaded: {df.shape[0]:,} rows × {df.shape[1]} columns\n")
print(df.head())

# ──────────────────────────────────────────
# 2. DATA CLEANING & VALIDATION
# ──────────────────────────────────────────
print("\n" + "─" * 55)
print("  STEP 1: DATA CLEANING & VALIDATION")
print("─" * 55)

# 2.1 Check null values
print(f"\n🔍 Null Values per Column:")
print(df.isnull().sum())

# 2.2 Check duplicates
dupes = df.duplicated(subset='Transaction_ID').sum()
print(f"\n🔍 Duplicate Transaction IDs: {dupes}")

# 2.3 Data types
print(f"\n🔍 Data Types:")
print(df.dtypes)

# 2.4 Convert date
df['Date'] = pd.to_datetime(df['Date'])
df['Month_Num'] = df['Date'].dt.month
df['Month_Name'] = df['Date'].dt.strftime('%b')
df['Day_of_Week'] = df['Date'].dt.day_name()
print("\n✅ Date column converted to datetime.")

# 2.5 Check for negative revenue
neg_rev = (df['Revenue'] < 0).sum()
print(f"✅ Negative Revenue values: {neg_rev}")

# 2.6 Validate discount range
print(f"✅ Unique Discount %: {sorted(df['Discount_Percent'].unique())}")

# 2.7 Category & Region consistency
print(f"✅ Categories ({df['Category'].nunique()}): {list(df['Category'].unique())}")
print(f"✅ Regions   ({df['Region'].nunique()}): {list(df['Region'].unique())}")

print("\n✅ Data Cleaning Complete — Dataset is clean and ready for analysis.\n")

# ──────────────────────────────────────────
# 3. EXPLORATORY DATA ANALYSIS (EDA)
# ──────────────────────────────────────────
print("─" * 55)
print("  STEP 2: EXPLORATORY DATA ANALYSIS (EDA)")
print("─" * 55)

total_revenue    = df['Revenue'].sum()
total_orders     = len(df)
avg_order_value  = df['Revenue'].mean()
total_units_sold = df['Quantity'].sum()

print(f"\n📊 KEY METRICS:")
print(f"   Total Revenue     : ₹{total_revenue:,.2f}")
print(f"   Total Orders      : {total_orders:,}")
print(f"   Avg Order Value   : ₹{avg_order_value:,.2f}")
print(f"   Total Units Sold  : {total_units_sold:,}")

# 3.1 Revenue by Category
cat_rev = df.groupby('Category')['Revenue'].sum().sort_values(ascending=False)
print(f"\n📦 Revenue by Category:")
print(cat_rev.apply(lambda x: f"₹{x:,.0f}"))

# 3.2 Revenue by Region
reg_rev = df.groupby('Region')['Revenue'].sum().sort_values(ascending=False)
print(f"\n🗺️  Revenue by Region:")
print(reg_rev.apply(lambda x: f"₹{x:,.0f}"))

# 3.3 Monthly trend
month_order = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
monthly = df.groupby('Month_Name')['Revenue'].sum().reindex(month_order)
print(f"\n📅 Monthly Revenue:")
print(monthly.apply(lambda x: f"₹{x:,.0f}"))

# 3.4 Top 5 Products by Revenue
top_products = df.groupby('Product')['Revenue'].sum().sort_values(ascending=False).head(5)
print(f"\n🏆 Top 5 Products by Revenue:")
print(top_products.apply(lambda x: f"₹{x:,.0f}"))

# 3.5 Payment method distribution
payment = df['Payment_Method'].value_counts()
print(f"\n💳 Payment Method Distribution:")
print(payment)

# ──────────────────────────────────────────
# 4. VISUALIZATIONS
# ──────────────────────────────────────────
print("\n" + "─" * 55)
print("  STEP 3: GENERATING VISUALIZATIONS")
print("─" * 55)

fig, axes = plt.subplots(2, 3, figsize=(20, 12))
fig.suptitle('Sales Data Analysis — 2024 Dashboard', fontsize=18, fontweight='bold', color='#1F4E79', y=1.01)

BLUE   = '#2E75B6'
DARK   = '#1F4E79'
colors = ['#1F4E79','#2E75B6','#5B9BD5','#9DC3E6','#DEEAF1']

# Chart 1: Revenue by Category
ax1 = axes[0, 0]
bars = ax1.bar(cat_rev.index, cat_rev.values / 1e6, color=colors[:len(cat_rev)], edgecolor='white', linewidth=0.8)
ax1.set_title('Revenue by Category', fontweight='bold', color=DARK, fontsize=12)
ax1.set_ylabel('Revenue (₹ Millions)')
ax1.set_xlabel('')
ax1.tick_params(axis='x', rotation=15)
for bar in bars:
    ax1.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.5,
             f'₹{bar.get_height():.0f}M', ha='center', va='bottom', fontsize=8, fontweight='bold')

# Chart 2: Revenue by Region
ax2 = axes[0, 1]
bars2 = ax2.bar(reg_rev.index, reg_rev.values / 1e6, color=colors[:len(reg_rev)], edgecolor='white')
ax2.set_title('Revenue by Region', fontweight='bold', color=DARK, fontsize=12)
ax2.set_ylabel('Revenue (₹ Millions)')
for bar in bars2:
    ax2.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.3,
             f'₹{bar.get_height():.0f}M', ha='center', va='bottom', fontsize=8, fontweight='bold')

# Chart 3: Monthly Revenue Trend
ax3 = axes[0, 2]
ax3.plot(month_order, monthly.values / 1e6, marker='o', color=BLUE, linewidth=2.5, markersize=7, markerfacecolor=DARK)
ax3.fill_between(month_order, monthly.values / 1e6, alpha=0.15, color=BLUE)
ax3.set_title('Monthly Revenue Trend', fontweight='bold', color=DARK, fontsize=12)
ax3.set_ylabel('Revenue (₹ Millions)')
ax3.tick_params(axis='x', rotation=45)

# Chart 4: Top 5 Products
ax4 = axes[1, 0]
ax4.barh(top_products.index[::-1], top_products.values[::-1] / 1e6, color=BLUE, edgecolor='white')
ax4.set_title('Top 5 Products by Revenue', fontweight='bold', color=DARK, fontsize=12)
ax4.set_xlabel('Revenue (₹ Millions)')

# Chart 5: Payment Method Pie
ax5 = axes[1, 1]
wedges, texts, autotexts = ax5.pie(
    payment.values, labels=payment.index, autopct='%1.1f%%',
    colors=colors, startangle=90,
    wedgeprops=dict(edgecolor='white', linewidth=1.5)
)
for autotext in autotexts:
    autotext.set_fontsize(8)
ax5.set_title('Payment Method Distribution', fontweight='bold', color=DARK, fontsize=12)

# Chart 6: Revenue by Category & Region (Grouped)
ax6 = axes[1, 2]
cat_reg = df.groupby(['Category','Region'])['Revenue'].sum().unstack()
cat_reg_m = cat_reg / 1e6
cat_reg_m.plot(kind='bar', ax=ax6, color=colors[:len(cat_reg_m.columns)], edgecolor='white', linewidth=0.5)
ax6.set_title('Category Revenue by Region', fontweight='bold', color=DARK, fontsize=12)
ax6.set_ylabel('Revenue (₹ Millions)')
ax6.set_xlabel('')
ax6.tick_params(axis='x', rotation=20)
ax6.legend(title='Region', fontsize=8, title_fontsize=8)

plt.tight_layout()
plt.savefig('sales_analysis_charts.png', bbox_inches='tight', dpi=150)
plt.show()
print("\n✅ Charts saved as 'sales_analysis_charts.png'")

# ──────────────────────────────────────────
# 5. KEY INSIGHTS
# ──────────────────────────────────────────
print("\n" + "=" * 55)
print("  KEY INSIGHTS & BUSINESS RECOMMENDATIONS")
print("=" * 55)

top_cat    = cat_rev.index[0]
top_reg    = reg_rev.index[0]
top_prod   = top_products.index[0]
low_cat    = cat_rev.index[-1]
peak_month = monthly.idxmax()

print(f"""
📌 INSIGHT 1 — Top Revenue Category:
   {top_cat} is the highest revenue-generating category 
   contributing ₹{cat_rev[top_cat]/1e6:.1f}M ({cat_rev[top_cat]/total_revenue*100:.1f}% of total revenue).
   → Recommendation: Increase inventory and marketing for {top_cat}.

📌 INSIGHT 2 — Top Performing Region:
   {top_reg} region leads with ₹{reg_rev[top_reg]/1e6:.1f}M in revenue.
   → Recommendation: Replicate {top_reg} strategies in lower-performing regions.

📌 INSIGHT 3 — Best Selling Product:
   '{top_prod}' is the top revenue-generating product.
   → Recommendation: Ensure stock availability and promote via offers.

📌 INSIGHT 4 — Underperforming Category:
   {low_cat} generates only ₹{cat_rev[low_cat]/1e6:.1f}M.
   → Recommendation: Review pricing strategy or run targeted promotions.

📌 INSIGHT 5 — Peak Sales Month:
   {peak_month} recorded the highest revenue of ₹{monthly[peak_month]/1e6:.1f}M.
   → Recommendation: Plan inventory and campaigns ahead of {peak_month}.
""")

print("✅ Analysis Complete!")
