-- ============================================================
-- DAY 13 / 30  |  Date: 14 October 2026 (Wednesday)
-- 30 Days SQL Challenge  |  PostgreSQL
-- ============================================================

-- 13/30 SQL Challenge

-- Facebook medium level SQL question for Data Analyst 
-----------------------------------------------------
-- !If you get stuck my solution at the end of the query
-----------------------------------------------------

-- Q.1 SCHEMAS

DROP TABLE IF EXISTS fb_posts CASCADE;
CREATE TABLE fb_posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    likes INT,
    comments INT,
    post_date DATE
);


INSERT INTO fb_posts (post_id, user_id, likes, comments, post_date) VALUES
(1, 101, 50, 20, '2024-02-27'),
(2, 102, 30, 15, '2024-02-28'),
(3, 103, 70, 25, '2024-02-29'),
(4, 101, 80, 30, '2024-03-01'),
(5, 102, 40, 10, '2024-03-02'),
(6, 103, 60, 20, '2024-03-03'),
(7, 101, 90, 35, '2024-03-04'),
(8, 101, 90, 35, '2024-03-05'),
(9, 102, 50, 15, '2024-03-06'),
(10, 103, 30, 10, '2024-03-07'),
(11, 101, 60, 25, '2024-03-08'),
(12, 102, 70, 30, '2024-03-09'),
(13, 103, 80, 35, '2024-03-10'),
(14, 101, 40, 20, '2024-03-11'),
(15, 102, 90, 40, '2024-03-12'),
(16, 103, 20, 5, '2024-03-13'),
(17, 101, 70, 25, '2024-03-14'),
(18, 102, 50, 15, '2024-03-15'),
(19, 103, 30, 10, '2024-03-16'),
(20, 101, 60, 20, '2024-03-17');

/*
-- Q.1
Question: Identify the top 3 posts with the highest engagement 
(likes + comments) for each user on a Facebook page. Display 
the user ID, post ID, engagement count, and rank for each post.
*/














-- Schemas for Q.2

DROP TABLE IF EXISTS posts CASCADE;
CREATE TABLE posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    likes INT,
    post_date DATE
);

INSERT INTO posts (post_id, user_id, likes, post_date) VALUES
(1, 101, 50, '2024-02-27'),
(2, 102, 30, '2024-02-28'),
(3, 103, 70, '2024-02-29'),
(4, 101, 80, '2024-02-01'),
(5, 102, 40, '2024-02-02'),
(6, 103, 60, '2024-02-29'),
(7, 101, 90, '2024-01-29'),
(8, 101, 20, '2024-02-05'),
(9, 102, 50, '2024-01-29'),
(10, 103, 30, '2024-02-29'),
(11, 101, 60, '2024-01-08'),
(12, 102, 70, '2024-01-09'),
(13, 103, 80, '2024-01-10'),
(14, 101, 40, '2024-01-29'),
(15, 102, 90, '2024-01-29'),
(16, 103, 20, '2024-01-13'),
(17, 101, 70, '2024-01-14'),
(18, 102, 50, '2024-02-29'),
(19, 103, 30, '2024-02-16'),
(20, 101, 60, '2024-02-17');

/*
-- Q.2

Determine the users who have posted more than 2 times 
in the past week and calculate the total number of likes
they have received. Return user_id and number of post and no of likes
*/

















-- ------------------------------------------------------------------------
-- My Solution for Q1
-- top 3 post by each user
-- SUM( likes + comments)
-- post ranks
------------------------------------------------------------------------

WITH rank_posts
AS (
	SELECT 
		user_id,
		post_id,
		SUM(likes + comments) as engagement_count,
		ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY SUM(likes + comments) DESC) rn,
		DENSE_RANK() OVER(PARTITION BY user_id ORDER BY SUM(likes + comments) DESC) ranks
	FROM fb_posts
	GROUP BY user_id, post_id
	ORDER BY user_id, engagement_count DESC
)
SELECT 
	user_id,
	post_id,
	engagement_count,
	ranks
FROM rank_posts
WHERE rn <=3;


















-- ------------------------------------------------------------------------
-- My Solution for Q2
------------------------------------------------------------------------
-- user posted > 2
-- sum(likes)
-- COUNT(post)
-- past week

-- Q2: users with more than 2 posts in the past week, with their total likes.
-- Sample data is from Jan-Feb 2024, so "past week" is counted back from the latest
-- post date in the table (with live data use CURRENT_DATE instead of the MAX subquery).
SELECT
	user_id,
	COUNT(post_id) AS cnt_post,
	SUM(likes) AS total_likes
FROM posts
WHERE post_date > (SELECT MAX(post_date) FROM posts) - 7
GROUP BY user_id
HAVING COUNT(post_id) > 2;
-- expected: user 103 | 3 posts | 160 likes
