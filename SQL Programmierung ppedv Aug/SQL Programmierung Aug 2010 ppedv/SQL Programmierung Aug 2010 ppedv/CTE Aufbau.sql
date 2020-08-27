--welche--cte

WITH CTENAME (Spalten,..)
AS
(Ergebnismenge auf die später verweisen wird)
Select * from CTENAME

--einfachste CTE


	(Select companyname, country, city from customers)
Select * from Kunden

---

WITH KundenFrachtkosten (Firma,Fracht)
as
(select companyname as firma, freight as fracht from customers c inner join	
orders o on c.CustomerID=o.CustomerID)
Select Firma, fracht from KundenFrachtkosten

--Summe der Frachtkosten
WITH KundenFrachtkosten (Firma,Frachtsumme)
as
(select companyname as firma, freight as fracht from customers c inner join	
orders o on c.CustomerID=o.CustomerID)
Select Firma,sum( frachtsumme) from KundenFrachtkosten group by Firma


--Hierachische Abfragen
WITH CTE (Spalten)
AS
(Select --Basis
UNION ALL
Select --Rekursion auf Basis
)
select .. CTE


with CTEANG (id, nachname, Ebene)
as 		
(select employeeid as id, lastname as nachname, 0 as ebene 
from employees where reportsto is null

UNION ALL

select employeeid, lastname, Ebene+1 from employees e
inner join cteang on cteang.id = e.reportsto
)
select * from cteang;



create table Abteilungen
	(Abteilung varchar(50), UebergeordneteAbt varchar(50))


insert into Abteilungen values
	('Vorstand', NULL),
	('Produktion', 'Vorstand'),
	('Einkauf', 'Vorstand'),
	('Verkauf', 'Vorstand'),
	('Verkauf Inland', 'Verkauf'),
	('verkauf ausland', 'Verkauf'),
	('Finanzen', 'Vorstand'),
	('Controlling', 'Finanzen'),
	('Finanzbuchhaltung', 'Controlling'),
	('Lohnbuchhaltung', 'Controlling')


With Abts (Abteilung, UebergeordneteAbt)
as
(
	Select Abteilung, UebergeordneteAbt as Hauptabteilung 
		from abteilungen where UebergeordneteAbt ='Vorstand'
	UNION ALL
	select a.Abteilung, a.UebergeordneteAbt 
			from abteilungen a 
				inner join abts 
			on a.UebergeordneteAbt=abts.Abteilung)
select * from abts 











