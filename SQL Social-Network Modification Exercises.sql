/*Q1
0/1 points (graded)
It's time for the seniors to graduate. Remove all 12th graders from Highschooler.*/
delete from highschooler
where grade = 12

/*Q2
0/1 points (graded)
If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.*/
--select all A like B and A and B are friends, and then remove A and B mutually like
delete from likes
where id1 in (
	select l.id1 from likes l
	join friend f on l.id1 = f.id1 and l.id2 = f.id2
	except
	select l1.id1
	from likes l1 
	join likes l2 on l1.id1 = l2.id2 and l2.id1 = l1.id2
	join friend f on l1.id1 = f.id1 and l1.id2 = f.id2)

/*Q3
0/1 points (graded)
For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself. (This one is a bit challenging; congratulations if you get it right.)*/
insert into friend 
select * from (select distinct f1.id1, f2.id2 from friend f1 join friend f2 on f1.id2 = f2.id1 and f1.id1 < f2.id2
			   union 
			   select distinct f2.id2, f1.id1 from friend f1 join friend f2 on f1.id2 = f2.id1 and f1.id1 < f2.id2)
			   except 
			   select * from friend
