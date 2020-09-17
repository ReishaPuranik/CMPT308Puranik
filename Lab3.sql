select ordernum, totalusd
from Orders;

select lastname, homecity
from People
where prefix = 'Dr.';

select prodId, name, priceusd
from Products
where ptyonhand > 1007;

select firstname, homecity
from People
where dob is >= ’1950-01-01’ and dob <= ’1959-12-31’;

select lastname
from People
where prefix != ‘Mr.’;

select * 
from Products
where city != ‘Dallas’ and city != ‘Duluth’ and priceusd >= 3;

select *
from Orders
where dateordered >= ‘2020-03-01’ and dateordered <= ‘2020-03-31’;

select *
from Orders
where dateordered >= '2020-02-01' and dateordered <= '2020-02-30' and totalusd >= ‘20000’;

select *
from Orders
where custid='007';

select *
from Orders
where custid ='005';