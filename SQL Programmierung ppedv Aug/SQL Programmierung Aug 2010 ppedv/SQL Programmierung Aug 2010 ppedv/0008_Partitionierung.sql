--Was ist schneller:

--T1 10000   T2 100000
--Abfrage, die liefert 10 Ergebniszeilen
--

--Salamitaktik

--Umsatztabelle seit 2000
--Idee wir machen kleiner Tabellen U2020 u2019 u2018
--die Anwendung muss aber weiterlaufen

create table u2020 (id int identity, jahr int)
create table u2019 (id int identity, jahr int)
create table u2018 (id int identity, jahr int)
create table u2017 (id int identity, jahr int)


--Anw: select * from umsatz

--Sicht


create view Umsatz
as
select * from u2020
UNION ALL
select * from u2019
UNION ALL
select * from u2018
UNION ALL
select * from u2017


select * from umsatz where jahr = 2019--hmm alle Tabellen

ALTER TABLE dbo.u2017 ADD CONSTRAINT
	CK_u2017 CHECK (Jahr=2017)

ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (Jahr=2019)

ALTER TABLE dbo.u2020 ADD CONSTRAINT
	CK_u2020 CHECK (Jahr=2020)
ALTER TABLE dbo.u2018 ADD CONSTRAINT
	CK_u2018 CHECK (Jahr=2018)

	--jede Art von Einschränken kann sich positiv auf Leistung auswirken


	select * from umsatz where id= 2019--jetzt wieder


create table best (id int, freight int not null)

--10 Mrd Zeilen
--select * from best where freight is null --perfekt ..keine Suche

--Partitionierte Sicht

--kann man auf Sichten INS UP DEL anwenden?

--kein INS möglich, wenn Pflichtfeld Ort nicht in Sicht enthalten ist
--wenn die Sicht JOINS enthält


insert into umsatz (id,jahr) values (1,2018)

--es muss ein PK vorhanden sein, der die Datensätrze eindeutig über die Sicht macht
--und es darf kein Identity Wert mehr vorhanden sein --ohje Anwendung geht nicht mehr


select * from u2018
select * from umsatz where jahr = 2018

--Einsatzgebiet Nr1: Archivdaten

--Problem lösen für id Werte
--max(id)--doof---


CREATE SEQUENCE uID 
 START WITH 2
 INCREMENT BY 1

select next value for uid

--
insert into umsatz (id,jahr) values  (next value for uid,2017)

select * from umsatz


--am Ende für aktive System keine schöne Lösung

--Dateigruppe

--Tabellen liegen normalerweise auf der .mdf Datei
create table txyz (id int) on Dateigruppe

--Dateigruppe ist ein Alias für den Ort und Dateinamen  c:\Program Files\....\..db.mdf

create table txyz(id int) on HOT


--Partitionierung 


------------100---------------200-------------------
--   1              2                 3


--4 DGruppen: bis100, bis200 rest, bis5000


--Part-F()

create partition function fZahl(int)
as
RANGE LEFT FOR VALUES (100,200)


select $partition.fzahl(117) --2


--Part Scheme

create partition scheme schZahl
as
partition fzahl to (bis100, bis200, rest) --es sind 15000 Daateigruppen/Bereiche möglich
---                   1       2      3

create table ptab (id int identity, nummer int, spx char(4100)) on schZahl(nummer)


declare @i as int = 0

while @i < 20000
	begin
		insert into ptab values (@i, 'XY')
		set @i+=1
	end

--bringts?
--PLAN ? Statistiken
set statistics io, time on 
select * from ptab where nummer = 117 --100
select * from ptab where id = 117 --20000 Seiten und messbar ms

select * from ptab where nummer = 117 --
select * from ptab where id = 117 

--PLAN: gut im Plan SEEK.. eher schlecht im PLAN  SCAN

--jede
select * from tabelle where 1=0

--> IO senken --> RAM + ---> CPU sinkt


select * ...-- 100MB 




--neue Grenze,, alte Grenze,, neue Grenze ,, andere Grenze raus..

--wie geht das jetzt eigtl?

CREATE PARTITION SCHEME [schZahl] AS PARTITION [fZahl] TO ([bis200], [bis5000], [rest])
GO
USE [Northwind]
GO

CREATE PARTITION FUNCTION [fZahl](int) AS RANGE LEFT FOR VALUES (333, 7777)
GO


select * from ptab where id = 11

--Daten rausnehmen--> Archivieren


--Befehl für das Verschieben von Daten
--Kopieren und löschen.. gibt kein verschiebebefehl
--ausser bei der Partionierung

create table archiv(id int not null, nummer int, spx char(4100)) on bis200

alter table ptab switch partition 1 to archiv

select * from archiv














Grid: 6 Spalten (20 Spalten )
--Was aber wenn die Verteilung nicht mehr reicht

---neue Grenze bei 5000

-----------------100--------------200----------------------------

--Tabelle, F(), Scheme

--Reihenfolge: zuerst Scheme, dann f()

--für den Fall der Fälle....
alter partition scheme schZahl next used bis5000
--es hat sich noch nichts geändert


select $partition.fzahl(nummer), min(nummer), max(nummer), count(*) from ptab
group by  $partition.fzahl(nummer)

alter partition function fzahl() split range(5000)


--Grenze muss weg... 100

--Tabelle, F(), Scheme

--zuerst nur funktion

alter partition function fzahl() merge range(100)

---Sinnvoll.. für sehr große Tabellen: 

--angenommen.. 100MB/sek auf der HDD
--Archivdaten: 10000 PB.. wie lange hätte das Verschieben gedauert: 10 Sek ... ca 0 sek
alter table ptab switch partition 1 to archiv


--Edition Std Ent/ Version  2019 Ent

--gut ist es wenn: SQL 2016 + Sp1 oder höher...


---besth Tabellen












--Datum datetime -- Jahresweise
create partition function fZahl(date) --ms
as
RANGE LEFT FOR VALUES ('31.12.2019','','')

---------------2016---------2019----------

--- abisg  hbisr sbisz
create partition function fZahl(varchar(50)) --ms
as
RANGE LEFT FOR VALUES ('g','')


-------------H---------------------S----------------

G
GA
GE




create partition scheme schZahl
as
partition fzahl to ([Primary], [Primary], [Primary])







