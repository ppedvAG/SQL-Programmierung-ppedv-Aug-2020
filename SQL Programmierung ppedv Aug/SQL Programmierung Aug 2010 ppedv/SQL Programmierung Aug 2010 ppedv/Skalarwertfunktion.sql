create function namederfunktion (@par datentyp)
Returns datentyp
as
Begin
 Anweisung
 Return Rückgabe
end

create function fzahl (@par1 int, @par2 int)
returns int
as
begin
declare @result as int
select @result = @par1*@par2
return @result
--order return (select ....)
end

select dbo.fzahl( 2,5) --10


