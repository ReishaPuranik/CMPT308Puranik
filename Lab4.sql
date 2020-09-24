select *
from People 
where pid in (select pid
			  from Customers);


select *
from People 
where pid in (select pid
			  from Agents);
   
   
select *
from People 
where pid in (select pid 
			  from Customers) 
		and pid in (select pid from Agents);
      
      
select *
from People 
where not pid in (select pid 
			       from Customers) 
	          and not pid in (select pid from Agents);
             
             
select pid
from Customers 
where pid in (select custId from Orders 
			  where prodId = 'p01' or custId in 
			  (select custId from Orders where prodId ='p07'));
             
             
select pid
from Customers 
where pid in (select custId from Orders 
			  where prodId = 'p01' and custId in 
			  (select custId from Orders where prodId ='p07'))
order by pid desc;


select firstName, lastName
from people
where pid in (select AgentId from Orders 
			  where prodId = 'p05' or AgentId in 
			  (select AgentId from Orders where prodId ='p07')) 
order by lastName desc;


select homecity, DOB
from people
where pid in (select AgentId
			 from Orders
			 where custId = '001')
order by homecity asc;


select prodId from orders
where agentId in (
select agentId from orders
where quantityOrdered >=1 and custId in (select pid from people
										where homecity = 'Toronto' and pid in (
										select pid from customers)))
order by prodId desc;


select lastName, homecity
from People
where pid in (select custId from Orders where agentId in 
			  (select pid from people where homecity = 'Teaneck' or homecity = 'Santa Monica' and pid in 
			   (select pid from Agents)));