/*Q1
0/1 points (graded)
It's time for the seniors to graduate. Remove all 12th graders from Highschooler.*/
delete from highschooler
where grade = 12

/*Q2
0/1 points (graded)
If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.*/


/*Q3
0/1 points (graded)
For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself. (This one is a bit challenging; congratulations if you get it right.)*/
insert into friend 
select * from (select distinct f1.id1, f2.id2 from friend f1 join friend f2 on f1.id2 = f2.id1 and f1.id1 < f2.id2
			   union 
			   select distinct f2.id2, f1.id1 from friend f1 join friend f2 on f1.id2 = f2.id1 and f1.id1 < f2.id2)
			   except 
			   select * from friend
