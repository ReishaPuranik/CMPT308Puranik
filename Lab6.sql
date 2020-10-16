/* 1 */
select city, count(*) as city_amount
from Products 
group by city having count(*) = (select max(city_amount) from
								(select city, count(*) as city_amount
from Products group by city) Products);


/* 2 */
select name
from Products
where priceUSD > any (select avg (priceUSD) from Products)
order by name DESC;


/* 3 */
select distinct lastName, o1.prodId, o1.totalUSD
from People p inner join Customers c on p.pid = c.pid
              inner join Orders o1 on c.pid = o1.custId
              inner join Orders o2 on o1.prodId = o2.prodId
              inner join Orders o3 on o1.totalUSD = o3.totalUSD
where EXTRACT (month from o1.dateOrdered) = 3
Order by totalUSD DESC;


/* 4 */
select distinct p.lastName, o2.quantityOrdered
from People p inner join Customers c on p.pid = c.pid
			  inner join Orders o1 on p.pid = c.pid
			  inner join Orders o2 on c.pid = o2.custId
			  inner join People p1 on p1.pid = o2.custId
order by p.lastName DESC;


/* 5 */
select p.firstName as customerFirstName,
		p.lastName as customerLastName,
		p1.firstName as agentFirstName,
		p1.lastName as agentLastName, 
		pr.name as productName from Customers c inner join Orders o on c.pid = o.custId
                                                inner join Products pr on o.prodId = pr.prodId
												inner join People p on c.pid = p.pid
												inner join People p1 on o.agentId = p1.pid where p1.homeCity = 'Teaneck';                                                

/* 6 */
select * 
from Orders o
inner join Products p on p.prodId = o.prodId
inner join Customers c on c.pid = o.custId
where totalUSD != ANY (select ROUND((o.quantityOrdered*p.priceUSD)-(o.quantityOrdered*p.priceUSD)*(c.discountPct/100),2)
					  from Orders)	


/* 7 */
select firstName, lastname
from People 
where pid in (select pid from Customers) 
  and pid in (select pid from Agents);


/* 8 */
DROP VIEW PeopleCustomers;		
CREATE VIEW PeopleCustomers
as 
select p.pid, p.prefix, p.firstName, p.lastName, p.suffix, p.homeCity, p.DOB, c.pid as custPid, c.paymentTerms, c.discountPct
from People p full outer join Customers c on p.pid = c.pid;

DROP VIEW PeopleAgents;	
CREATE VIEW PeopleAgents
as 
select p.pid, p.prefix, p.firstName, p.lastName, p.suffix, p.homeCity, p.DOB, a.pid as agentPid, a.paymentTerms, a.commissionPct 
from People p full outer join Agents a on p.pid = a.pid;


select * from PeopleCustomers; 
select * from PeopleAgents;


/* 9 */
select firstName, lastName
from PeopleAgents
where agentPid = ANY(select custPid from PeopleCustomers);


/* 10 */
/* The query from 7 and the query from 9 are very similar due to the fact that you get the same output. For 7, the query is scanning the whole CAP database as it normally would to get the result. It finds the columns firstname and lastname from the people table with the specified constraints in order to get the output. In 9, the query is processed through the created view from the system catalog. Internally, it processes 9 from this system catalog because that is where the views are stored and then goes through the whole CAP database from this view to get the result. */


/* 11 */
/* A left outer join is different from a right outer join because they both get different outputs and different information. A left outer join includes unmatched rows from the left of the table. The right out join inlcudes matching rows and unmatched rows from the right side of the table. For example, when doing the output for a left outer join like this: */

select * 
from People p left outer join Customers c on p.pid = c.pid;

/* you get all the people data for the pid's of 1, 4, 5, 7, 8, 2, 6, 3, and 9 in that order. This is all the matching data and the unmatching data on the left side of the table. When doing the output for a right outer join like this: */

select * 
from People p right outer join Customers c on p.pid = c.pid;

/* you get all the people data for the pid's of 1, 4, 5, 7, and 8 in that order. Since this is all the matching data and there is no other data on the right side, it just returns this. */


