/*Q1
1/1 point (graded)
Find the names of all students who are friends with someone named Gabriel.*/
select h1.name from highschooler h1
join friend f on h1.id = f.id1 
join highschooler h2 on h2.id = f.id2
where h2.name = "Gabriel"


/*Q2
1/1 point (graded)
For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.*/
select h1.name, h1.grade, h2.name, h2.grade
from highschooler h1 
join likes l on h1.id = l.id1
join highschooler h2 on h2.id = l.id2
where (h1.grade - h2.grade) >= 2


/*Q3
1/1 point (graded)
For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.*/
select h1.name, h1.grade, h2.name, h2.grade
from highschooler h1
join likes l1 on h1.id = l1.id1
join likes l2 on (l1.id1 = l2.id2 and l2.id1 = l1.id2 )
join highschooler h2 on h2.id = l2.id1
where h1.name < h2.name


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


/*Q6
1/1 point (graded)
Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.*/
select distinct h1.name, h1.grade 
from highschooler h1  
where h1.id not in (
	select id1
	from friend f 
	join highschooler h2 on h2.id = f.id2 
	where h1.grade <> h2.grade)
order by h1.grade, h1.name



/*Q7
For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.*/
select distinct h1.name, h1.grade, h2.name, h2.grade, h3.name, h3.grade
from highschooler h1 
join likes l1 on h1.id = l1.id1
join highschooler h2 on h2.id = l1.id2
join friend f1 on f1.id1 = h1.id
join friend f2 on f2.id1 = h2.id
join highschooler h3 on f1.id2 = h3.id and f2.id2 = h3.id
where h2.id not in (select id1 from friend where h1.id = id2)


/*Q8
Find the difference between the number of students in the school and the number of different first names.*/
select count(*) - count(distinct(name)) from highschooler


/*Q9
Find the name and grade of all students who are liked by more than one other student.*/
select name, grade from highschooler
join likes l on id = l.id2
group by l.id2
having count(l.id1)>1
