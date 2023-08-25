--part a

select distinct bar 
from Serves 
where beer='Corona';

--part b

select distinct beer
from Serves 
where bar IN (select bar 
			from Frequents 
			where (drinker='Ben' and times_a_week=1));
			
--part c

select distinct *
from Drinker
where name in (
	select drinker
	from likes
	where beer in (
		select beer
		from Serves
		where bar='Talk of the Town'));

--part d

select distinct u1.name,u2.name
from Drinker u1, drinker u2
where u1.address = u2.address and u1.name<u2.name;

--part e

select name
from beer
where name not in (
	select beer
	from likes);
	
--part f 

select a.beer,a.bar
from serves a, 
(select beer, MAX(price)
from serves
group by beer) b
where a.beer=b.beer and a.price=b.max;

--part g

select distinct b.drinker
from frequents b
where not exists (
	select a.drinker 
	from frequents a
	where not exists (select drinker,bar
		from likes natural join serves
		where drinker=a.drinker and bar=a.bar)
		and a.drinker=b.drinker);
	
--part h

select distinct b.drinker
from frequents b
where not exists (
	select a.drinker
	from (select drinker,bar
		from likes natural join serves) a 
	where not exists (select drinker, bar
		from frequents
		where drinker=a.drinker and bar=a.bar)
		and b.drinker=a.drinker);
		
--part i 
	
create table spending as
(select * from serves natural join (select * from frequents natural join likes) a);

alter table spending
add amount float;

update spending
set amount = price*times_a_week;	
	
select foo.drinker,sum(amount) amount
from ((select drinker, amount
	from spending) union	
	
	(select name drinker, 0 amount
	from drinker)) foo
group by foo.drinker
order by amount desc;




	
	

