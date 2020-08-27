--Dateigruppen


--verteile Daten auf versch Datenträger (HOT and Cold Data)

create table tabelle1 (id int) ON Dateigruppe


--_Dateigruppe: eine weitere Datendatei (.ndf)   Dateigruppe synonym für Pfad und Dateiname:  c:\prgramme....\..ndf

create table Archivtabelle (id int) on ARCHIV

--Wie kann ich Tabellen auf anderen Dateigruppen schieben..?


---Besser mit Salamitaktik


--Tabellen in kleine Teile schustern...


--UMSATZ..Idee.. kleine Tabellen sind schneller



--Statt UMSATZ besser u2020, u2019, u2018, u2017


create table u2020 (id int identity, jahr int, spx int)

create table u2019 (id int identity, jahr int, spx int)

create table u2018 (id int identity, jahr int, spx int)

create table u2017 (id int identity, jahr int, spx int)





create view Umsatz
as
select * from u2020
UNION ALL
select * from u2019
UNION ALL
select * from u2018
UNION ALL
select * from u2017


--UNION ALL.. keine Suche nach doppelten

select * from umsatz where jahr = 2019

--wie kann man das messen? besser, schlechter..: einfachster Weg: PLAN

--bishrer muss man alle Tabellen durchgehen... nix besser!!

ALTER TABLE dbo.u2020 ADD CONSTRAINT
	CK_u2020 CHECK (jahr=2020)


ALTER TABLE dbo.u2017 ADD CONSTRAINT
	CK_u2017 CHECK (jahr=2017)


ALTER TABLE dbo.u2018 ADD CONSTRAINT
	CK_u2018 CHECK (jahr=2018)

	
ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (jahr=2019)


select * from umsatz where jahr = 2019


--Select ist besser.. aber geht über eine Sicht auch INS UP DEL?


insert into umsatz (id,jahr, spx) values (1,2019, 100)

--PK muss vorhanden sein eindeutigkeit über alle tabellen. ID reicht nicht aus

--boahh.. krass: Anwendung geht nicht mehr da neuer PK und vor allem, identity ist weg..

--bis dahin: ok für Archivdaten, aber nicht für Live"umsatz"Daten

--Sequenzen


CREATE SEQUENCE [dbo].[seqID] 
 START WITH 2
 INCREMENT BY 1



 select next value for seqID


 1 2 3 4 5 6  8  10


 insert into umsatz (id,jahr, spx) values (next value for seqID,2020, 100)

 select * from umsatz


 --1019075760
 --






 --was ist schneller: TabA oder TabB
 --beide sind identisch
 --TabA hat 10000 Zeilen und TabB hat 100000..



 create database partitionsDB

 --Wir brauchen 4 Dateigruppen: bis100, bis200, bis5000, rest

 --partitionierungsfunktion

 -- -------------100-------------200-------------------------- int
 --       1                 2                  3

 create partition function fZahl(int)
 as
 RANGE LEFT FOR VALUES (100,200);
 GO

 select $partition.fzahl(117)



 --max 15000 Bereiche möglich
 --Bereichen = Anzahl der Grenzen +1


 create partition scheme schZahl
 as
 partition fzahl to (bis100,bis200, rest)

--------------------    1      2      3



create table ptab (id int identity, nummer int, spx char(4100)) 












 --Abfragen ergibt 10 Datenzeilen: A 


 --Nächste Ziel ist: es soll bei einer tabelle bleiben... nichts auf der logischen Ebene, sondern auf der pyhsik!!

 --Partitionierung! war allerdings bis SQL 2016 Ent, aber seit SQL 2016 SP1 auch in Express Version







