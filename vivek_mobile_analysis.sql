--SQL Advance Case Study


--Q1--BEGIN 


	select  l.[State],d.[DATE],c.Customer_Name

	from FACT_TRANSACTIONS f
	full join DIM_LOCATION l
	on l.IDLocation=f.IDLocation
	full join DIM_CUSTOMER c
	on c.IDCustomer=f.IDCustomer
	full join DIM_DATE d
	on d.DATE=f.Date

	where d.[YEAR] >= 2005


--Q1--END

--Q2--BEGIN
	
	select l.state,SUM(f.quantity)AS TOTAL_QUANTITY

	from FACT_TRANSACTIONS f
	FULL join DIM_LOCATION l
	on f.IDLocation=l.IDLocation
	FULL join DIM_MODEL mo
	on mo.IDModel=f.IDModel
	FULL join DIM_MANUFACTURER m
	on m.IDManufacturer=mo.IDManufacturer

	where m.Manufacturer_Name='SAMSUNG'
	and  l.Country='US'
	group by l.STATE
	ORDER BY 2 DESC
	

--Q2--END

--Q3--BEGIN      
	
	select l.State,l.ZipCode,mo.Model_Name, count(f.totalprice)as no_of_transaction

	from FACT_TRANSACTIONS f
	full join DIM_LOCATION l
	on f.IDLocation=l.IDLocation
	full join DIM_MODEL mo
	on mo.IDModel=f.IDModel

	group by l.State,l.ZipCode,mo.Model_Name

--Q3--END

--Q4--BEGIN

		select mo.Model_Name,mo.Unit_price,m.Manufacturer_Name

		from DIM_MODEL mo
		full join DIM_MANUFACTURER m
		on m.IDManufacturer=mo.IDManufacturer

		where mo.Unit_price= (select min(Unit_price) from DIM_MODEL)

--Q4--END

--Q5--BEGIN

			select top 5 m.Manufacturer_Name,mo.Model_Name, SUM(f.quantity) as total_quantity, AVG(mo.unit_price)as avg_unit_price

			from FACT_TRANSACTIONS f
			join DIM_MODEL mo
			on mo.IDModel=f.IDModel
			join DIM_MANUFACTURER m
			on m.IDManufacturer=mo.IDManufacturer
			group by mo.Model_Name,m.Manufacturer_Name
			order by 4 desc
           
			--Q5--END

--Q6--BEGIN
			
			select c.Customer_Name, AVG(f.totalprice)as avg_amountspent_2009

			from FACT_TRANSACTIONS f
			 join DIM_CUSTOMER c
			on c.IDCustomer=f.IDCustomer
			join DIM_DATE d
			on d.DATE=f.Date
			
			where d.YEAR= 2009
			 GROUP BY c.Customer_Name
				HAVING AVG(f.TotalPrice) > 500;


--Q6--END
	
--Q7--BEGIN  
	    
		   select top 5 mo.Model_Name, SUM(f.quantity)as total_quantity

		   from FACT_TRANSACTIONS f
		    join DIM_MODEL mo
		   on mo.IDModel=f.IDModel
		   join DIM_DATE d
		   on d.DATE=f.Date

		   where d.YEAR in (2008 ,2009, 2010)
		   group by mo.Model_Name
		   order by 2 desc
	

--Q7--END	
--Q8--BEGIN
			 
					WITH ranked_data AS(
					SELECT 
					m.Manufacturer_Name,
					d.YEAR, 
					SUM(f.Quantity) AS total_quan,
					RANK() OVER(
								PARTITION BY d.year
								ORDER BY sum(f.Quantity) DESC
								) AS rank
					from FACT_TRANSACTIONS f 
					JOIN  DIM_MODEL mo
					ON f.IDModel=mo.IDModel
					JOIN DIM_MANUFACTURER m 
					ON m.IDManufacturer=mo.IDManufacturer
					JOIN DIM_DATE d
					ON f.Date=d.Date
					WHERE d.YEAR IN (2009,2010) 
					GROUP BY d.YEAR, m.Manufacturer_Name
					)
					SELECT YEAR, Manufacturer_Name,total_quan
					FROM ranked_data
					where rank=2


--Q8--END
--Q9--BEGIN
	
	select m.Manufacturer_Name,mo.Model_Name,d.YEAR

	from FACT_TRANSACTIONS f
	join DIM_DATE d
	on d.DATE=f.Date
	join DIM_MODEL mo
	on mo.IDModel=f.IDModel
	join DIM_MANUFACTURER m
	on m.IDManufacturer=mo.IDManufacturer

	where d.YEAR=2010 and d.YEAR <> 2009


--Q9--END

--Q10--BEGIN
	
	select top 100 AVG(f.totalprice)as avg_spend, AVG(f.quantity)as avg_quantity,c.Customer_Name,d.YEAR

	from FACT_TRANSACTIONS f
	join DIM_CUSTOMER c
	on c.IDCustomer=f.IDCustomer
	join DIM_DATE d
	on d.DATE=f.Date
	group by c.Customer_Name,d.YEAR
	order by 1 desc


















--Q10--END
	