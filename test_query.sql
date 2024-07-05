-- 1. Tampilkan daftar siswa beserta kelas dan guru yang mengajar kelas tersebut.
SELECT students.*, classes.name as class_name, teachers.name as teachers_name, teachers.subject
FROM students
JOIN classes ON students.class_id = classes.id
JOIN teachers ON classes.teacher_id = teachers.id;

2. Tampilkan daftar kelas yang diajar oleh guru yang sama.
SELECT classes.id AS class_id, classes.name AS class_name, teachers.id AS teacher_id, teachers.name AS teacher_name
FROM classes
JOIN teachers ON classes.teacher_id = teachers.id
WHERE teachers.id IN 
(
    SELECT teacher_id
    FROM classes
    GROUP BY teacher_id
    HAVING COUNT(*) > 1
);

-- 3. buat query view untuk siswa, kelas, dan guru yang mengajar
CREATE VIEW student_class_teacher_view AS
SELECT students.id AS student_id, students.name AS student_name, students.age AS student_age,classes.id AS class_id, classes.name AS class_name, teachers.id AS teacher_id, teachers.name AS teacher_name
FROM students
JOIN classes ON students.class_id = classes.id
JOIN teachers ON classes.teacher_id = teachers.id;

SELECT * FROM student_class_teacher_view;

-- 4. buat query yang sama tapi menggunakan store_procedure
DELIMITER //
CREATE PROCEDURE studen_class_teacher() 
BEGIN
SELECT students.id AS student_id, students.name AS student_name, students.age AS student_age,classes.id AS class_id, classes.name AS class_name, teachers.id AS teacher_id, teachers.name AS teacher_name
FROM students
JOIN classes ON students.class_id = classes.id
JOIN teachers ON classes.teacher_id = teachers.id;
END
// DELIMITER;

CALL studen_class_teacher()

-- 5. buat query input, yang akan memberikan warning error jika ada data yang sama pernah masuk
ALTER TABLE students ADD UNIQUE (name);

INSERT INTO students (name, age)
VALUES ('Budi', 17)
ON DUPLICATE KEY UPDATE name = VALUES(name);






