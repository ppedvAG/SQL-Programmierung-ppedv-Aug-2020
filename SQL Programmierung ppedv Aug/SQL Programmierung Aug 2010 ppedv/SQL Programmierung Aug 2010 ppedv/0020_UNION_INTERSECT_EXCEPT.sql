select customerid, country, city into KundenEU from customers where country in ('Italy', 'Germany', 'Austria')

insert into kundeneu values ('ppedv', 'Germany', 'Burghausen')

update customers set city = 'Karlsruhe' where customerid = 'ALFKI'

--ACCESS-Problem

--Wie finide ich jetzt die gemeinsamen DAtensätze und die unterschiedlichen heraus?

select customerid, country, city from kundeneu
UNION
select customerid, country, city from customers

select * from customers c inner join kundeneu on c.customerid =k.customerid and c.country = k.country and ..




select customerid, country, city from kundeneu
INTERSECT
select customerid, country, city from customers


select customerid, country, city from customers
INTERSECT
select customerid, country, city from kundeneu


select customerid, country, city from customers
except
select customerid, country, city from kundeneu


select customerid, country, city from KundenEU
except
select customerid, country, city from Customers

