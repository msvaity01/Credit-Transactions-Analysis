--table
select * from [dbo].[CreditAnalysis1]
order by transaction_date
go

/* 1. Write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends */

with CitySpends as(
	select
		city,
		SUM(cast(amount as decimal(18,2))) as TotalSpend
	from CreditAnalysis1
	group by city
)
select top 5
	city,
	TotalSpend,
	FORMAT(
		(TotalSpend*100/SUM(TotalSpend) over()), 'N2' --over() calculates all the total
	) as PercContribution
from CitySpends
order by TotalSpend desc;
go

/* 2. Write a query to print highest spend month and amount spent in that month for each card type */

with MonthSpend as(
	select
		month(transaction_date) as txn_month,
		year(transaction_date) as txn_year,
		card_type,
		sum(amount) as TotalSpend,
		ROW_NUMBER() over (partition by card_type order by sum(amount) desc) as rn
	from CreditAnalysis1
	group by card_type, MONTH(transaction_date), YEAR(transaction_date)
)
select
	card_type,
	txn_month,
	txn_year,
	TotalSpend
from MonthSpend
where rn = 1
order by card_type
go

/* 3. Write a query to print the transaction details(all columns from the table) for each card type when it reaches a cumulative of 10,00,000 total spends */

with RunningTotal as(
	select
		*,
		SUM(amount) over(
			partition by card_type
			order by transaction_date, transaction_id
			rows unbounded preceding
		) as cumulative_spend
	from CreditAnalysis1
),
Ranked as(
	select
		*,
		ROW_NUMBER() over(
			partition by card_type
			order by cumulative_spend
		) as rnk
	from RunningTotal
	where cumulative_spend >= 1000000
)
select
	transaction_id,
	city,
	transaction_date,
	card_type,
	exp_type,
	gender,
	amount
from Ranked
where rnk=1;
go

/* 4. Write a query to find city which had lowest percentage spend for gold card type */

with TotalGoldSpend as(
	select
		city,
		SUM(amount) as gold_spend
	from CreditAnalysis1
	where card_type = 'Gold'
	group by city
),
CityGoldSpend as(
	select
		city,
		SUM(amount) as city_total_spend
	from CreditAnalysis1
	group by city
)
select top 1
	g.city,
	g.gold_spend,
	c.city_total_spend,
	CAST(
		ROUND(g.gold_spend*100.0/c.city_total_spend,2) as decimal(10,2)) as gold_spend_perc
from TotalGoldSpend as g
inner join CityGoldSpend as c
on g.city = c.city
order by gold_spend_perc asc;
go

/* 5. Write a query to print 3 columns: city, highest_expense_type , lowest_expense_type */
go
with SpendInCity as(
	select
		city,
		exp_type,
		sum(amount) as TotalSpend
	from CreditAnalysis1
	group by city, exp_type
), 
Ranked as(
	select
		city,
		exp_type,
		TotalSpend,
		ROW_NUMBER() over(partition by city order by TotalSpend desc) as rn_high,
		ROW_NUMBER() over(partition by city order by TotalSpend asc) as rn_low
	from SpendInCity
)
select
	city,
	MAX(case when rn_high = 1 then exp_type end) as highest_expense_type,
	MIN(case when rn_low = 1 then exp_type end) as lowest_expense_type
from Ranked
group by city
order by city
go

/* 6. Write a query to find percentage contribution of spends by females for each expense type */

select
	exp_type,
	CAST(ROUND(100.0 * SUM(case when gender = 'F' then amount end) / SUM(amount),2) as decimal(5,2)) as contribution_by_females
from CreditAnalysis1
group by exp_type
go

/*  7. Which card and expense type combination saw highest month over month growth in Jan-2014 */

with GrowthSlot as(
	select
		card_type,
		exp_type,
		MONTH(transaction_date) as trans_month,
		YEAR(transaction_date) as trans_year,
		SUM(amount) as spend
	from CreditAnalysis1
	where 
		(MONTH(transaction_date)=1 and YEAR(transaction_date)=2014)
		or
		(MONTH(transaction_date)=12 and YEAR(transaction_date)=2013)
	group by
		card_type, exp_type, MONTH(transaction_date), YEAR(transaction_date)
),
PrevMonth as(
	select 
		*,
		lag(spend,1) over(
			partition by card_type, exp_type
			order by trans_year
			) as prev_month_spend
	from GrowthSlot
)
select top 1
	*,
	cast(round(100.0*(spend-prev_month_spend)/prev_month_spend,2) as decimal(10,2))as MoM_growth_perc
from PrevMonth
order by MoM_growth_perc desc;
go

/* 8. During weekends which city has highest total spend to total no of transactions ratio */

with WeekendData as(
	select
		city,
		amount,
		DATENAME(weekday, transaction_date) as weekend
	from CreditAnalysis1
	where DATENAME(weekday, transaction_date) in ('Saturday','Sunday') --weekend only
),
CityWeekendAgg as(
	select
		city,
		SUM(amount) as total_weekend_spend,
		count(*)    as total_weekend_txn
	from WeekendData
	group by city
),
CityWeekendRatio as(
	select
		city,
		total_weekend_spend,
		total_weekend_txn,
		CAST(
			1.0*total_weekend_spend/total_weekend_txn as decimal(18,2)
		) as spend_per_txn_ratio
	from CityWeekendAgg
)
select top 1
	city,
	total_weekend_spend,
	total_weekend_txn,
	spend_per_txn_ratio
from CityWeekendRatio
order by spend_per_txn_ratio desc;

/*  9. Which city took least number of days to reach its 500th transaction after the first transaction in that city */

with CitySequenced as(
	select
		city,
		transaction_date,
		transaction_id,
		ROW_NUMBER() over(
			partition by city
			order by transaction_date, transaction_id
		) as txn_seq
	from CreditAnalysis1
),
City500th as(
	select
		city,
		MIN(case when txn_seq=1 then transaction_date end) as first_txn_date,
		MAX(case when txn_seq=500 then transaction_date end) as txn_500_date
	from CitySequenced
	group by city
	having MAX(case when txn_seq = 500 then transaction_date end) is not null
)
select top 1
	city,
	DATEDIFF(day, first_txn_date, txn_500_date) as day_to_500th_transaction
from City500th
order by day_to_500th_transaction asc;
go