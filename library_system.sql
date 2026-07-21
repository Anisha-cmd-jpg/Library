-- ============================================================
-- LIBRARY MANAGEMENT SYSTEM - MySQL Script
-- Author: Anisha M.
-- Run this entire file in MySQL Workbench (File > Open SQL Script)
-- ============================================================

DROP DATABASE IF EXISTS library_system;
CREATE DATABASE library_system;
USE library_system;

-- ------------------------------------------------------------
-- TABLE 1: BOOKS
-- ------------------------------------------------------------
CREATE TABLE books (
    book_id       INT PRIMARY KEY AUTO_INCREMENT,
    title         VARCHAR(150) NOT NULL,
    author        VARCHAR(100) NOT NULL,
    genre         VARCHAR(50),
    total_copies  INT DEFAULT 2
);

-- ------------------------------------------------------------
-- TABLE 2: MEMBERS
-- ------------------------------------------------------------
CREATE TABLE members (
    member_id           INT PRIMARY KEY AUTO_INCREMENT,
    member_name          VARCHAR(100) NOT NULL,
    city                 VARCHAR(50),
    join_date            DATE,
    membership_status    VARCHAR(20) DEFAULT 'Active',   -- Active / Renewed / Expired
    renewal_date         DATE
);

-- ------------------------------------------------------------
-- TABLE 3: ISSUE / RETURN RECORDS
-- ------------------------------------------------------------
CREATE TABLE issue_records (
    issue_id      INT PRIMARY KEY AUTO_INCREMENT,
    book_id       INT,
    member_id     INT,
    issue_date    DATE,
    due_date      DATE,
    return_date   DATE NULL,          -- NULL means not yet returned
    fine_paid     DECIMAL(6,2) DEFAULT 0,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- ============================================================
-- INSERT DATA: 100 BOOKS (title, author, genre)
-- ============================================================
INSERT INTO books (title, author, genre, total_copies) VALUES
('The Guide', 'R.K. Narayan', 'Fiction', 3),
('Malgudi Days', 'R.K. Narayan', 'Short Stories', 2),
('Midnight''s Children', 'Salman Rushdie', 'Fiction', 2),
('The God of Small Things', 'Arundhati Roy', 'Fiction', 3),
('A Suitable Boy', 'Vikram Seth', 'Fiction', 2),
('Train to Pakistan', 'Khushwant Singh', 'Historical Fiction', 2),
('The White Tiger', 'Aravind Adiga', 'Fiction', 2),
('Interpreter of Maladies', 'Jhumpa Lahiri', 'Short Stories', 2),
('The Namesake', 'Jhumpa Lahiri', 'Fiction', 2),
('Five Point Someone', 'Chetan Bhagat', 'Fiction', 3),
('2 States', 'Chetan Bhagat', 'Fiction', 3),
('The Palace of Illusions', 'Chitra Banerjee Divakaruni', 'Mythology', 2),
('Ramayana', 'C. Rajagopalachari', 'Mythology', 3),
('Mahabharata', 'C. Rajagopalachari', 'Mythology', 3),
('Discovery of India', 'Jawaharlal Nehru', 'History', 2),
('Wings of Fire', 'A.P.J. Abdul Kalam', 'Autobiography', 4),
('India 2020', 'A.P.J. Abdul Kalam', 'Non-Fiction', 2),
('The Argumentative Indian', 'Amartya Sen', 'Non-Fiction', 2),
('Sacred Games', 'Vikram Chandra', 'Thriller', 2),
('The Immortals of Meluha', 'Amish Tripathi', 'Mythology', 3),
('The Secret of the Nagas', 'Amish Tripathi', 'Mythology', 2),
('The Oath of the Vayuputras', 'Amish Tripathi', 'Mythology', 2),
('Ikigai', 'Hector Garcia', 'Self-Help', 3),
('Atomic Habits', 'James Clear', 'Self-Help', 4),
('Rich Dad Poor Dad', 'Robert Kiyosaki', 'Finance', 3),
('Think and Grow Rich', 'Napoleon Hill', 'Self-Help', 2),
('The Alchemist', 'Paulo Coelho', 'Fiction', 4),
('The Monk Who Sold His Ferrari', 'Robin Sharma', 'Self-Help', 3),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 2),
('1984', 'George Orwell', 'Dystopian', 3),
('Animal Farm', 'George Orwell', 'Political Satire', 2),
('Pride and Prejudice', 'Jane Austen', 'Romance', 2),
('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 'Fantasy', 4),
('Harry Potter and the Chamber of Secrets', 'J.K. Rowling', 'Fantasy', 3),
('The Da Vinci Code', 'Dan Brown', 'Thriller', 3),
('Angels and Demons', 'Dan Brown', 'Thriller', 2),
('The Kite Runner', 'Khaled Hosseini', 'Fiction', 2),
('A Thousand Splendid Suns', 'Khaled Hosseini', 'Fiction', 2),
('Life of Pi', 'Yann Martel', 'Fiction', 2),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 3),
('The Fault in Our Stars', 'John Green', 'Romance', 2),
('Sapiens', 'Yuval Noah Harari', 'Non-Fiction', 3),
('Homo Deus', 'Yuval Noah Harari', 'Non-Fiction', 2),
('The Power of Your Subconscious Mind', 'Joseph Murphy', 'Self-Help', 2),
('Introduction to Algorithms', 'Thomas H. Cormen', 'Computer Science', 2),
('Clean Code', 'Robert C. Martin', 'Computer Science', 2),
('Wings of Fire (Dragon Series)', 'Tui T. Sutherland', 'Fantasy', 2),
('Gitanjali', 'Rabindranath Tagore', 'Poetry', 2),
('Gora', 'Rabindranath Tagore', 'Fiction', 2),
('Chanakya''s Chant', 'Ashwin Sanghi', 'Historical Fiction', 2),
('The Krishna Key', 'Ashwin Sanghi', 'Mythology', 2),
('Half Girlfriend', 'Chetan Bhagat', 'Romance', 3),
('The Rozabal Line', 'Ashwin Sanghi', 'Thriller', 2),
('Sita: Warrior of Mithila', 'Amish Tripathi', 'Mythology', 2),
('Scion of Ikshvaku', 'Amish Tripathi', 'Mythology', 2),
('The Inheritance of Loss', 'Kiran Desai', 'Fiction', 2),
('A Fine Balance', 'Rohinton Mistry', 'Fiction', 2),
('Em and the Big Hoom', 'Jerry Pinto', 'Fiction', 2),
('The Shadow Lines', 'Amitav Ghosh', 'Fiction', 2),
('Sea of Poppies', 'Amitav Ghosh', 'Historical Fiction', 2),
('River of Smoke', 'Amitav Ghosh', 'Historical Fiction', 2),
('The Great Indian Novel', 'Shashi Tharoor', 'Fiction', 2),
('An Era of Darkness', 'Shashi Tharoor', 'History', 2),
('India After Gandhi', 'Ramachandra Guha', 'History', 2),
('The Difficulty of Being Good', 'Gurcharan Das', 'Non-Fiction', 2),
('My Experiments with Truth', 'Mahatma Gandhi', 'Autobiography', 3),
('Freedom at Midnight', 'Dominique Lapierre', 'History', 2),
('The Tiger King', 'Kalki Krishnamurthy', 'Short Stories', 2),
('Ponniyin Selvan Part 1', 'Kalki Krishnamurthy', 'Historical Fiction', 3),
('Ponniyin Selvan Part 2', 'Kalki Krishnamurthy', 'Historical Fiction', 2),
('Chemmeen', 'Thakazhi Sivasankara Pillai', 'Fiction', 2),
('Parva', 'S.L. Bhyrappa', 'Mythology', 2),
('Yayati', 'V.S. Khandekar', 'Mythology', 2),
('Karna''s Wife', 'Kavita Kane', 'Mythology', 2),
('Lanka''s Princess', 'Kavita Kane', 'Mythology', 2),
('The Immortals of Meluha Collection', 'Amish Tripathi', 'Mythology', 2),
('Legend of Suheldev', 'Amish Tripathi', 'Historical Fiction', 2),
('One Indian Girl', 'Chetan Bhagat', 'Fiction', 2),
('Revolution 2020', 'Chetan Bhagat', 'Fiction', 2),
('The 3 Mistakes of My Life', 'Chetan Bhagat', 'Fiction', 2),
('Norwegian Wood', 'Haruki Murakami', 'Fiction', 2),
('Kafka on the Shore', 'Haruki Murakami', 'Fiction', 2),
('The Old Man and the Sea', 'Ernest Hemingway', 'Fiction', 2),
('Crime and Punishment', 'Fyodor Dostoevsky', 'Fiction', 2),
('War and Peace', 'Leo Tolstoy', 'Fiction', 2),
('Anna Karenina', 'Leo Tolstoy', 'Fiction', 2),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 2),
('Brave New World', 'Aldous Huxley', 'Dystopian', 2),
('Fahrenheit 451', 'Ray Bradbury', 'Dystopian', 2),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 2),
('Wuthering Heights', 'Emily Bronte', 'Romance', 2),
('Jane Eyre', 'Charlotte Bronte', 'Romance', 2),
('Little Women', 'Louisa May Alcott', 'Fiction', 2),
('Moby Dick', 'Herman Melville', 'Fiction', 2),
('The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 3),
('Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', 'Fantasy', 3),
('Harry Potter and the Goblet of Fire', 'J.K. Rowling', 'Fantasy', 3),
('The Chronicles of Narnia', 'C.S. Lewis', 'Fantasy', 2),
('A Game of Thrones', 'George R.R. Martin', 'Fantasy', 3),
('The Hunger Games', 'Suzanne Collins', 'Dystopian', 3);

-- ============================================================
-- INSERT DATA: 20 MEMBERS (Indian names and cities)
-- ============================================================
INSERT INTO members (member_name, city, join_date, membership_status, renewal_date) VALUES
('Anisha Murugan', 'Coimbatore', '2023-01-15', 'Renewed', '2026-01-15'),
('Karthik Raja', 'Chennai', '2023-02-10', 'Active', NULL),
('Divya Prakash', 'Bengaluru', '2023-03-05', 'Renewed', '2026-03-05'),
('Suresh Kumar', 'Coimbatore', '2023-04-20', 'Expired', NULL),
('Priya Venkatesh', 'Madurai', '2023-05-12', 'Renewed', '2026-05-12'),
('Arjun Nair', 'Kochi', '2023-06-18', 'Active', NULL),
('Meena Sundaram', 'Coimbatore', '2023-07-01', 'Renewed', '2026-07-01'),
('Ravi Shankar', 'Salem', '2023-07-25', 'Expired', NULL),
('Lakshmi Iyer', 'Chennai', '2023-08-14', 'Active', NULL),
('Vignesh Babu', 'Trichy', '2023-09-09', 'Renewed', '2026-09-09'),
('Sneha Reddy', 'Hyderabad', '2023-10-02', 'Active', NULL),
('Manoj Pillai', 'Trivandrum', '2023-10-30', 'Expired', NULL),
('Anjali Krishnan', 'Coimbatore', '2023-11-11', 'Renewed', '2026-01-11'),
('Deepak Menon', 'Kozhikode', '2023-12-05', 'Active', NULL),
('Kavya Balan', 'Bengaluru', '2024-01-19', 'Renewed', '2026-02-19'),
('Naveen Chandran', 'Coimbatore', '2024-02-22', 'Active', NULL),
('Pooja Rajan', 'Madurai', '2024-03-15', 'Expired', NULL),
('Harish Gopal', 'Chennai', '2024-04-08', 'Renewed', '2026-04-08'),
('Swathi Muthu', 'Coimbatore', '2024-05-27', 'Active', NULL),
('Rajesh Anand', 'Salem', '2024-06-10', 'Renewed', '2026-06-10');

-- ============================================================
-- INSERT DATA: ISSUE / RETURN RECORDS
-- Mix of: returned on time, returned late (fine paid),
--         not returned but not yet due, not returned & overdue (fine pending)
-- ============================================================
INSERT INTO issue_records (book_id, member_id, issue_date, due_date, return_date, fine_paid) VALUES
-- Returned ON TIME
(1, 1, '2026-06-01', '2026-06-15', '2026-06-14', 0),
(2, 2, '2026-06-02', '2026-06-16', '2026-06-16', 0),
(3, 3, '2026-06-03', '2026-06-17', '2026-06-15', 0),
(4, 4, '2026-06-04', '2026-06-18', '2026-06-18', 0),
(5, 5, '2026-06-05', '2026-06-19', '2026-06-17', 0),
(6, 6, '2026-06-06', '2026-06-20', '2026-06-20', 0),
(7, 7, '2026-06-07', '2026-06-21', '2026-06-19', 0),
(8, 8, '2026-06-08', '2026-06-22', '2026-06-22', 0),
(9, 9, '2026-06-09', '2026-06-23', '2026-06-21', 0),
(10, 10, '2026-06-10', '2026-06-24', '2026-06-24', 0),

-- Returned LATE (fine already paid, at Rs 5/day)
(11, 11, '2026-05-20', '2026-06-03', '2026-06-08', 25),
(12, 12, '2026-05-22', '2026-06-05', '2026-06-12', 35),
(13, 13, '2026-05-25', '2026-06-08', '2026-06-10', 10),
(14, 14, '2026-05-28', '2026-06-11', '2026-06-20', 45),
(15, 15, '2026-06-01', '2026-06-15', '2026-06-19', 20),

-- NOT YET RETURNED, still within due date (no fine)
(16, 16, '2026-07-10', '2026-07-24', NULL, 0),
(17, 17, '2026-07-12', '2026-07-26', NULL, 0),
(18, 1, '2026-07-14', '2026-07-28', NULL, 0),

-- NOT YET RETURNED and OVERDUE (fine pending as of today, 2026-07-21)
(19, 4, '2026-06-15', '2026-06-29', NULL, 0),
(20, 8, '2026-06-20', '2026-07-04', NULL, 0),
(21, 12, '2026-06-25', '2026-07-09', NULL, 0),
(22, 17, '2026-06-28', '2026-07-12', NULL, 0),
(23, 20, '2026-07-01', '2026-07-15', NULL, 0),
(24, 9, '2026-07-02', '2026-07-16', NULL, 0),
(25, 6, '2026-07-05', '2026-07-19', NULL, 0);

-- ============================================================
-- REQUIRED QUERIES
-- ============================================================

-- 1. Number of books in library, with names and authors
SELECT COUNT(*) AS total_books FROM books;
SELECT book_id, title, author, genre FROM books;

-- 2. Members' names
SELECT member_id, member_name, city FROM members;

-- 3. Books returned ON TIME by members
SELECT
    m.member_name,
    b.title,
    ir.issue_date,
    ir.due_date,
    ir.return_date
FROM issue_records ir
JOIN members m ON ir.member_id = m.member_id
JOIN books b   ON ir.book_id   = b.book_id
WHERE ir.return_date IS NOT NULL
  AND ir.return_date <= ir.due_date;

-- 4. Books still to be returned, WITH FINE calculated (Rs 5 per day overdue)
SELECT
    m.member_name,
    b.title,
    ir.due_date,
    DATEDIFF(CURDATE(), ir.due_date) AS days_overdue,
    DATEDIFF(CURDATE(), ir.due_date) * 5 AS fine_amount
FROM issue_records ir
JOIN members m ON ir.member_id = m.member_id
JOIN books b   ON ir.book_id   = b.book_id
WHERE ir.return_date IS NULL
  AND ir.due_date < CURDATE();

-- 5. Memberships renewed
SELECT member_name, city, join_date, renewal_date
FROM members
WHERE membership_status = 'Renewed';
