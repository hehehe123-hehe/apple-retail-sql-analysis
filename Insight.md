# Apple Retail 2023: Insights

**Scope:** 1 Jan to 31 Dec 2023, Apple Retail Sales Dataset (Kaggle, by Aman Garg; synthetic data).
**Method:** T-SQL (SQL Server), reconciled against Python and Power BI. All three tools return the same 2023 figures (for example, Tablet revenue = $195,217,876).

## Headline numbers

| Metric | 2023 |
|---|---|
| Revenue | $1,261,440,123 (about $1.26B) |
| Units sold | 1,172,649 |
| Transactions | 213,453 |
| Warranty claims | 6,109 (2.86% of transactions) |

Monthly revenue is flat, between $96.7M and $107.6M. Month-over-month change stays between -9.4% (February) and +10.4% (March), and mostly within +/-3%. There is no growth trend in 2023.

## 1. Revenue and product mix

- **Three categories lead, almost tied:** Tablet $195.2M (15.5%), Accessories $191.0M (15.1%) and Smartphone $176.0M (14.0%) make up 44.6% of revenue. Smart Speaker ($19.9M, 1.6%) and Streaming Device ($39.7M, 3.1%) are the smallest.
- **Accessories lead in volume:** 185,448 units, the most of any category, because of a lower unit price. MagSafe Charger is the top accessory at $22.9M.
- **Products sell at nearly the same frequency:** among the 81 ranked products, transactions range only from 2,298 to 2,479. The top 10 products earn $23.3M to $26.1M each, so revenue rank mostly reflects price, not demand. iPad (9th Generation) is first at $26.1M, only 2.1% of total revenue.

## 2. Geography

- **United States** is the largest market at $254.1M (20.1% of revenue). China ($117.6M) and Australia ($117.2M) are almost identical, followed by Japan ($102.6M).
- **Top cities are a three-way tie:** Dubai $67.95M, London $67.02M and Paris $66.52M, within about 2% of each other. Each of these cities has four stores.
- **Stores perform almost identically:** each of the 75 stores handled 2,720 to 2,972 transactions in 2023 (average 2,846). Revenue per store is $17.0M in Dubai, $16.8M in London and $16.6M in Paris, against a $16.8M average across all stores. The store with the most transactions is Apple Dubai Mall (ST-30, 2,972).
- **Data note:** different stores can share one name (for example, ST-58 and ST-69 are both "Apple The Dubai Mall"). Store-level queries group by `store_id`, not by `store_name`, otherwise those stores are merged into one row.

## 3. Warranty and service quality

- **HomePod mini stands out:** 144 claims, 1.6x the next product (Beats Fit Pro, 92). With 2,410 transactions, its claim rate is about 6.0%, more than double the 2.86% average.
- **Claims follow volume by category:** Accessories (963 claims, 15.8%) and Smartphone (848, 13.9%) have the most.
- **Time to claim is similar everywhere:** the average is 339 to 351 days across all ten categories (a spread under 4%). This measures how long customers wait before filing a claim, not time to failure, so it does not rank product reliability.
- **Half of the repair pipeline is open:** of the 6,109 claims, 25.4% are Pending, 25.1% In Progress, 24.5% Completed and 25.1% Rejected. That means 50.5% are still unresolved.
- **Caveat:** an almost even split across all four statuses is typical of synthetic data. With real data, I would first check how statuses are assigned.

## 4. Recommendations

1. **Review HomePod mini quality:** its claim rate is twice the average. Compare the claims by store or batch if the data allows it.
2. **Track repair completion as a KPI:** half of the 2023 claims are still open. Set an ageing target for Pending and In Progress cases.
3. **Do not pick expansion cities from city totals:** Dubai, London and Paris lead because each has four stores. Revenue per store is about the same everywhere ($16.6M to $17.0M in these cities), so this data does not show that any city is a better location.
4. **Prioritize margin over volume:** products sell at similar frequency, so price and margin drive revenue. This needs cost data, which the dataset does not include.
