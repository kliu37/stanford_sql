/*Q1
0 points (ungraded)
Find the names of all reviewers who rated Gone with the Wind.*/
select distinct r.name from reviewer r 
join rating ra on ra.rid = r.rid
join movie m on m.mid = ra.mid
where m.title = 'Gone with the Wind'

/*Q2
0 points (ungraded)
For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.*/
select r.name, m.title, ra.stars from reviewer r 
join rating ra on ra.rid = r.rid
join movie m on m.mid = ra.mid
where r.name = m.director

/*Q3
0 points (ungraded)
Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)*/
select name from reviewer
union 
select title from movie
order by name, title

/*Q4
0 points (ungraded)
Find the titles of all movies not reviewed by Chris Jackson.*/
select distinct m.title from movie m
left join rating ra on m.mid = ra.mid
left join reviewer r on ra.rid = r.rid
where m.title not in (
	select m.title from movie m 
	join rating ra on m.mid = ra.mid 
	join reviewer r on ra.rid = r.rid 
	where r.name = 'Chris Jackson')

/*Q5
0 points (ungraded)
For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.
r1.name < r2.name is important, can't use r1.name <> r2.name as this will give same pair of name twice: r1.name|r2.name, r2.name|r1.name*/
select distinct r1.name, r2.name from reviewer r1 
join rating ra1 on ra1.rid = r1.rid
join rating ra2 on ra1.mid = ra2.mid
join reviewer r2 on r2.rid = ra2.rid and r1.name < r2.name
order by r1.name, r2.name

/*Q6
0 points (ungraded)
For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.*/
select r.name, m.title, ra.stars
from reviewer r 
join rating ra on ra.rid = r.rid
join movie m on m.mid = ra.mid
where ra.stars = (select min(stars) from rating)

/*Q7
0 points (ungraded)
List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.*/
select m.title, avg(ra.stars)
from reviewer r 
join rating ra on ra.rid = r.rid
join movie m on m.mid = ra.mid
group by m.title
order by avg(ra.stars) desc, m.title

/*Q8
0 points (ungraded)
Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)*/
select r.name from reviewer r
join rating ra on ra.rid = r.rid
group by r.name
having count(r.name)>=3

/*Q9
0 points (ungraded)
Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.)*/
select title, director from movie
where director in 
(select m.director from movie m
group by m.director
having count(m.title)>1)
order by director, title

/*Q10
0 points (ungraded)
Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.)*/


/*Q11
0 points (ungraded)
Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)*/


/*Q12
0 points (ungraded)
For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL.*/

/**/
