<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Test Results - ExamSphere Admin</title>
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
                    <a href="/admin/dashboard" class="nav-link-custom"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
                    <a href="/admin/findAllExams" class="nav-link-custom"><i class="fa-solid fa-book-open"></i> Manage Exams</a>
                    <a href="/admin/results" class="nav-link-custom active"><i class="fa-solid fa-chart-simple"></i> Test Results</a>
                    <a href="/admin/students" class="nav-link-custom"><i class="fa-solid fa-users"></i> Students</a>
                </div>
            </div>
            <a href="/admin/dashboard" class="btn btn-outline-custom btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Dashboard
            </a>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="container py-4 flex-grow-1">
        <!-- Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
            <div>
                <h2 class="fw-bold text-dark mb-1">Student Examination Results 📈</h2>
                <p class="text-muted mb-0">Complete historical logs of all examinations attempted by students.</p>
            </div>
        </div>

        <!-- Filter Bar -->
        <div class="glass-card p-3 mb-4">
            <div class="row align-items-center g-3">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" id="tableSearchInput" class="form-control border-start-0" placeholder="Search by student name, email, or exam title...">
                    </div>
                </div>
                <div class="col-md-6 text-md-end text-muted small">
                    Total Submissions: <strong>${resultList.size()}</strong>
                </div>
            </div>
        </div>

        <!-- Results Table -->
        <div class="glass-card">
            <div class="card-body-clean p-0">
                <c:choose>
                    <c:when test="${empty resultList}">
                        <div class="text-center py-5">
                            <div class="fs-1 text-muted mb-2">📊</div>
                            <h5 class="fw-bold text-dark">No Test Submissions Yet</h5>
                            <p class="text-muted small mb-0">When students complete tests, their results will appear here in real-time.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table-custom searchable-table">
                                <thead>
                                    <tr>
                                        <th>Student Details</th>
                                        <th>Exam Title</th>
                                        <th>Score / Total</th>
                                        <th>Percentage</th>
                                        <th>Performance Grade</th>
                                        <th>Status</th>
                                        <th>Submitted On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${resultList}" var="res">
                                        <tr>
                                            <td>
                                                <div class="fw-bold text-dark">${res.student.fullName}</div>
                                                <small class="text-muted">${res.student.email}</small>
                                            </td>
                                            <td>
                                                <span class="fw-semibold text-dark">${res.exam.title}</span>
                                            </td>
                                            <td>
                                                <span class="fw-bold text-primary">${res.score}</span> / ${res.totalMarks}
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="progress flex-grow-1" style="height: 6px; width: 60px;">
                                                        <div class="progress-bar ${res.percentage >= 40 ? 'bg-success' : 'bg-danger'}" style="width: ${res.percentage}%;"></div>
                                                    </div>
                                                    <span class="small fw-bold">${res.percentage}%</span>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge bg-light text-dark border px-2 py-1">${res.grade}</span>
                                            </td>
                                            <td>
                                                <span class="badge ${res.percentage >= 40 ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'} fw-bold px-2 py-1">
                                                    ${res.passStatus}
                                                </span>
                                            </td>
                                            <td>
                                                <small class="text-muted">${res.formattedDate}</small>
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
    </main>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>