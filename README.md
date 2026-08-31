# 👨‍💼 Employee Management System

<p align="center">
  <b>A Java Spring Boot based Employee Management System</b>
</p>

<p align="center">
  Built with Java, Spring Boot, Spring Data JPA, JSP/JSTL and MySQL.
</p>

---

## 📌 About The Project

The **Employee Management System (EMS)** is a web-based application developed using **Java and Spring Boot** to manage employee information.

The project follows a layered architecture and uses **Spring Data JPA** for database persistence and **MySQL** as the relational database. The web interface is developed using **JSP and JSTL**.

This project demonstrates practical implementation of backend development concepts such as:

* Spring Boot
* Spring MVC
* Spring Data JPA
* Hibernate
* MySQL database integration
* JSP/JSTL
* Maven
* Layered architecture

---

## 🚀 Features

* 👤 Employee management
* ➕ Add employee information
* 📋 View employee information
* ✏️ Update employee information
* 🗑️ Delete employee information
* 💾 MySQL database persistence
* 🔗 Spring Data JPA integration
* 🌐 Spring MVC web application
* 🖥️ JSP/JSTL based user interface

> The exact features and URL mappings depend on the controllers, services, entities and JSP pages included in the project source.

---

## 🛠️ Tech Stack

| Technology              | Usage                 |
| ----------------------- | --------------------- |
| ☕ Java 21               | Backend programming   |
| 🌱 Spring Boot 4.1.1    | Application framework |
| 🌐 Spring Web MVC       | Web layer             |
| 🗃️ Spring Data JPA     | Database operations   |
| 🐬 MySQL                | Database              |
| 📄 JSP                  | Frontend/view layer   |
| 🔧 JSTL                 | JSP functionality     |
| 📦 Maven                | Dependency management |
| 🚀 Apache Tomcat/Jasper | JSP processing        |

The project's `pom.xml` confirms these major dependencies and Java version.

---

## 🏗️ Project Architecture

```text
                ┌──────────────────────┐
                │      JSP / JSTL      │
                │    User Interface    │
                └──────────┬───────────┘
                           │
                           ▼
                ┌──────────────────────┐
                │     Controller       │
                │    Spring MVC        │
                └──────────┬───────────┘
                           │
                           ▼
                ┌──────────────────────┐
                │       Service        │
                │    Business Logic    │
                └──────────┬───────────┘
                           │
                           ▼
                ┌──────────────────────┐
                │      Repository      │
                │   Spring Data JPA   │
                └──────────┬───────────┘
                           │
                           ▼
                ┌──────────────────────┐
                │        MySQL         │
                │       Database       │
                └──────────────────────┘
```

---

## 📂 Project Structure

```text
EMS/
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

A `database.sql` file is included in the project.

### 1. Install MySQL

Install MySQL Server and MySQL Workbench.

### 2. Create the Database

For example:

```sql
CREATE DATABASE ems;
```

### 3. Execute Database Script

Open the provided:

```text
database.sql
```

and execute it in MySQL Workbench.

### 4. Configure Database Connection

Update your Spring Boot configuration:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/ems
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

Replace `YOUR_PASSWORD` with your local MySQL password.

---

## ⚙️ Requirements

Before running the project, make sure you have:

* Java Development Kit **21**
* MySQL
* Maven
* Git
* IDE such as:

  * Eclipse
  * IntelliJ IDEA
  * Spring Tool Suite

---

## ▶️ Running the Application

### Clone the Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

### Navigate to the Project

```bash
cd EMS
```

### Run Using Maven

```bash
mvn spring-boot:run
```

### Or Using Maven Wrapper

**Windows:**

```cmd
mvnw.cmd spring-boot:run
```

**Linux/macOS:**

```bash
./mvnw spring-boot:run
```

---

## 🌐 Open in Browser

After successfully starting the application:

```text
http://localhost:8080/
```

The exact application page depends on the controller mappings configured in the project.

---

## 🧪 Testing

Run the tests using:

```bash
mvn test
```

Or on Windows:

```cmd
mvnw.cmd test
```

The project includes Spring Boot testing dependencies for JPA and Web MVC.

---

## 📦 Build

Create the application JAR:

```bash
mvn clean package
```

Then run:

```bash
java -jar target/EMS-0.0.1-SNAPSHOT.jar
```

---

## 📸 Screenshots

Add screenshots of your application here.

Example:

```markdown
## 📸 Screenshots

### Employee Dashboard

![Employee Dashboard](screenshots/dashboard.png)

### Add Employee

![Add Employee](screenshots/add-employee.png)

### Employee List

![Employee List](screenshots/employee-list.png)
```

Create a `screenshots` folder in your GitHub repository and place your application screenshots inside it.

---

## 🔮 Future Enhancements

Some possible improvements for the project:

* 🔐 User authentication and authorization
* 👥 Role-based access control
* 🔎 Employee search
* 📄 Pagination
* 🏢 Department management
* ✅ Server-side form validation
* 📊 Employee statistics dashboard
* 🌐 REST API development
* 📚 Swagger/OpenAPI documentation
* 🎨 Bootstrap responsive UI
* 🐳 Docker support
* ☁️ Cloud deployment

---

## 🎯 Learning Outcomes

Through this project, I practiced:

* Developing backend applications using **Java**
* Building applications with **Spring Boot**
* Implementing **Spring MVC**
* Connecting applications with **MySQL**
* Using **Spring Data JPA**
* Working with **JSP and JSTL**
* Managing dependencies using **Maven**
* Applying layered architecture
* Performing CRUD-based database operations

---

## 👨‍💻 Author

**Abhiram**

**B.Tech – Computer Science Engineering**

### Skills Used

`Java` `Spring Boot` `Spring MVC` `JPA` `Hibernate` `MySQL` `JSP` `JSTL` `Maven`

---

## ⭐ Support

If you found this project useful, consider giving the repository a ⭐ on GitHub.

---

## 📄 License

This project is created for **educational and portfolio purposes**.
