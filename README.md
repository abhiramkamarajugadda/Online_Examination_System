# ExamSphere: Online Examination System

[![CI](https://github.com/abhiramkamarajugadda/Online_Examination_System/actions/workflows/ci.yml/badge.svg)](https://github.com/abhiramkamarajugadda/Online_Examination_System/actions/workflows/ci.yml)

A Spring Boot web application for running timed online exams, with separate Admin and Student workflows, automatic grading and result history.

## Live Demo

**Live link:** [abhi-examsphere.onrender.com](https://abhi-examsphere.onrender.com)

> Note: the free server sleeps when idle, so the first visit may take about a minute to wake up.

Demo student login: `demo@examsphere.com` / `demo123` (a public demo account). Try the seeded **Java Fundamentals (Sample)** exam, or register your own student account.

## Features

**Student**
- Register (full name, email, phone, gender, date of birth, institution) and log in with email and password
- Dashboard listing available exams
- Take a timed exam: countdown timer that auto-submits when time runs out, plus a warning before leaving the page
- Attempt limit per exam (`maxAttempts`), checked on the server before grading
- Automatic grading on submit: score, correct and incorrect counts, percentage and pass or fail status (pass mark 40%)
- Answer review after submission, showing the selected and correct option for each question
- Exam history and profile pages
- Passwords stored as BCrypt hashes (older plain-text rows are upgraded on the next login)

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
| Security | BCrypt password hashing (`spring-security-crypto`) |
| Testing | JUnit 5, `@SpringBootTest` with MockMvc, H2 (test scope) |
| CI/CD | GitHub Actions (`mvn -B verify` on JDK 21, Docker image build) |
| Containers | Multi-stage Dockerfile (JDK 21 build, JRE 21 runtime) |
| Build | Maven, WAR packaging so the JSPs run under embedded Tomcat (`java -jar app.war`) |

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
2. Start MySQL 8. The `online_exam` database is created on first run (`createDatabaseIfNotExist=true`).
3. Set the database credentials as environment variables (see `.env.example`):
   ```bash
   export DB_USERNAME=root
   export DB_PASSWORD=your_mysql_password
   ```
4. Run the application.
   ```bash
   mvn spring-boot:run
   ```
   On Windows: `mvnw.cmd spring-boot:run`
5. Open `http://localhost:4545`.

On an empty database the app seeds a sample exam with 5 questions and the demo student (turn off with `DEMO_SEED=false`). The admin login comes from `ADMIN_EMAIL` and `ADMIN_PASSWORD` (local defaults: `admin@examsphere.com` / `admin123`).

## Running with Docker

```bash
docker build -t examsphere .
docker run -p 4545:4545 -e DB_URL="jdbc:mysql://host.docker.internal:3306/online_exam?createDatabaseIfNotExist=true" \
  -e DB_PASSWORD=your_mysql_password -e ADMIN_PASSWORD=choose_one examsphere
```

## Deploy to Render (free) with Aiven MySQL

Both services have free plans with no card needed.

1. **Database:** create a free MySQL service on [Aiven](https://aiven.io). From its overview page copy the host, port, user (`avnadmin`) and password.
2. **App:** on [Render](https://render.com) choose **New > Blueprint** and pick this repository. `render.yaml` builds the `Dockerfile` on the free plan.
3. Fill in the environment variables Render asks for:
   | Variable | Value |
   |---|---|
   | `SPRING_DATASOURCE_URL` | `jdbc:mysql://<aiven-host>:<port>/examsphere?sslMode=REQUIRED&createDatabaseIfNotExist=true` (own `examsphere` schema, created on first start, so one free Aiven service can host several apps) |
   | `SPRING_DATASOURCE_USERNAME` | `avnadmin` |
   | `SPRING_DATASOURCE_PASSWORD` | Aiven password |
   | `ADMIN_EMAIL` | Admin login email |
   | `ADMIN_PASSWORD` | Generated by Render automatically |
   | `DEMO_SEED` | `true` |
4. Deploy. Hibernate creates the tables and the sample exam is seeded on first start. Render sets `PORT`; the image caps the heap at 300 MB to fit the 512 MB free instance.

## Tests

```bash
mvn -B verify
```

Runs 5 tests on an in-memory H2 database (no MySQL needed): demo seed, home and login pages, registration with BCrypt hashing and a forced `STUDENT` role, upgrade of legacy plain-text passwords, and admin login from configuration. GitHub Actions runs the same build on JDK 21 and builds the Docker image on every push.

## Author

**Abhiram Kamarajugadda**
GitHub: [abhiramkamarajugadda](https://github.com/abhiramkamarajugadda) | Portfolio: [abhiramkamarajugadda.github.io](https://abhiramkamarajugadda.github.io)
