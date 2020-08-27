--Indizes


------------------------------------------------
/*
gruppierter  x   = pyhsikal. sortierte Tabelle
nicht gruppierter ..x
---------------------------------
eindeutigen, Unique ..x  IX Schlüsselspaltenwert nur einmal
zusammengesetzter ...x mehrere Schlüsselspalten
IX mit eingeschlossenen Spalten ...x  Statt alle Werte in den IX Baum zu bringen
				kann man auch Werte  (die aus dem SELECT) ans Ende des Baumes kopiere ohne den Baum slebst zu belasten
partitionierter IX ..x  physikalisch gesplitteter IX
abdeckenden ....x  --der perfekt IX (reine Seek, kein Scan, kein Lookup)
Indizierte Sicht ...x
gefilterter ...x nicht alle Datensätze einer Tabelle in IX bringen
hypothetischen  wird nur von DB Optimierungsratgeber erzeugt
		existieren real, aber DB Engine verwendet sie nicht
		sind im SSMS nicht zu sehen
--------------------------------
Columnstore  -- SOnderfall

select * from sys.dm_db_index_usage_Stats

sp_blitzindex

N GR IX nur gut bei rel wenigen Ergebniszeilen

GR IX gut bei eindeutigen , aber auch umgfangreicheren Eregbnissen
--> perfekt für Bereichsabfragen

Gr IX kann es nur einmal geben!!
N GR IX bis ca 1000 mal pro Tabelle

GR IX = Tabelle in physikalisch sortierter Form

NGR Telefonbuch mit Zeiger zum Org Datensatz (im Heap)-- Kopie bestimmter Daten



select * from tabelle where !!!


=
<
>
!=
IN
Between
like 'A%'
like '%A'
<>









*/

USE Northwind;

SELECT * INTO bestellungen FROM orders --HEAP

--Table Scan
SELECT * FROM bestellungen
SELECT * FROM bestellungen WHERE orderid = 10248

--PK auf Orderid --Jetzt CL IX 
SELECT * FROM bestellungen
SELECT * FROM bestellungen WHERE orderid = 10248


--nach PK mit NGR IX.. wieder Table scan
SELECT * FROM bestellungen
SELECT * FROM bestellungen WHERE orderid = 10248 --LOOKUP (Heap)
SELECT orderid FROM bestellungen WHERE orderid = 10248


--nun GRIX_Orderdate

SELECT * FROM bestellungen WHERE orderid = 10248 --NGIX Seek mit CLIX Suche

--reinen Seek
--zusammengesetzter, abdeckender

--
SELECT orderid, freight, shipcity FROM bestellungen WHERE orderid = 10248




--aber Problem.. der zusammeng. IX kann nicht mehr als 16 Spalten haben
--bzw der Schlüsselwert des IX darf nicht 900byte übersteigen

--dafür gibts Alternativen
--IX mit eingeschlossenen Spalten
 --darf 1023 Spalten haben


 SELECT * FROM bestellungen WHERE orderid = 10248



SELECT * INTO b3 FROM orders

SELECT * FROM b3 WHERE shipcity ='LONDON'

SELECT * FROM b3 WHERE orderid =10249

SELECT * FROM b2 WHERE shipcountry ='USA'



