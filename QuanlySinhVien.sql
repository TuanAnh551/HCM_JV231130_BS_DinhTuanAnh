-- Tạo cơ sở dữ liệu QuanlySinhVien
CREATE DATABASE Test2
COLLATE utf8_unicode_ci;

USE Test2;

-- Tạo bảng
CREATE TABLE subjects(
    SubjectID INT(4),
    SubjectName VARCHAR(50)
);

CREATE TABLE  classes(
    ClassID INT(4),
    ClassName VARCHAR(50)
);

CREATE TABLE students(
    StudentID INT(4),
    StudentName VARCHAR(50),
    Ages INT(4),
    Email VARCHAR(100)
);

CREATE TABLE classtsudents(
    StudentID INT,
    ClassID INT
);


CREATE TABLE marks(
    Mark INT,
   SubjectID INT,
    StudentID INT
);

-- Thêm khóa chính, khóa phụ cho các bảng
ALTER TABLE subjects
    ADD PRIMARY KEY(SubjectID);
ALTER TABLE classes
    ADD PRIMARY KEY(ClassID);

ALTER TABLE students
    ADD PRIMARY KEY(StudentID);

ALTER TABLE classtsudents
    ADD FOREIGN KEY(StudentID) REFERENCES students(StudentID),
    ADD FOREIGN KEY(ClassID) REFERENCES classes(ClassID) ;

ALTER TABLE marks
    ADD FOREIGN KEY(SubjectID) REFERENCES subjects(SubjectID),
    ADD FOREIGN KEY(StudentID) REFERENCES students(StudentID);

-- Thêm dữ liệu vào bảng
INSERT INTO subjects(SubjectID, SubjectName)
VALUES
    (1, 'SQL'),
    (2, 'Java'),
    (3, 'C'),
    (4, 'Visual Basic');

INSERT INTO classes(ClassID, ClassName)
VALUES
    (1, 'C0706L'),
    (2, 'C0708G');

INSERT INTO students(StudentID, StudentName, ClassID, Email)
VALUES
    (1, 'Nguyen Quang An', 18, 'an@yahoo.com'),
    (2, 'Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
    (3, 'Nguyen Van Quyen', 19, 'quyen'),
    (4, 'Pham Thanh Binh', 25, 'binh@com'),
    (5, 'Nguyen Van Tai Em', 30, 'taiem@sport.vn');


INSERT INTO marks(Mark, SubjectID, StudentID )
VALUES
    (8, 1, 1),
    (4, 2, 1),
    (9, 1, 1),
    (7, 1, 3),
    (3, 1, 4),
    (5, 2, 5),
    (8, 3, 3),
    (1, 3, 5),
    (3, 2, 4);

INSERT INTO classtsudents(StudentID, ClassID)
VALUES
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 2);

Viet truy van:
1. Hien thi danh sach tat ca cac hoc vien
SELECT * FROM students;
2. Hien thi danh sach tat ca cac mon hoc
SELECT * FROM subjects;
3. Tinh diem trung binh
SELECT StudentID, AVG(Mark) AS DiemTrungBinh
FROM marks
GROUP BY StudentID;
4. Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
SELECT SubjectID, MAX(Mark) AS DiemCaoNhat
FROM marks
GROUP BY SubjectID;

5. Danh so thu tu cua diem theo chieu giam
SELECT Mark, ROW_NUMBER() OVER(ORDER BY Mark DESC) AS RowNumber
FROM marks;

6. Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
ALTER TABLE subjects
MODIFY COLUMN SubjectName VARCHAR(100);


7. Cap nhat them dong chu « Day la mon hoc « vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
UPDATE subjects
SET SubjectName = CONCAT('Day la mon hoc ', SubjectName);

8. Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
ALTER TABLE students
ADD CONSTRAINT CHK_Age CHECK (Ages > 15 AND Ages < 50);

9. Loai bo tat ca quan he giua cac bang
ALTER TABLE classtsudents
DROP FOREIGN KEY classtsudents_ibfk_1,
DROP FOREIGN KEY classtsudents_ibfk_2;

ALTER TABLE marks
DROP FOREIGN KEY marks_ibfk_1,
DROP FOREIGN KEY marks_ibfk_2;



10.Xoa hoc vien co StudentID la 1
DELETE FROM students
WHERE StudentID = 1;
11.Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
ALTER TABLE students
ADD Status BIT DEFAULT 1;

12.Cap nhap gia tri Status trong bang Student thanh 0
UPDATE students
SET Status = 0;
