--Tabellenwertfunktion mit mehreren Anweisungen

create function fname (parameter)
returns @Tabellenrückgabe table
( spaltendefinition)
as
Begin
Anweisungen
resturn
end

alter function fTable2 (@par1 int)
returns @Ausgabe table
	(Bestid int, custid varchar(50), freight money)
as
Begin
	insert into @ausgabe
	select orderid, customerid, freight from northwind..orders where orderid < @par1;
	return
end


select * from ftable2 (10250)