/*


DB Design: Normalisierung, Redundanz, Generalisierung, PK, FK  , Beziehungen


PK ist dazu da: Eindeutigkeit ist die Bedingung, aber die Aufgabe ist es die Beziehungen einzugehen


Korrekte Datentypen

create table t1 (id int identity, spx char(4100));
GO

insert into t1 
select 'XY';
GO 20000 --22 Sek .. 17 Sek ..20 Sek.. 1 Sekunde

-
