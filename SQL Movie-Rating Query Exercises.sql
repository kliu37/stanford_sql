/*Q1
1/1 point (graded)
Find the titles of all movies directed by Steven Spielberg.*/
select title from movie where director = 'Steven Spielberg'

/*Q2
1/1 point (graded)
Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.*/


/*Q3
0/1 points (graded)
Find the titles of all movies that have no ratings.*/
select m.title from movie m left join rating r on m.mid = r.mid where r.stars is null

/*Q4
0/1 points (graded)
Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.*/
select name from reviewer re left join rating ra on re.rid = ra.rid where ra.ratingdate is null

/*Q5
0/1 points (graded)
Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.*/
select re.name as reviewer_name, m.title as movie_title, ra.stars, ra.ratingDate 
from movie m 
join rating ra on m.mid = ra.mid 
left join reviewer re on ra.rid = re.rid
order by re.name, m.title, ra.stars



/*Q6
0/1 points (graded)
For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.
note: previous was wrong because didn't add m.mid = ra2.mid which will cause the ra2 review was on another another movie*/
select re.name, m.title 
from movie m 
left join rating ra1 on m.mid = ra1.mid 
left join rating ra2 on ra1.rid = ra2.rid and m.mid = ra2.mid
left join reviewer re on re.rid = ra1.rid
where ra2.ratingdate > ra1.ratingdate
and ra2.stars > ra1.stars


/*Q7
0/1 points (graded)
For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.*/
select m.title, max(ra.stars)
from movie m
join rating ra on m.mid = ra.mid
group by m.title
order by m.title



/*Q8
0/1 points (graded)
For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.*/
select m.title, max(r.stars)-min(r.stars)
from movie m
join rating r on m.mid = r.mid 
group by m.title
order by max(r.stars)-min(r.stars) desc,title


/*Q9
0/1 points (graded)
Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)*/
select avg(before1980.avg)-avg(after1980.avg) from 
(select avg(r.stars) as avg from rating r join movie m on r.mid = m.mid group by m.title having year <= 1980) as before1980,
(select avg(r.stars) as avg from rating r join movie m on r.mid = m.mid group by m.title having year > 1980) as after1980




