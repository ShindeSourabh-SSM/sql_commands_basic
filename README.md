# College Database Management SQL Script

This repository contains an SQL script for creating and managing a college database. The database includes three tables: `Students`, `Courses`, and `Enrollments`, along with a set of queries, functions, and triggers to demonstrate advanced SQL features.

## **Features**
- Database creation with tables and relationships.
- Data insertion with constraints and checks.
- Use of `JOIN`, `CLAUSES`, and `AGGREGATE FUNCTIONS`.
- A `VIEW` to display student course details.
- A `FUNCTION` to calculate total credits for a student.
- A `TRIGGER` to prevent duplicate enrollments.

## **Schema Overview**
1. **Tables**:
    - `Students`: Stores student information (ID, Name, Email, DOB, Gender).
    - `Courses`: Stores course details (ID, Name, Credits).
    - `Enrollments`: Tracks student course enrollments (ID, StudentID, CourseID, Date, Grade).

2. **Relationships**:
    - `Enrollments` references `Students` and `Courses` using foreign keys.
    - On deletion of a student or course, related enrollments are automatically removed.

## **Setup**
1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/college-database-sql.git
    cd college-database-sql
    ```
2. Open MySQL Workbench and execute the script file `college_database.sql`.

## **How to Use**
1. Run the script in MySQL Workbench 8.0.
2. Execute the queries to:
    - View all data in tables.
    - Test the `TotalCredits` function:
      ```sql
      SELECT TotalCredits(1) AS TotalCreditsForStudent1;
      ```
    - Test the `StudentCourses` view:
      ```sql
      SELECT * FROM StudentCourses;
      ```
    - Test the trigger by attempting duplicate enrollments.

## **Outputs**
### Example Outputs:
- **Total Credits Function**:
    ```sql
    SELECT TotalCredits(1) AS TotalCreditsForStudent1;
    ```
    Output:
    | TotalCreditsForStudent1 |
    |--------------------------|
    | 7                        |

- **StudentCourses View**:
    ```sql
    SELECT * FROM StudentCourses;
    ```
    Output:
    | StudentID | StudentName   | CourseName        | EnrollmentDate | Grade |
    |-----------|---------------|-------------------|----------------|-------|
    | 1         | John Doe      | Database Systems  | 2025-01-13     | A     |
    | 2         | Jane Smith    | Operating Systems | 2025-01-13     | B     |

## **Screenshots**
![MySQL Workbench Output]
![image](https://github.com/user-attachments/assets/39ea892b-0d5e-434e-bef9-50a7a7c8a863)


![MySQL Workbench StudentCourses View]
![Uploading Screenshot 2025-01-13 163503.png…]()
![image](https://github.com/user-attachments/assets/7ca61cfb-63ec-4fc7-930d-5165230b8ce6)
![image](https://github.com/user-attachments/assets/fc34ef87-e1db-41ae-9ca0-ed0300b34b5e)


**-- Fetch student details with their enrolled courses**
![image](https://github.com/user-attachments/assets/dd31586f-90c8-46ec-bf08-306bccd5e92e)


**-- Query to fetch students with an 'A' grade**
![image](https://github.com/user-attachments/assets/cded07f3-0249-413d-8df3-8bc5ce936937)

**-- Query to fetch courses with the total number of enrolled students**
![image](https://github.com/user-attachments/assets/08001f04-d8f6-4cdb-894b-43ae70dcd4df)

**-- Query with clauses to filter and order data**
![image](https://github.com/user-attachments/assets/bf1ed1d3-4400-494f-bc37-d8c8e5cae258)





## **Contributing**
Feel free to open an issue or submit a pull request for improvements or bug fixes.

## **License**
This project is licensed under the MIT License.
