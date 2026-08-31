<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit Examination' : 'Create Examination'} - ExamSphere Admin</title>
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
                    <a href="/admin/exam/create" class="nav-link-custom active"><i class="fa-solid fa-plus-circle"></i> Create Exam</a>
                </div>
            </div>
            <a href="/admin/findAllExams" class="btn btn-outline-custom btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Back to Exams
            </a>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="container py-4 flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="glass-card">
                    <div class="card-header-clean">
                        <div>
                            <span class="brand-badge mb-1">${isEdit ? 'Update Mode' : 'Configuration'}</span>
                            <h4 class="mb-0 fw-bold">
                                <i class="fa-solid ${isEdit ? 'fa-pen-to-square' : 'fa-file-circle-plus'} text-primary me-2"></i>
                                ${isEdit ? 'Edit Examination' : 'Create New Examination'}
                            </h4>
                        </div>
                        <span class="text-muted small"><i class="fa-solid fa-shield-check text-success"></i> Auto-validated</span>
                    </div>
                    <div class="card-body-clean">
                        <form action="${isEdit ? '/admin/exam/update' : '/admin/createExam'}" method="post">
                            <c:if test="${isEdit}">
                                <input type="hidden" name="id" value="${exam.id}">
                            </c:if>

                            <div class="form-floating-custom mb-3">
                                <label><i class="fa-solid fa-heading me-1 text-primary"></i> Examination Title</label>
                                <input type="text" name="title" id="examTitleInput" class="form-control-custom" placeholder="e.g. Java Spring Boot Developer Certification" value="${exam.title}" required>
                            </div>

                            <div class="form-floating-custom mb-3">
                                <label><i class="fa-solid fa-align-left me-1 text-primary"></i> Description & Instructions</label>
                                <textarea name="description" id="examDescInput" class="form-control-custom" rows="3" placeholder="Provide test guidelines, rules, or syllabus scope...">${exam.description}</textarea>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-md-4 form-floating-custom">
                                    <label><i class="fa-regular fa-clock me-1 text-primary"></i> Duration (Minutes)</label>
                                    <div class="input-group">
                                        <input type="number" name="duration" class="form-control-custom" placeholder="30" min="1" max="300" value="${not empty exam.duration ? exam.duration : 30}" required>
                                        <span class="input-group-text bg-light">Mins</span>
                                    </div>
                                    <small class="text-muted">CBT timer limit.</small>
                                </div>
                                <div class="col-md-4 form-floating-custom">
                                    <label><i class="fa-solid fa-bullseye me-1 text-primary"></i> Total Marks</label>
                                    <div class="input-group">
                                        <input type="number" name="totalMarks" class="form-control-custom" placeholder="100" min="1" max="1000" value="${not empty exam.totalMarks ? exam.totalMarks : 100}" required>
                                        <span class="input-group-text bg-light">Points</span>
                                    </div>
                                    <small class="text-muted">Max total points.</small>
                                </div>
                                <div class="col-md-4 form-floating-custom">
                                    <label><i class="fa-solid fa-repeat me-1 text-primary"></i> Max Attempts</label>
                                    <div class="input-group">
                                        <input type="number" name="maxAttempts" class="form-control-custom" placeholder="1" min="1" max="50" value="${not empty exam.maxAttempts ? exam.maxAttempts : 1}" required>
                                        <span class="input-group-text bg-light">Limit</span>
                                    </div>
                                    <small class="text-muted">Allowed per student.</small>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                <a href="/admin/findAllExams" class="btn btn-outline-custom">Cancel</a>
                                <button type="submit" class="btn-primary-gradient px-4">
                                    <i class="fa-solid fa-check"></i> ${isEdit ? 'Save Changes' : 'Publish Examination'}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>