/* 1 */
select *
from People p 
     inner join
	 Customers c
on (p.pid = c.pid);


/* 2 */
select *
from People p 
     inner join
	 Agents a
on (p.pid = a.pid);


/* 3 */
select *
from People p inner join Customers c on p.pid = c.pid 
 		      inner join Agents    a on p.pid = a.pid;


/* 4 */
select firstname
from People 
where pid in 	 (select pid from Customers 
where pid not in (select custId from orders));

/* 5 */
select firstname
from People p inner join Customers c on p.pid = c.pid
   			left outer join Orders o on c.pid = o.custId;

/* 6 */
select pid, commissionPct
from Agents a inner join Orders o on a.pid = o.agentId
where o.custId = '008'
order by commissionPct ASC;


/* 7 */
select lastName, homeCity
from People inner join Agents on people.pid = agents.pid
			left join Orders o on o.custId = '001';
 
 
/* 8 */
select p.lastName, p.homeCity
from People p inner join Customers c on p.pid = c.pid
			  inner join Products pr  on pr.city = p.homeCity
where pr.city in (select city from Products
				  group by city having count(*) =1);


/* 9 */
select prodId, name 
from Products
where prodId in (select prodId from Orders where agentId in 
				(select agentId where custId in 
				(select pid from People where homeCity = 'Chicago')))
order by name ASC;


/* 10 */
select firstName, lastName, p.pid
from People p
left join Agents a on a.pid = p.pid
left join Customers c on c.pid = a.pid; 
