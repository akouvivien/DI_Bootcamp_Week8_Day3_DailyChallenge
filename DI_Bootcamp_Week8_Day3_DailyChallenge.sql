-- Part I

-- Create 2 tables : Customer and Customer profile. They have a One to One relationship.

-- A customer can have only one profile, and a profile belongs to only one customer
-- The Customer table should have the columns : , , idfirst_namelast_name NOT NULL

CREATE TABLE Customer (
  customer_id SERIAL PRIMARY KEY NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL
);

/*
 one to one: a movie has one scenario
*/

-- A customer can have only one profile, and a profile belongs to only one customer
-- The Customer table should have the columns : , , idfirst_namelast_name NOT NULL

CREATE TABLE Customer_profile (
  Customer_profile_id SERIAL PRIMARY KEY NOT NULL,
  isLoggedIn BOOLEAN NOT NULL,
  fk_customer_id INTEGER  REFERENCES Customer (customer_id)
);


--2 / 
-- Insert those customer profiles, use subqueries

-- John is loggedIn
-- Jerome is not logged in

INSERT INTO Customer(first_name, last_name)
VALUES('John', 'Doe'),
		('Jerome', 'Lalu'),
		('Lea', 'Rive');
select * from customer
		
--3 / Insert those customer profiles, use subqueries

-- John is loggedIn
-- Jerome is not logged in

INSERT INTO Customer_profile(isLoggedIn,fk_customer_id)
VALUES('True',(SELECT customer_id FROM customer WHERE customer.customer_id = 1)),
		('False',(SELECT customer_id FROM customer WHERE customer.customer_id = 2));
select * from Customer_profile

4-- Use the relevant types of Joins to display:
-- The first_name of the LoggedIn customers
--1 The first_name of the LoggedIn customers
select first_name, isLoggedIn  from customer
INNER JOIN customer_profile ON customer.customer_id = customer_profile.fk_customer_id  ;

--2 All the customers first_name and isLoggedIn columns - even the customers those who don’t have a profile.
select * from customer
LEFT JOIN customer_profile ON customer.customer_id = customer_profile.fk_customer_id;

--3 The number of customers that are not LoggedIn
select COUNT(isLoggedIn) as notLoggedIn from  customer
INNER JOIN customer_profile ON customer.customer_id = customer_profile.fk_customer_id

GROUP BY customer_profile.isLoggedIn
HAVING customer_profile.isLoggedIn IS false ;

--Part II:

--1 Create a table named Book, with the columns : , , book_id SERIAL PRIMARY KEYtitle NOT NULLauthor NOT NULL
CREATE TABLE Book (
  book_id SERIAL PRIMARY KEY,
  title VARCHAR( 100) NOT NULL,
  author VARCHAR( 100) NOT NULL
);
--2 Insert those books :
-- Alice In Wonderland, Lewis Carroll
-- Harry Potter, J.K Rowling
-- To kill a mockingbird, Harper Lee

INSERT INTO Book(title, author)
VALUES('Alice In Wonderland', 'Lewis Carroll'),
		('Harry Potter', 'J.K Rowling'),
		('To kill a mockingbird', 'Harper Lee');
select * from Book

-- 3 Create a table named Student, with the columns : , , . Make sure that the age is never bigger than 15
-- (Find an SQL method);student_id SERIAL PRIMARY KEYname NOT NULL UNIQUEage
CREATE TABLE Student (
  student_id SERIAL PRIMARY KEY,
  name  VARCHAR(100)  UNIQUE NOT NULL,
   age smallint
);

-- 4 Insert those students:
-- John, 12
-- Lera, 11
-- Patrick, 10
-- Bob, 14

INSERT INTO Student(name, age)
VALUES('John', 12),
		('Lera', 11),
		('Patrick', 10),
		 ('Bob', 14);
		 
select * from Student

-- 5 
-- Create a table named Library, with the columns :
-- book_fk_id ON DELETE CASCADE ON UPDATE CASCADE
-- student_id ON DELETE CASCADE ON UPDATE CASCADE
-- borrowed_date
-- This table, is a junction table for a Many to Many relationship with the Book and Student tables : A student can borrow many books, and a book can be borrowed by many children
-- book_fk_id is a Foreign Key representing the column from the Book tablebook_id
-- student_fk_id is a Foreign Key representing the column from the Student tablestudent_id
-- The pair of Foreign Keys is the Primary Key of the Junction Table

CREATE TABLE Library (
   book_fk_id INTEGER NOT NULL,
   student_fk_id INTEGER NOT NULL,
   PRIMARY KEY (book_fk_id, student_fk_id),
   FOREIGN KEY (book_fk_id) REFERENCES book (book_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (student_fk_id) REFERENCES Student (student_id) ON DELETE CASCADE ON UPDATE CASCADE,
   borrowed_date TIMESTAMP
);

--6 Add 4 records in the junction table, use subqueries.

INSERT INTO Library(student_fk_id,book_fk_id,borrowed_date)
-- the student named John, borrowed the book Alice In Wonderland on the 15/02/2022
VALUES  ((SELECT student.student_id FROM Student WHERE student.name ILIKE '%John%'),(SELECT book.book_id FROM book WHERE book.title ILIKE '%Alice%'),'15/02/2022'),
-- the student named Bob, borrowed the book To kill a mockingbird on the 03/03/2021
		((SELECT student.student_id FROM student WHERE student.name ILIKE '%bob%'),(SELECT book.book_id FROM book WHERE book.title ILIKE '%mockingbird%'),'23/05/2021'),
-- 		the student named Lera, borrowed the book Alice In Wonderland on the 23/05/2021
		((SELECT student.student_id FROM student WHERE student.name ILIKE '%lera%'),(SELECT book.book_id FROM book WHERE book.title ILIKE '%Alice%'),'23/05/2021'),
-- 		the student named Bob, borrowed the book Harry Potter the on 12/08/2021
		((SELECT student.student_id FROM student WHERE student.name ILIKE '%Bob%'),(SELECT book.book_id FROM book WHERE book.title ILIKE '%Potter%'),'12/08/2021');



--7
--1Select all the columns from the junction table
select * from Library

--2 Select the name of the student and the title of the borrowed books
select name, book.title from student 
inner join library  on library.student_fk_id = student.student_id
inner join book ON book.book_id = library.book_fk_id;

--3 Select the average age of the children, that borrowed the book Alice in Wonderland
select AVG(student.age) AS average_age from student 
inner join library  on library.student_fk_id = student.student_id
inner join book ON book.book_id = library.book_fk_id;

--4 Delete a student from the Student table, what happened in the junction table ?
DELETE FROM student
WHERE student.student_id =1

l'element a ete suprimer dans toutes les tables









