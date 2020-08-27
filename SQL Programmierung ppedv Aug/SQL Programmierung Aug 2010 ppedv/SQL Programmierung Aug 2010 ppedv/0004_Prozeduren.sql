/*
Prozeduren .. stored procedures

Parameter, 
Ausführen
sind in der Regel schneller 

adhoc Abfrage
select * from orders where orderid = 10249

Proz
exec procname 10249


Sicht
select * from Sicht


Funktion

select * from dbo.fname(10249)

langsam -- > schnell
F()    Sicht|Adhoc     Prozedur



*/


exec Procname par1, par2



create procedure gpdemo1 
as
select * from customers
GO

alter proc gpdemo1
as
select * from customers where country like 'U%'
GO

exec gpdemo1 


--Prozeduren können nicht in Joins verwendet werden...!
--Verhalten sich wie Batchdateien...
-- gerne mit sp_proc werden dann aber zuerst in der DB master gesucht

alter proc gp_demo2 @par1 int = 10 , @par2 int
as
select @par1*@par2
GO

exec gp_demo2 @par1=4, @par2 = 20
exec gp_demo2 @par2=50

--oft sind in Proc die gesamte Logik eingepackt...
--und liegen auf dem Server


--Proc Aufgabe

exec gp_kdSuche 'ALFKI' --1 Treffer..klappt..
exec gp_KDsuche 'A'   --alle Kunden mit A beginnend ..geht nicht
exec gp_KDSuche '%' --alle Kunden ..geht nicht
exec gp_KDsuche  --alle Kunden ..geht nicht

--customers .. customerid nchar(5)

alter proc gp_demo2 @par1 int = 10 , @par2 int
as
select @par1*@par2
GO

exec gp_demo2 @par1=4, @par2 = 20
exec gp_demo2 @par2=50


alter proc gp_kdsuche @kdid nchar(5)='%' --logisch , oder??-- 'A'-.--> 'A    '%
as
select * from customers where customerid like rtrim(@kdid) +'%'


exec gp_kdsuche 'A' --kommt nix.. mist!!



alter proc gp_kdsuche @kdid varchar(5)='%' --logisch , oder??-- 'A'-.--> 'A    '%
as
select * from customers where customerid like @kdid +'%'

exec gp_kdsuche 'A' --kommt nix.. mist!!


--Perspektive variablen:
--SQL muss Plan schätze und Arbetispeicherbedarf für den Plan

--flexible Längen schätzt er zu 50% der Länge

--vor allem bei order by wird gerne der RAMbedarf verschätzt
--varchar mal 2,5 
--varchar(100)... varchar(250)--> 125

--prozeduren sollten nie benutzerfreundlich sein:
-- suche nach A 
--Suche % --alle durchsuchen

--Prozeduren machen immer den selben Plan
--beim ersten Aufruf wird der Plan erstellt und immer wieder verwendet

--SCAN A bis Z Suche .. SEEK herauspicken



alter proc gp_demo3 @par1 int, @par2 int, @par3 int output  --Ausgabe /auch Inputparameter
as
select @par3= @par1+@par2


declare @var1 as int
exec gp_demo3 @par1=2, @par2 = 5, @par3=@var1 output --nicht erlaubt: @var1=@par3
select @var1

---Aufgabe.. Lasse dir den Schnitt der Fracht per Proc errechnen
--und Suche dannn mit der Variablen/OUtput .. alle Orders raus, die unter dem Schcnitt liegen

create proc gp_Schnittsuche @schnitt money output
as
select @schnitt = avg(freight) from orders
GO

declare @schnitt2 as money
exec gp_Schnittsuche @schnitt = @schnitt2 output
select * from orders where freight < @schnitt2 order by freight desc
select @schnitt2


--Datentyp: decimal(10,2)-- 10 Stellen Länge, davon 2 Nachkommastellen


alter proc gpdemo4
as
select getdate()
GO --ohne GO ist der folgende  Aufruf inklusive.. rekursiv 32 mal.. viel Spass
exec gpdemo4 --

--nix.. ausser Befehl erfolgreich
--Datum mit Uhrzeit ausgeben


create proc #gpdemo5 @par1 int, @par2 int
as
select @par1 + @par2

--# ???..nö!

--# steht immer für tepmoräres

exec #gpdemo5 2,6

--gründe für temp Prozeduren sind: ich darf in der DB keinen Proc anlegen, möchte aber ein habeb
--#temporär.. die Proc wird nach Schlissen der Session verschwinden+--ist schneller als der Code, der dahinter steckt




























