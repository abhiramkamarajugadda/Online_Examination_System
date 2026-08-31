<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Examinations - ExamSphere Admin</title>
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
                    <a href="/admin/findAllExams" class="nav-link-custom active"><i class="fa-solid fa-book-open"></i> Manage Exams</a>
                    <a href="/admin/exam/create" class="nav-link-custom"><i class="fa-solid fa-plus-circle"></i> Create Exam</a>
                    <a href="/admin/results" class="nav-link-custom"><i class="fa-solid fa-chart-simple"></i> Test Results</a>
                    <a href="/admin/students" class="nav-link-custom"><i class="fa-solid fa-users"></i> Students</a>
                </div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <a href="/logout" class="btn btn-outline-custom btn-sm text-danger border-danger-subtle">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="container py-4 flex-grow-1">
        <!-- Header & Search -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
            <div>
                <h2 class="fw-bold text-dark mb-1">Manage Examinations 📚</h2>
                <p class="text-muted mb-0">Configure test details, allowed attempts, question banks, and parameters.</p>
            </div>
            <div class="d-flex gap-2">
                <a href="/admin/exam/create" class="btn-primary-gradient">
                    <i class="fa-solid fa-plus"></i> Create New Exam
                </a>
            </div>
        </div>

        <!-- Filter Bar -->
        <div class="glass-card p-3 mb-4">
            <div class="row align-items-center g-3">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" id="tableSearchInput" class="form-control border-start-0" placeholder="Search exams by title or description...">
                    </div>
                </div>
                <div class="col-md-6 text-md-end text-muted small">
                    Showing <strong>${examList.size()}</strong> active examination modules.
                </div>
            </div>
        </div>

        <!-- Exams Table -->
        <div class="glass-card">
            <div class="card-body-clean p-0">
                <c:choose>
                    <c:when test="${empty examList}">
                        <div class="text-center py-5">
                            <div class="fs-1 text-muted mb-2">📋</div>
                            <h5 class="fw-bold text-dark">No Examinations Found</h5>
                            <p class="text-muted small mb-3">Create your first examination module to get started.</p>
                            <a href="/admin/exam/create" class="btn-primary-gradient">
                                <i class="fa-solid fa-plus"></i> Create New Exam
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table-custom searchable-table">
                                <thead>
                                    <tr>
                                        <th style="width: 70px;">#ID</th>
                                        <th>Exam Title & Details</th>
                                        <th>Duration</th>
                                        <th>Total Marks</th>
                                        <th>Attempts Allowed</th>
                                        <th>Questions</th>
                                        <th class="text-end">Management Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${examList}" var="exam">
                                        <tr>
                                            <td><span class="badge bg-light text-muted border">#${exam.id}</span></td>
                                            <td>
                                                <div class="fw-bold text-dark fs-6">${exam.title}</div>
                                                <small class="text-muted d-block text-truncate" style="max-width: 350px;">
                                                    ${not empty exam.description ? exam.description : 'Standard online assessment.'}
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
                                                <span class="badge bg-info-subtle text-info-emphasis border px-2 py-1">
                                                    <i class="fa-solid fa-repeat me-1"></i> Max ${exam.maxAttempts != null ? exam.maxAttempts : 1}
                                                </span>
                                            </td>
                                            <td>
                                                <a href="/admin/questions/${exam.id}" class="badge bg-primary-subtle text-primary text-decoration-none fw-bold px-2 py-1">
                                                    <i class="fa-solid fa-list-ol me-1"></i> ${questionCounts[exam.id]} Questions →
                                                </a>
                                            </td>
                                            <td class="text-end">
                                                <div class="d-inline-flex gap-2">
                                                    <a href="/admin/questions/${exam.id}" class="btn btn-sm btn-primary-gradient py-1 px-2" title="Manage Questions">
                                                        <i class="fa-solid fa-layer-group"></i> Question Bank
                                                    </a>
                                                    <a href="/admin/question/add?examId=${exam.id}" class="btn btn-sm btn-outline-success py-1 px-2" title="Add Question">
                                                        <i class="fa-solid fa-plus"></i> Add
                                                    </a>
                                                    <a href="/admin/exam/edit/${exam.id}" class="btn btn-sm btn-outline-secondary py-1 px-2" title="Edit Exam">
                                                        <i class="fa-solid fa-pen"></i> Edit
                                                    </a>
                                                    <a href="/admin/deleteExam/${exam.id}" class="btn btn-sm btn-outline-danger py-1 px-2" onclick="return confirm('Are you sure you want to delete this exam? All associated questions will also be deleted.');" title="Delete Exam">
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
    </main>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>