-- 1. List all students born after January 1, 2003.
SELECT name, id FROM students WHERE dob > '2003-01-01';

-- 2. Show the names of all courses taught by Dr. Ramesh Sharma.
SELECT c.name AS course_name
FROM courses c
INNER JOIN teachers t ON c.teacher_id = t.id
WHERE t.name = 'Dr. Ramesh Sharma';

-- 3. Retrieve all student names and their enrolled course names.
SELECT s.name AS student_name, c.name AS course_name
FROM enrollments e
INNER JOIN students s ON e.student_id = s.id
INNER JOIN courses c ON e.course_id = c.id;

-- 4. Display all student names along with course names and the marks they scored.
SELECT s.name AS student_name, c.name AS course_name, r.score
FROM enrollments e
INNER JOIN students s ON e.student_id = s.id
INNER JOIN courses c ON e.course_id = c.id
INNER JOIN results r ON r.enrollment_id = e.id;

-- 5. Show the average score for each student.
SELECT s.name AS student_name, AVG(r.score) AS average_score
FROM enrollments e
INNER JOIN students s ON e.student_id = s.id
INNER JOIN results r ON r.enrollment_id = e.id
GROUP BY s.name;

-- 6. Count how many students are enrolled in each course.
SELECT c.name AS course_name, COUNT(e.student_id) AS total_students
FROM enrollments e
INNER JOIN courses c ON e.course_id = c.id
GROUP BY c.name;

-- 7. List courses that have more than 3 students enrolled.
SELECT c.name AS course_name, COUNT(e.student_id) AS total_students
FROM enrollments e
INNER JOIN courses c ON e.course_id = c.id
GROUP BY c.name
HAVING COUNT(e.student_id) > 3;

-- 8. Find the total number of students enrolled in “Database Systems”.
SELECT c.name AS course_name, COUNT(e.student_id) AS student_count
FROM enrollments e
INNER JOIN courses c ON e.course_id = c.id
WHERE c.name = 'Database Systems'
GROUP BY c.name;

-- 9. Find the name of the top-performing student by average score.
SELECT s.name AS student_name, AVG(r.score) AS avg_score
FROM enrollments e
INNER JOIN students s ON e.student_id = s.id
INNER JOIN results r ON r.enrollment_id = e.id
GROUP BY s.name
ORDER BY avg_score DESC
LIMIT 1;

-- 10. List students who have scored above average in any course.
SELECT s.name AS student_name, c.name AS course_name, r.score
FROM results r
INNER JOIN enrollments e ON r.enrollment_id = e.id
INNER JOIN students s ON e.student_id = s.id
INNER JOIN courses c ON e.course_id = c.id
WHERE r.score > (
    SELECT AVG(r2.score)
    FROM results r2
    INNER JOIN enrollments e2 ON r2.enrollment_id = e2.id
    WHERE e2.course_id = e.course_id
);
