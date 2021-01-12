/**/



/**/



/**/



/*Q4
0/1 points (graded)
Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.*/
select h.name, h.grade 
from highschooler h 
left join likes l on (l.id1 = h.id or l.id2 = h.id) 
where l.id1 is null
order by h.grade, h.name
--or
select h.name, h.grade 
from highschooler h 
where h.id not in (select id1 from likes union select id2 from likes)
order by h.grade, h.name

/*Q5
0/1 points (graded)
For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.*/
select h1.name, h1.grade, h2.name, h2.grade from highschooler h1
join likes l on h1.id = l.id1
join highschooler h2 on h2.id = l.id2
where l.id2 not in (select id1 from likes)


/**/




/**/




/**/





/**/





/**/
