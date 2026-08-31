# 📝 Online Examination System

<p align="center">
  <b>A Java Spring Boot based Online Examination System</b>
</p>

<p align="center">
  Built with Java, Spring Boot, Spring Data JPA, JSP/JSTL and MySQL.
</p>

---

## 📌 Project Overview

The **Online Examination System** is a web-based application designed to simplify and manage the process of conducting examinations online.

The application is developed using **Java and Spring Boot**, with **Spring MVC** for web request handling, **Spring Data JPA** for database operations, **JSP/JSTL** for the user interface, and **MySQL** for data storage.

The project includes a `database.sql` file for setting up the required database.

---

## 🚀 Features

### 👨‍🎓 Student

* Student login
* Access online examinations
* View examination questions
* Submit answers
* Complete examinations
* View examination results

### 👨‍💼 Admin

* Admin login
* Manage users
* Manage examinations
* Manage questions
* Manage examination data
* View examination-related information

---

## 🛠️ Technologies Used

| Technology                | Purpose                       |
| ------------------------- | ----------------------------- |
| ☕ Java 21                 | Backend Development           |
| 🌱 Spring Boot 4.1.1      | Application Framework         |
| 🌐 Spring MVC             | Web Request Handling          |
| 🗃️ Spring Data JPA       | Database Operations           |
| 🔄 Hibernate              | ORM                           |
| 🐬 MySQL                  | Database                      |
| 📄 JSP                    | View Layer                    |
| 🔧 JSTL                   | JSP Functionality             |
| 🚀 Apache Tomcat / Jasper | JSP Processing                |
| 📦 Maven                  | Build & Dependency Management |

---

## 🏗️ Project Architecture

```text
                    ┌─────────────────────┐
                    │     JSP / JSTL      │
                    │    User Interface   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │     Controller      │
                    │     Spring MVC      │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │       Service       │
                    │   Business Logic    │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │     Repository      │
                    │   Spring Data JPA   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │       MySQL         │
                    │  online_exam_db     │
                    └─────────────────────┘
```

---

## 📂 Project Structure

```text
Online-Examination-System/
│
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── ...
│   │   │
│   │   ├── resources/
│   │   │   └── ...
│   │   │
│   │   └── webapp/
│   │       └── ...
│   │
│   └── test/
│       └── ...
│
├── database.sql
├── pom.xml
├── mvnw
├── mvnw.cmd
└── README.md
```

---

## 🗄️ Database Setup

The application uses **MySQL**.

### Database Name

```text
online_exam_db
```

### Create Database

```sql
CREATE DATABASE online_exam_db;
```

### Import Database

The project contains:

```text
database.sql
```

Open the file using **MySQL Workbench** and execute the SQL script.

### Configure Database Connection

Update your Spring Boot configuration:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/online_exam_db
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

Replace `YOUR_PASSWORD` with your MySQL password.

---

## ⚙️ Prerequisites

Before running the project, make sure you have:

* Java JDK 21
* MySQL
* Maven
* Git
* Eclipse / IntelliJ IDEA / Spring Tool Suite

---

## ▶️ How to Run

### 1. Clone the Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

### 2. Navigate to the Project

```bash
cd Online-Examination-System
```

### 3. Configure MySQL

Create the `online_exam_db` database and execute the `database.sql` file.

### 4. Configure Application

Update the database username and password in the Spring Boot configuration file.

### 5. Run the Application

Using Maven:

```bash
mvn spring-boot:run
```

### Windows

```cmd
mvnw.cmd spring-boot:run
```

### Linux / macOS

```bash
./mvnw spring-boot:run
```

---

## 🌐 Access the Application

Once the application starts successfully, open:

```text
http://localhost:8080/
```

The exact page URL depends on the controller mappings implemented in the project.

---

## 🔐 User Roles

The system includes user information and supports an **ADMIN** role.

```text
ADMIN
```

Student functionality is provided through the examination workflow implemented in the application.

---

## 🧪 Testing

Run the application tests using:

```bash
mvn test
```

On Windows:

```cmd
mvnw.cmd test
```

---

## 📦 Build

Build the project using:

```bash
mvn clean package
```

Run the generated JAR:

```bash
java -jar target/EMS-0.0.1-SNAPSHOT.jar
```

---

## 📸 Screenshots

Add your application screenshots here.

Create a folder:

```text
screenshots/
```

Example:

```text
screenshots/
├── login.png
├── student-dashboard.png
├── exam.png
├── result.png
└── admin-dashboard.png
```

Then add them to the README:

```markdown
## 📸 Screenshots

### Login Page

![Login Page](screenshots/login.png)

### Student Dashboard

![Student Dashboard](screenshots/student-dashboard.png)

### Examination Page

![Examination Page](screenshots/exam.png)

### Result Page

![Result Page](screenshots/result.png)

### Admin Dashboard

![Admin Dashboard](screenshots/admin-dashboard.png)
```

---

## 🔮 Future Enhancements

* ⏱️ Online exam countdown timer
* 🔐 Secure authentication
* 🔑 Password encryption
* 👥 Role-based authorization
* 📝 Question bank management
* 📊 Student performance analytics
* 📈 Result dashboard
* 🔎 Search and filtering
* 📄 Pagination
* 📧 Email result notifications
* 🎨 Responsive Bootstrap UI
* 🌐 REST API integration
* 🐳 Docker support
* ☁️ Cloud deployment

---

## 🎯 Learning Outcomes

This project provides practical experience with:

* Java backend development
* Spring Boot
* Spring MVC
* Spring Data JPA
* Hibernate
* MySQL database integration
* JSP and JSTL
* Maven
* CRUD operations
* Layered application architecture
* Web application development

---

## 👨‍💻 Author

**Abhiram**

**B.Tech – Computer Science Engineering**

### Technologies

`Java` `Spring Boot` `Spring MVC` `JPA` `Hibernate` `MySQL` `JSP` `JSTL` `Maven`

---

## ⭐ Support

If you find this project useful, please consider giving the repository a ⭐ on GitHub.

---

## 📄 License

This project is created for **educational and portfolio purposes**.
