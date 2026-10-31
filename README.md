# ExamSphere: Online Examination System

A Spring Boot web application for running timed online exams, with separate Admin and Student workflows, automatic grading and result history.

## Features

**Student**
- Register (full name, email, phone, gender, date of birth, institution) and log in with email and password
- Dashboard listing available exams
- Take a timed exam: countdown timer that auto-submits when time runs out, plus a warning before leaving the page
- Attempt limit per exam (`maxAttempts`), checked on the server before grading
- Automatic grading on submit: score, correct and incorrect counts, percentage and pass or fail status (pass mark 40%)
- Answer review after submission, showing the selected and correct option for each question
- Exam history and profile pages

**Admin**
- Dashboard with total exams, questions, students and attempts, plus the five most recent results
- Create, edit and delete exams (title, description, duration, total marks, max attempts)
- Add, edit, delete and view MCQ questions per exam (four options, correct answer, marks)
- View all results
- Manage students: list, edit and delete

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Java 21 |
| Framework | Spring Boot 4.1.1, Spring Web MVC |
| Persistence | Spring Data JPA, Hibernate, MySQL (`mysql-connector-j`) |
| Views | JSP, JSTL (Tomcat Jasper), CSS, JavaScript |
| Build | Maven (Maven Wrapper included) |

## Architecture

```text
JSP views (WEB-INF/views)  ->  Controllers  ->  Services  ->  Spring Data JPA repositories  ->  MySQL

src/main/java/com/mvc/
  controller/   AuthController, AdminController, StudentController
  model/        User, Exam, Question, Result, ExamHistory (JPA entities)
  repository/   One JpaRepository per entity, with derived queries such as
                countByStudent_IdAndExam_Id and findByExamId
  service/      UserService, ExamService, QuestionService, ResultService, ExamHistoryService
src/main/webapp/
  WEB-INF/views/   17 JSP pages
  js/app.js        Exam timer, auto-submit and question navigator
  css/style.css
```

## Routes

| Method | Path | Description |
|---|---|---|
| GET | `/` | Home page |
| GET, POST | `/register` | Student registration |
| GET, POST | `/login` | Login (admin or student) |
| GET | `/logout` | End the session |
| GET | `/student/dashboard` | Student dashboard |
| GET | `/student/exam/{id}` | Take an exam (alias `/student/take-exam/{id}`) |
| POST | `/student/submit/{id}` | Submit answers and grade the attempt |
| GET | `/student/history` | Past results |
| GET | `/student/profile` | Student profile |
| GET | `/admin/dashboard` | Admin dashboard |
| GET | `/admin/exams` | List exams (alias `/admin/findAllExams`) |
| GET | `/admin/exam/create` | Create exam form |
| POST | `/admin/createExam` | Save a new exam |
| GET | `/admin/exam/edit/{id}` | Edit exam form |
| POST | `/admin/exam/update` | Update an exam |
| GET | `/admin/deleteExam/{id}` | Delete an exam |
| GET | `/admin/questions/{examId}` | Questions for an exam |
| GET | `/admin/question/add` | Add question form |
| POST | `/admin/addQuestion` | Save a question |
| GET | `/admin/question/edit/{id}` | Edit question form |
| POST | `/admin/question/update` | Update a question |
| GET | `/admin/question/delete/{id}` | Delete a question |
| GET | `/admin/results` | All results |
| GET | `/admin/students` | List students |
| GET | `/admin/student/edit/{id}` | Edit student form |
| POST | `/admin/student/update` | Update a student |
| GET | `/admin/student/delete/{id}` | Delete a student |

## Data Model

| Entity | Key fields | Relationships |
|---|---|---|
| `User` (`users`) | id, fullName, email, phoneNumber, gender, dob, institution, username, password, role | Has many results |
| `Exam` | id, title, description, duration, totalMarks, maxAttempts | Has many questions |
| `Question` | id, questionText, optionA to optionD, correctAnswer, marks | Many-to-one exam |
| `Result` (`results`) | id, score, totalMarks, percentage, passStatus, correctCount, incorrectCount, attemptedAt | Many-to-one student and exam |
| `ExamHistory` | id, userId, userEmail, examId, examTitle, score, totalMarks, attemptedAt | Denormalized attempt log |

Tables are created by Hibernate (`spring.jpa.hibernate.ddl-auto=update`).

## Getting Started

**Prerequisites:** JDK 21, MySQL 8, Maven (or the included Maven Wrapper: `sh mvnw spring-boot:run`).

1. Clone the repository.
   ```bash
   git clone https://github.com/abhiramkamarajugadda/Online_Examination_System.git
   cd Online_Examination_System
   ```
2. Create the database used in `application.properties`.
   ```sql
   CREATE DATABASE online_exam;
   ```
3. Set `spring.datasource.username` and `spring.datasource.password` in `src/main/resources/application.properties` to your local MySQL values.
4. Run the application.
   ```bash
   mvn spring-boot:run
   ```
   On Windows: `mvnw.cmd spring-boot:run`
5. Open `http://localhost:4545`.

The admin account is defined in `AuthController`; change it before any real use.

## Author

**Abhiram Kamarajugadda**
GitHub: [abhiramkamarajugadda](https://github.com/abhiramkamarajugadda) | Portfolio: [abhiramkamarajugadda.github.io](https://abhiramkamarajugadda.github.io)
