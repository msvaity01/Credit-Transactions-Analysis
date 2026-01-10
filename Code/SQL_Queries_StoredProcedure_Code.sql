/* STORED PROCEDURE */

/*
1. Write a stored procedure that accepts a city name as input 
and returns the top 10 transactions (all columns) for that city ordered by transaction_date descending.
*/
create procedure dbo.usp_GetTop10TransactionByCity
	@CityName varchar(100)
as
begin
	set nocount on;
	select top 10
	*
	from CreditAnalysis1
	where city = @CityName
	order by transaction_date desc, transaction_id desc;
end;
go

--execute
exec usp_GetTop10TransactionByCity @CityName = 'Delhi';

/*
2. Write a stored procedure that takes a card_type 
and a year as parameters and returns the total spend per month for that card_type in that year.
*/
create procedure dbo.usp_GetMonthlySpendByCardTypeAndYear
(
	@CardType varchar(20),
	@Year int
)
as
begin
	set nocount on;

	select
		MONTH(transaction_date) as MonthNumber,
		DATENAME(MONTH, transaction_date) as [MonthName],
		SUM(amount) as TotalSpend
	from CreditAnalysis1
	where card_type = @CardType
		and YEAR(transaction_date) = @Year
	group by
		MONTH(transaction_date),
		DATENAME(MONTH, transaction_date)
	order by MonthNumber
end;
go

--execute
exec usp_GetMonthlySpendByCardTypeAndYear @CardType='Gold', @Year=2014;

/*
3. Write a stored procedure that accepts a minimum and maximum amount range 
and returns all transactions where the amount falls within that range, 
along with total count and total spend as output parameters.
*/
create proc usp_GetTransactionsByAmountRange
(
	@MinAmount decimal(18,2), --declare variables
	@MaxAmount decimal(18,2),
	@TotalCount int output,
	@TotalSpend decimal(18,2) output
)
as
begin
	set nocount on;

	select
		*
	from CreditAnalysis1
	where amount >= @MinAmount --cond.1
		and amount <= @MaxAmount --cond.2
	order by transaction_date desc, transaction_id desc;

	--set output parameters
	select
		@TotalCount = COUNT(*),
		@TotalSpend = SUM(amount)
	from CreditAnalysis1
	where amount >= @MinAmount
	and amount <= @MaxAmount
end
go

--execute
declare @Count int, @Total decimal(18,2);

exec usp_GetTransactionsByAmountRange
	@MinAmount = 50000,
	@MaxAmount = 200000,
	@TotalCount = @Count output,
	@TotalSpend = @Total output;

select @Count as TransactionCount, @Total as TotalSpend;

/*
4. Write a stored procedure that takes an expense type as input and returns, for each city, 
the percentage contribution of that city’s spend for that expense type to the total spend of that expense type.
*/

create proc usp_ExpenseTypeCityContribution
(
	@ExpenseType varchar(20)
)
as
begin
	set nocount on;
	
	with ExpenseSummary as(
		select
			city,
			SUM(amount) as CitySpend,
			SUM(SUM(amount)) over() as total_expense_spend
		from CreditAnalysis1
		where exp_type = @ExpenseType
		group by city
	)
	select
		city,
		CitySpend,
		total_expense_spend,
		CAST(ROUND((CitySpend * 100.0 / total_expense_spend),2) as decimal(10,2)) as percentage_contribution
	from ExpenseSummary
	order by percentage_contribution desc;
end
go

exec usp_ExpenseTypeCityContribution @ExpenseType = 'Entertainment';
go