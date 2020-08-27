/*  Sichten

eine Sicht besteht oft aus komplexen Abfragen

Sicht wird wie Tabelle behandelt


select * from sicht



*/


select * from (select * from orders where shipcity = 'London') t
where t.Freight < 10


create view vBestLondon
as
select * from orders where shipcity = 'London'


select * from vBestLondon --hier wird die ABfrage v. ob. ausgeführt

--Gründe für Sichten
--Megaabfrage: Joins über 10 Tabellen..praktisch.. kann man sich das Schreiben der Joins sparen
--Rechte: Sichten werden wie Tabellen behandelt.. können auch INS, UP, DEL verarbeiten, 
--und eig Rechte besitzten

--zB: Tabelle Angestellte (inkl Gehalt, GebDatum, Religion..)
--Verweigerung auf Tab Angestellte
--aber eine Sicht.. in der die sensiblen Daten fehlen!!..
--Recht auf Sicht erlauben.. und das geht


--Schema..



create table txy (id int, stadt int, land int)


insert into txy
	select 1,10,100
	UNION
	select 2,20,200
	union 
	select 3,30, 300

select * from txy

--Sicht, die alle Spalten und werte zurückgibt : v1

create view v1
as
select * from txy


select * from v1

alter table txy add Fluss int --Spalte dazu
update txy set fluss = id *1000 --Fluss hat 1000er


select * from v1 --Fluss ist nicht dabei...

alter table txy drop column Land

select * from v1

--darf gar nicht passieren, aber wie

create view v2 with schemabinding
as
select id, stadt, fluss from dbo.txy
--schemabinding zwingt zum exakten Arbeiten!!


alter table txy drop column fluss
--Objekt "v2" ist von Spalte "fluss" abhängig.
--jede Änderung, die die Sicht beeinflussen würde ist nicht machbar

alter table txy add spx int
alter table txy drop column spx
--das geht

create view KundeKauf
as
SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipName, 
                         Orders.ShipCity, Orders.ShipCountry, Employees.LastName, Employees.FirstName, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].OrderID, Products.ProductName, 
                         Products.UnitsInStock
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID

GO

select * from kundekauf

--Aufgabe: Welche Kunden hatten Bestellungen unter 10 Frachtkosten


select companyname, freight, orderid from Kundekauf where freight < 10 --soviele ?
--wir haben nur 91 kunden, 830 Orders, 2155 Positionen
select distinct companyname from kundekauf where freight  < 10 --78 Kunden

set statistics io, time on
--sicht verwendet jede Tabelle, die in der Sicht eben verwendet wird
--Plan 0,164 SQL Dollar



select distinct companyname from customers c inner join orders o
	on c.CustomerID=o.CustomerID
	where freight < 10


	--Tu nie eine sicht zweckentfremden

select distinct companyname from kundekauf where freight  < 10 --78 Kunden
























