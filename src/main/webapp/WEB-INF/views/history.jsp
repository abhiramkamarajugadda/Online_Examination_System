<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam History - ExamSphere</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Custom Modern CSS -->
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="bg-main">

    <!-- STUDENT NAVBAR -->
    <nav class="custom-navbar">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-3">
                <a href="/student/dashboard" class="brand-logo">
                    <span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span>
                    ExamSphere
                </a>
                <div class="d-none d-md-flex align-items-center gap-1 ms-3">
                    <a href="/student/dashboard" class="nav-link-custom"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
                    <a href="/student/history" class="nav-link-custom active"><i class="fa-solid fa-clock-rotate-left"></i> Exam History</a>
                    <a href="/student/profile" class="nav-link-custom"><i class="fa-regular fa-id-badge"></i> My Profile</a>
                </div>
            </div>
            <a href="/student/dashboard" class="btn btn-outline-custom btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Dashboard
            </a>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="container py-4 flex-grow-1">
        <!-- Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
            <div>
                <h2 class="fw-bold text-dark mb-1">My Examination History 📜</h2>
                <p class="text-muted mb-0">Record of all examinations taken and evaluated on ExamSphere.</p>
            </div>
            <a href="/student/dashboard" class="btn-primary-gradient">
                <i class="fa-solid fa-play me-1"></i> Take Another Test
            </a>
        </div>

        <!-- Filter Bar -->
        <div class="glass-card p-3 mb-4">
            <div class="row align-items-center g-3">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" id="tableSearchInput" class="form-control border-start-0" placeholder="Search tests by title or status...">
                    </div>
                </div>
                <div class="col-md-6 text-md-end text-muted small">
                    Total Examinations Attempted: <strong>${resultList.size()}</strong>
                </div>
            </div>
        </div>

        <!-- History Table -->
        <div class="glass-card">
            <div class="card-body-clean p-0">
                <c:choose>
                    <c:when test="${empty resultList}">
                        <div class="text-center py-5">
                            <div class="fs-1 text-muted mb-2">📜</div>
                            <h5 class="fw-bold text-dark">No Examination History Found</h5>
                            <p class="text-muted small mb-3">You have not completed any online examinations yet.</p>
                            <a href="/student/dashboard" class="btn-primary-gradient">
                                <i class="fa-solid fa-play"></i> Start Your First Test
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table-custom searchable-table">
                                <thead>
                                    <tr>
                                        <th>Examination Module</th>
                                        <th>Score / Max</th>
                                        <th>Percentage</th>
                                        <th>Grade</th>
                                        <th>Status</th>
                                        <th>Attempt Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${resultList}" var="res">
                                        <tr>
                                            <td>
                                                <div class="fw-bold text-dark fs-6">${res.exam.title}</div>
                                                <small class="text-muted">${not empty res.exam.description ? res.exam.description : 'Standard online assessment.'}</small>
                                            </td>
                                            <td>
                                                <strong class="text-primary fs-6">${res.score}</strong> / ${res.totalMarks}
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="progress flex-grow-1" style="height: 7px; width: 70px;">
                                                        <div class="progress-bar ${res.percentage >= 40 ? 'bg-success' : 'bg-danger'}" style="width: ${res.percentage}%;"></div>
                                                    </div>
                                                    <span class="small fw-bold">${res.percentage}%</span>
                                                </div>
                                            </td>
                                            <td><span class="badge bg-light text-dark border px-2 py-1">${res.grade}</span></td>
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