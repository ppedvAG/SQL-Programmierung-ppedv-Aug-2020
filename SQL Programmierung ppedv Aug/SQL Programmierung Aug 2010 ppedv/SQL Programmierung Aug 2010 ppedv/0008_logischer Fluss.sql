--Logischer Fluss

select country as Land, companyname as Firma,2*3
		count(*) as Anzahl
from customers c
where
	country= 'UK' -- and anzahl > 1	  and c.
group by
	country	, Companyname	having count(*)> 1 
order by 
		LAND


 --Logischer Fluss:
 --Grammatik , Namensauflösung , Optmierungsmaßnahmen

 --> FROM (--> c)	 --der Reihe nach die JOINs --> where (IX)!! -->
 --> GROUP BY (AGG) --> having (AGG) 
 --> SELECT	(nicht Ausgabe, ALIAS, Berechnungen etc)
 --> ORDER BY (ALIASE aus dem SELECT)  --reicht der RAM nicht, dann tempdb
 --> TOP |DISTINCT
 --> AUSGABE

 --Warum soll man im Having nichts filtern, was ein where kann!
 --im Having sollten immer nur AGG stehen...

 --SQL Ist in der Lage, "falsche" having zu erkennen
 --aber nur bei rel simplen Abfragen






--auf dem Client passiert nix...

