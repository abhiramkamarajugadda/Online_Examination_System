<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ExamSphere</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Custom Modern CSS -->
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="bg-main">

    <!-- ADMIN NAVBAR -->
    <nav class="custom-navbar">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-3">
                <a href="/admin/dashboard" class="brand-logo">
                    <span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span>
                    ExamSphere
                    <span class="badge bg-danger ms-2" style="font-size: 0.7rem;">ADMIN</span>
                </a>
                <div class="d-none d-md-flex align-items-center gap-1 ms-3">
                    <a href="/admin/dashboard" class="nav-link-custom active"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
                    <a href="/admin/findAllExams" class="nav-link-custom"><i class="fa-solid fa-book-open"></i> Manage Exams</a>
                    <a href="/admin/exam/create" class="nav-link-custom"><i class="fa-solid fa-plus-circle"></i> Create Exam</a>
                    <a href="/admin/results" class="nav-link-custom"><i class="fa-solid fa-chart-simple"></i> Test Results</a>
                    <a href="/admin/students" class="nav-link-custom"><i class="fa-solid fa-users"></i> Students</a>
                </div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="user-profile-badge d-none d-sm-flex">
                    <div class="user-avatar-circle bg-danger"><i class="fa-solid fa-user-tie"></i></div>
                    <div>
                        <div class="fw-bold text-dark small" style="line-height: 1.1;">Admin Console</div>
                        <small class="text-muted" style="font-size: 0.72rem;">admin@examsphere.com</small>
                    </div>
                </div>
                <a href="/logout" class="btn btn-outline-custom btn-sm text-danger border-danger-subtle">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="container py-4 flex-grow-1">
        <!-- Greeting Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
            <div>
                <h2 class="fw-bold text-dark mb-1">Executive Dashboard 📊</h2>
                <p class="text-muted mb-0">Overview of examinations, student participation, and question bank.</p>
            </div>
            <div class="d-flex gap-2">
                <a href="/admin/exam/create" class="btn-primary-gradient">
                    <i class="fa-solid fa-plus"></i> Create New Exam
                </a>
                <a href="/admin/findAllExams" class="btn btn-outline-custom">
                    <i class="fa-solid fa-list-check"></i> Manage All
                </a>
            </div>
        </div>

        <!-- 4 KPI Metrics -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon-circle stat-icon-indigo">
                        <i class="fa-solid fa-book-bookmark"></i>
                    </div>
                    <div>
                        <div class="stat-title">Total Exams</div>
                        <div class="stat-value">${totalExams}</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon-circle stat-icon-sky">
                        <i class="fa-solid fa-circle-question"></i>
                    </div>
                    <div>
                        <div class="stat-title">Questions in Bank</div>
                        <div class="stat-value">${totalQuestions}</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon-circle stat-icon-emerald">
                        <i class="fa-solid fa-users-line"></i>
                    </div>
                    <div>
                        <div class="stat-title">Registered Students</div>
                        <div class="stat-value">${totalStudents}</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon-circle stat-icon-amber">
                        <i class="fa-solid fa-award"></i>
                    </div>
                    <div>
                        <div class="stat-title">Test Submissions</div>
                        <div class="stat-value">${totalAttempts}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Exams Grid / Overview -->
        <div class="glass-card mb-4">
            <div class="card-header-clean">
                <div>
                    <h5 class="mb-0 fw-bold"><i class="fa-solid fa-folder-open text-primary me-2"></i>Active Examinations</h5>
                    <small class="text-muted">Currently active exams available for students</small>
                </div>
                <a href="/admin/findAllExams" class="btn btn-outline-custom btn-sm">View All Exams →</a>
            </div>
            <div class="card-body-clean p-0">
                <c:choose>
                    <c:when test="${empty examList}">
                        <div class="text-center py-5">
                            <div class="fs-1 text-muted mb-2">📋</div>
                            <h5 class="fw-bold text-dark">No Examinations Created Yet</h5>
                            <p class="text-muted small mb-3">Get started by creating your first online examination.</p>
                            <a href="/admin/exam/create" class="btn-primary-gradient">
                                <i class="fa-solid fa-plus"></i> Create First Exam
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table-custom">
                                <thead>
                                    <tr>
                                        <th>Exam Title & Details</th>
                                        <th>Duration</th>
                                        <th>Total Marks</th>
                                        <th>Questions</th>
                                        <th class="text-end">Quick Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${examList}" var="exam">
                                        <tr>
                                            <td>
                                                <div class="fw-bold text-dark fs-6">${exam.title}</div>
                                                <small class="text-muted d-block text-truncate" style="max-width: 320px;">
                                                    ${not empty exam.description ? exam.description : 'Standard test assessment.'}
                                                </small>
                                            </td>
                                            <td>
                                                <span class="badge bg-light text-dark border px-2 py-1">
                                                    <i class="fa-regular fa-clock me-1 text-primary"></i> ${exam.duration} Mins
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge bg-light text-dark border px-2 py-1">
                                                    <i class="fa-solid fa-bullseye me-1 text-success"></i> ${exam.totalMarks} Marks
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge bg-primary-subtle text-primary fw-bold px-2 py-1">
                                                    <i class="fa-solid fa-list-ol me-1"></i> ${questionCounts[exam.id]} Questions
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <div class="d-inline-flex gap-1">
                                                    <a href="/admin/questions/${exam.id}" class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Manage Questions">
                                                        <i class="fa-solid fa-layer-group"></i> Manage Questions
                                                    </a>
                                                    <a href="/admin/question/add?examId=${exam.id}" class="btn btn-sm btn-outline-success" data-bs-toggle="tooltip" title="Add Question">
                                                        <i class="fa-solid fa-plus"></i> Add
                                                    </a>
                                                    <a href="/admin/exam/edit/${exam.id}" class="btn btn-sm btn-outline-secondary" data-bs-toggle="tooltip" title="Edit Exam">
                                                        <i class="fa-solid fa-pen"></i>
                                                    </a>
                                                    <a href="/admin/deleteExam/${exam.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this exam and all its questions?');" data-bs-toggle="tooltip" title="Delete Exam">
                                                        <i class="fa-solid fa-trash-can"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Recent Submissions -->
        <c:if test="${not empty recentResults}">
            <div class="glass-card">
                <div class="card-header-clean">
                    <div>
                        <h5 class="mb-0 fw-bold"><i class="fa-solid fa-bolt-lightning text-warning me-2"></i>Recent Student Submissions</h5>
                        <small class="text-muted">Live activity stream of submitted tests</small>
                    </div>
                    <a href="/admin/results" class="btn btn-outline-custom btn-sm">All Submissions →</a>
                </div>
                <div class="card-body-clean p-0">
                    <div class="table-responsive">
                        <table class="table-custom">
                            <thead>
                                <tr>
                                    <th>Student</th>
                                    <th>Exam</th>
                                    <th>Score</th>
                                    <th>Percentage</th>
                                    <th>Status</th>
                                    <th>Attempted Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentResults}" var="res">
                                    <tr>
                                        <td>
                                            <div class="fw-bold text-dark">${res.student.fullName}</div>
                                            <small class="text-muted">${res.student.email}</small>
                                        </td>
                                        <td><span class="fw-semibold">${res.exam.title}</span></td>
                                        <td><span class="fw-bold text-primary">${res.score}</span> / ${res.totalMarks}</td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="progress flex-grow-1" style="height: 6px; width: 60px;">
                                                    <div class="progress-bar ${res.percentage >= 40 ? 'bg-success' : 'bg-danger'}" style="width: ${res.percentage}%;"></div>
                                                </div>
                                                <span class="small fw-bold">${res.percentage}%</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge ${res.percentage >= 40 ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'} fw-bold px-2 py-1">
                                                ${res.passStatus}
                                            </span>
                                        </td>
                                        <td><small class="text-muted">${res.formattedDate}</small></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>
    </main>

    <!-- FOOTER -->
    <footer class="bg-white border-top py-3 mt-auto">
        <div class="container d-flex justify-content-between align-items-center text-muted small">
            <div>ExamSphere Admin Console © 2026</div>
            <div>Spring Boot + JSP MVC Architecture</div>
        </div>
    </footer>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>