/*Q1
0/1 points (graded)
Add the reviewer Roger Ebert to your database, with an rID of 209.*/
insert into reviewer values("209", "Roger Ebert")


/*Q2
0/1 points (graded)
For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)*/
--我们不能用where来筛选超过1000000的地区，因为表中不存在这样一条记录。相反，HAVING子句可以让我们筛选成组后的各组数据．
update movie
set year = year + 25
where mid in (select mid from rating group by mid having avg(stars)>=4)


/*Q3
0/1 points (graded)
Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars.*/
delete from rating
where rating.mid in (select mid from movie where (year < "1970" or year > "2000") and rating.stars < 4)
