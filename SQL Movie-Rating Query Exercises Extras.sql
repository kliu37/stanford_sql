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

/**/
