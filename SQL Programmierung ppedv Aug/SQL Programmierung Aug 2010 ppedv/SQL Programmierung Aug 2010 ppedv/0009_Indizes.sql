/*
Clustered IX x
Non Clustered IX x 
----------------------
eindeutigen IX x
zusammengesetzten IX  x
gefilterten IX enthält icht alle DS ..macht Sinn wenn es zu weniger Ebenen kommt
IX mit eingeschl Spalten  x--> abdeckender IX
abdeckender IX x (idealer IX passend hzur Abfrage: kein Lookup, kein SCAN)
partionierter IX x macht Sinn bei sehr sehr großen Tabellen VLDB
Ind Sicht x
realer hypothetischer IX x   dta_ix_ unsichtbar, unsere ABfragen verwenden diese nicht (für ein Tool)
-------------------------
Columnstore IX x

*/

--es ist egal, ob wir 1 MIO oder 50 MIO..solnage die Ebenen des IX gleich bleiben
--gibt es keinen UNterschied




select * from customers

insert into customers (customerid, companyname) values ('ppedf', 'apedv ag')

select * into o2 from orders

select * from o2


select * from auftrag -- SCAN od SEEK... ohne where scan---CL IX--
--PK wird per default immer als CL IX eingesetzt
--PK möchte einfach nur eindeutig sein

select * from orders
--weil der PK hier als Orderid gruppiert implementiert wurde
--haben wir bei Bereichsabfragen viel häufiger SCANs als SEEK


--Regel1: lege zu Beginn gleich den gruppierten IX fest..





select * into k1 from kundekauf

--wiederholen bis ca 1MIO in der Tabelle enthalten sind
insert into k1
select * from k1

--Kopie zum Spielen
select * into k2 from k1

alter table k2 add id int identity-- Spalte mit eindeutigen Wert


set statistics io, time on -- Anzahl der Seiten, CPU ms und Dauer ms
select id from k2 where id = 100 --Heap..kein IX.. Table SCAN
--62 000 Seiten --300ms CPU... 50ms

--CL IX auf: OrderDate

-- NCLIX_ID
select id from k2 where id = 100 --SEEK auf NCL
--3 Seiten... 0 ms

select id, city from k2 where id = 100 --NCLIX SEEK  mit Anruf (Lookup)


select id, city from k2 where id < 11950  --etwas über 1% Treffer.. dann SCAN


--Besser: City mit ins Telefonbuch
select id, city from k2 where id = 100 --Lookup muss weg.. 3Seiten.. perfekt

select id, city from k2 where id< 12000 --auc hier nur 3 Seiten..cool!

--aber hier:
select id, city, country from k2 where id = 100

--Country mit in IX rein...ist nicht so toll: zusammengesetzter IX kann nur max 16 Spalten haben, 
--Schlüssel darf nicht mehr als 900 byte

--NCLIX_ID_inkl_CICY --bis zu 1000 Spalten 

select top 3 * from k2

select companyname, sum(unitprice*quantity) from k2 
where freight < 1
group by companyname

--Wie lautet der ideale IX

--bei or im where steigt SQL Server aus...
select companyname, sum(unitprice*quantity) from k2 
where freight < 1 and unitsinstock < 5
group by companyname

--NIX_FR_i_CNameUPQU
--NIX_USTOCK_i_CNameUPQU

--alle Spalten des Where in IX Schlüsselspalten
--alle spalten des select int eingeschl Spalten

select companyname, sum(unitprice*quantity) 
from k2 
where (freight < 1 and unitsinstock < 5) or employeeid = 2
group by
	companyname


select companyname, sum(unitprice*quantity) 
from k2 
where freight < 1 and ( unitsinstock < 5 or employeeid = 2)
group by
	companyname


--nix---


select country, count(*) as anzahl from k2
group by country

create view vdemoxy
as
select country, count(*) as anzahl from k2
group by country

select * from vdemoxy

alter view vdemoxy with schemabinding
as
select country, count_big(*) as anzahl from dbo.k2
group by country

--ABER: count_big muss drin sein-- Ergebis der Sicht.. Spalten müssen eindeutig (Land)
--schemagebunden...


--Annahme: wir haben 1 BIO DS--> Umsatz pro Land.. --> ind Sicht-- wieviele Seiten müssen wir lesen?
--Länder? 200

--ind Sicht besteht aus 200 Zeilen mit Land udn dessen Umsatz--> 2 Seiten..

--aber es gibt ja noch andere IX.. ;-)


--gefilterter IX

--was wäre, wenn wir nicht alle DS in den IX mit aufnehmen


select Lastname from k2 where city = 'Berlin' and freight < 2

--CITY COUNTRY

USE [Northwind]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [NonClusteredIndex-20200416-153035]    Script Date: 16.04.2020 15:33:22 ******/
CREATE NONCLUSTERED INDEX [NIX_ALLES] ON [dbo].[k2]
(
	[Freight] ASC,
	[City] ASC
)
INCLUDE([LastName]) 







select * into k3 from k2

select * into k4 from k2

--beide haben keine Indizes


--Heap


select top 3 * from k3
--where und Aggregate

--Summe der Frachtkosten pro Kunde  für Shipcountry = UK



--idealer IX: NCL_Scountry_inkl_freight_CName
select companyname, sum(freight) from k3 where shipcountry = 'UK' group by companyname

--Seiten: 551 -- Dauer ca 50ms

set statistics io, time on


--2 ms
select companyname, sum(Unitsinstock) from k4 where shipcity = 'London' group by companyname

--wie geht das..?

--er schätzt? Nöööö
--k3 360MB Daten und 80 MB IX

--3,6 MB k4

--a) das stimmt  b) das stimmt nicht

--wenn das also stimmt, was muss dann passiert sein--> komprimiert

--wieso mach ich das nicht immer...


--Columnstore IX Gruppiert = Tabelle.. Seit sql 2014 sind die Tabellen auch updatebar
--optimiert auf CPU Last 









--Auswirkungen:

--HEAP.. wir ändern einen DS von 1 Mio
--User klagen, dass sie nicht auf die Tabelle zugreifen können

begin tran
update customers set city = 'Berlin' where customerid = 'BLAUS' --Sperre: X
rollback

--







































