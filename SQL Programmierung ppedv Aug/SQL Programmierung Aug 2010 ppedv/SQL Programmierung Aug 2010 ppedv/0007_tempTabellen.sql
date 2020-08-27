/*
temp Tabellen

#tabelle
lokale temp Tabelle

##tabelle
globale temp Tabelle


Gültigkeitsdauer
#t bis sie gelöscht wird, oder die Session beendet wird
##t bis sie gelöscht wird oder die Ersteller Session beendet wird
laufende Abfragen werden nicht unterbrochen


Gültigkkeitsbereich
#t existiert nur in der Session, in der sie erstellt wurde
##t gelten auch in anderen Sessions


--wir werden häufig loakle #tabellen bilden

--Einsatzgebiet:
--nö..


*/

select * into ##t1 from orders

select * from ##t1

drop table #t1



select	country, city, count(*) 
from	customers
group by 
		country, city 
order by 1,2

--hmmm wieviel sind es weltweit, in Österreich

--vorher 69

select	country, city, count(*) 
from	customers
group by 
		country, city with rollup
order by 1,2


select	country, city, count(*) 
from	customers
group by 
		country, city with cube
order by 1,2







select	country, city, count(*) as Anzahl into #LandStat
from	customers
group by 
		country, city with rollup
order by 1,2


select * from #LandStat-- redundante Daten

--weltweit

select * from #LandStat where country is null and city is null

select * from #LandStat where country = 'France' and city is null


--um Abfragen auf große Mengen zu vermeiden
--aber temp Tabelle ist eine Kopie der Daten.. also werden Änderungen der Kunden nie an #tab weitergegeben


--Komplexe Abfragen werden oft deutlich leichter, weil man die Abfrage eher schrittweise abarbeitet


--zb Suche die Bestellung mit geringsten Farchtkosten
--und die Bestellung mit höchsten Farchtkosten
--als ein Ergebnis

--1) #tabelle
--2) mit UNION
--orderid, minFracht
--orderid mit maxFrachtkosten


select orderid, max(freight) from orders group by orderid
union
select orderid, min(freight) from orders group by orderid


select orderid, freight from orders where freight = (select min(freight) from orders)
UNION ALL
select orderid, freight from orders where freight = (select max(freight) from orders)


select * from (
select top 1 orderid , freight from orders order by freight asc) t1
union all
select * from (
select top 1 orderid , freight from orders order by freight desc) t2





select orderid, max(freight) as Fracht into #result  from orders group by orderid

insert into #result
select orderid, min(freight) from orders group by orderid

select * from #result





