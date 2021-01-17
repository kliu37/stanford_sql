/*Q1
0 points (ungraded)
For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C.*/
select a.name, a.grade, b.name, b.grade, c.name, c.grade
from highschooler a 
join likes al on al.id1 = a.id 
join likes bl on bl.id1 = b.id and bl.id2 <> a.id
join highschooler b on al.id2 = b.id
join highschooler c on bl.id2 = c.id


/*Q2
0 points (ungraded)
Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades.*/
select h.name, h.grade 
from highschooler h
where h.id not in 
(select h1.id from highschooler h1
join friend f on h1.id = f.id1
join highschooler h2 on h2.id = f.id2
where h1.grade = h2.grade)


/*Q3
0 points (ungraded)
What is the average number of friends per student? (Your result should be just one number.)*/
select avg(count) from 
(select count(id2) as count
from friend
group by id1) as c


/*Q4
0 points (ungraded)
Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend.*/
select count(*)
from (select id1
from friend 
where id1 in 
(select f1.id2 from friend f1
where f1.id1 = (select id from highschooler where name = "Cassandra" ))
and id2 <> (select id from highschooler where name = "Cassandra" )	
union 
select id2
from friend 
where id1 in 
(select f1.id2 from friend f1
where f1.id1 = (select id from highschooler where name = "Cassandra" ))
and id2 <> (select id from highschooler where name = "Cassandra" ))	


/*Q5
0 points (ungraded)
Find the name and grade of the student(s) with the greatest number of friends.*/
select name, grade from highschooler h
join friend f on f.id1 = h.id
group by h.id
having count(f.id2) = (select max(count) from (select count(id2) as count from friend group by id1) as c)
