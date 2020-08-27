

use TSQL_Programmierung;

-- Testtabelle erzeugen. Die dritte Spalte
-- soll hier nur simulieren, dass noch mehr Spalten
-- vorhanden sind.
drop table if exists t1

drop view if exists v1

--###### HEAP #######

create table T1
 (
   Id int identity(1,1) not null
  ,Nr int not null
  ,Platzhalter nchar(400) null default '#'
 )
go

-- Füge 200.000 Zeilen ein ( ca. 25 Sek )
DECLARE @i AS INT
SET @i=0

WHILE @i < 200000
BEGIN
    INSERT INTO T1(nr) VALUES (@i)
    SET @i=@i+1
end

select * from T1

-- Anzeige der Indexebenen
--Ebenen selten mehr als 4.. Optimierung erst wenn weniger Ebenen

select index_id,index_type_desc,index_depth
      ,index_level,page_count,record_count
  from sys.dm_db_index_physical_stats(db_id(),object_id('T1')
                                     ,null,null,'detailed')
go


-- Anlegen von Indizes
create [unique] non clustered Index indexname on Tabelle (spalten) include (Spalten) where Filter = ()
create clustered index Indexanem on Tabelle (Spalten) 

--Indizierte Sicht!:
--muss with schemabinding, unique, clustered, kein Outer Join, bei Aggregaten Count_big(*) aufweisen

-- wird nur von Ent/Dev beachtet. Alle anderen Editione müssen (NOEXPAND) auifweisen

set statistics io on
set statistics time on

select Nr,count(*) as Anzahl
  from T1
  group by Nr
go



create view V1 with schemabinding as
 select Nr,count_big(*) as anz
     from dbo.T1
    group by Nr
go 

select * from V1



create unique clustered index Ix_V1_Nr on V1 (Nr)
GO



--x Seiten bei 10 MIO DS
--x             100 TRilliarden DS

ca 3 seiten bei ca 200 Ländern

select * from V1


select * from V1 with (Index=0)
go

select Nr,count(*)
  from T1
  group by Nr



  200MB Heap

  NCL A 60MB
  NCL B 80

  CL 230 MB
  ---360MB..
  --IX ON OFFLINE, mit und ohne Tempdb
  --günstig: off ohne tempdb..    860
  --aufwendiger: on mit tempdb    1043

  --500MB 


A B C
A
B
C
AB
AC
BA
BC
CA
CB
ABC
ACB
BAC
BCA
CAB
CBA
CBA
CBA
CBA
---1023

---NON CL IX.. wenige Zeilen
--CL IX .. wurscht






