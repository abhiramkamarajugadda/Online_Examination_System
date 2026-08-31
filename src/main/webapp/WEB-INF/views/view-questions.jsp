<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Question Bank: ${exam.title} - ExamSphere</title>
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
                </div>
            </div>
            <a href="/admin/findAllExams" class="btn btn-outline-custom btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Back to Exams
            </a>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="container py-4 flex-grow-1">
        <!-- Exam Meta Banner -->
        <div class="glass-card p-4 mb-4" style="background: radial-gradient(circle at 90% 10%, rgba(79, 70, 229, 0.08), transparent 60%), #ffffff;">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div>
                    <span class="brand-badge mb-2">Question Bank Repository</span>
                    <h3 class="fw-bold text-dark mb-1">${exam.title}</h3>
                    <p class="text-muted small mb-0">${not empty exam.description ? exam.description : 'Standard assessment module.'}</p>
                </div>
                <div class="d-flex flex-wrap align-items-center gap-2">
                    <span class="badge bg-light text-dark border px-3 py-2">
                        <i class="fa-regular fa-clock text-primary me-1"></i> ${exam.duration} Mins
                    </span>
                    <span class="badge bg-light text-dark border px-3 py-2">
                        <i class="fa-solid fa-bullseye text-success me-1"></i> ${exam.totalMarks} Marks
                    </span>
                    <span class="badge bg-primary-subtle text-primary fw-bold px-3 py-2">
                        <i class="fa-solid fa-layer-group me-1"></i> ${questionList.size()} Questions
                    </span>
                    <a href="/admin/question/add?examId=${exam.id}" class="btn-primary-gradient py-2 px-3">
                        <i class="fa-solid fa-plus"></i> Add New Question
                    </a>
                </div>
            </div>
        </div>

        <!-- Filter bar -->
        <div class="glass-card p-3 mb-4">
            <div class="row align-items-center g-3">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" id="tableSearchInput" class="form-control border-start-0" placeholder="Search questions by text or options...">
                    </div>
                </div>
                <div class="col-md-6 text-md-end text-muted small">
                    Showing <strong>${questionList.size()}</strong> questions in this exam module.
                </div>
            </div>
        </div>

        <!-- Questions List -->
        <c:choose>
            <c:when test="${empty questionList}">
                <div class="glass-card text-center py-5">
                    <div class="fs-1 text-muted mb-2">❓</div>
                    <h5 class="fw-bold text-dark">No Questions Added Yet</h5>
                    <p class="text-muted small mb-3">Add questions to this examination to make it active for students.</p>
                    <a href="/admin/question/add?examId=${exam.id}" class="btn-primary-gradient">
                        <i class="fa-solid fa-plus"></i> Add First Question
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="d-flex flex-column gap-3 searchable-table">
                    <c:forEach items="${questionList}" var="q" varStatus="loop">
                        <div class="glass-card p-4">
                            <div class="d-flex justify-content-between align-items-start mb-3 gap-2">
                                <div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-primary text-white fw-bold px-2 py-1">Q${loop.count}</span>
                                    <span class="badge bg-light text-muted border">${q.marks} Mark(s)</span>
                                </div>
                                <div class="d-flex gap-2">
                                    <a href="/admin/question/edit/${q.id}" class="btn btn-sm btn-outline-secondary py-1 px-2" title="Edit Question">
                                        <i class="fa-solid fa-pen"></i> Edit
                                    </a>
                                    <a href="/admin/question/delete/${q.id}?examId=${exam.id}" class="btn btn-sm btn-outline-danger py-1 px-2" onclick="return confirm('Delete this question?');" title="Delete Question">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </a>
                                </div>
                            </div>

                            <h5 class="fw-bold text-dark mb-3">${q.questionText}</h5>

                            <div class="row g-2">
                                <div class="col-md-6">
                                    <div class="p-2 border rounded-3 d-flex align-items-center gap-2 ${q.correctAnswer == 'A' || q.correctAnswer == 'a' ? 'bg-success-subtle border-success' : 'bg-light'}">
                                        <span class="badge ${q.correctAnswer == 'A' || q.correctAnswer == 'a' ? 'bg-success' : 'bg-secondary'}">A</span>
                                        <span class="small fw-semibold text-dark">${q.optionA}</span>
                                        <c:if test="${q.correctAnswer == 'A' || q.correctAnswer == 'a'}">
                                            <i class="fa-solid fa-circle-check text-success ms-auto"></i>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-2 border rounded-3 d-flex align-items-center gap-2 ${q.correctAnswer == 'B' || q.correctAnswer == 'b' ? 'bg-success-subtle border-success' : 'bg-light'}">
                                        <span class="badge ${q.correctAnswer == 'B' || q.correctAnswer == 'b' ? 'bg-success' : 'bg-secondary'}">B</span>
                                        <span class="small fw-semibold text-dark">${q.optionB}</span>
                                        <c:if test="${q.correctAnswer == 'B' || q.correctAnswer == 'b'}">
                                            <i class="fa-solid fa-circle-check text-success ms-auto"></i>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-2 border rounded-3 d-flex align-items-center gap-2 ${q.correctAnswer == 'C' || q.correctAnswer == 'c' ? 'bg-success-subtle border-success' : 'bg-light'}">
                                        <span class="badge ${q.correctAnswer == 'C' || q.correctAnswer == 'c' ? 'bg-success' : 'bg-secondary'}">C</span>
                                        <span class="small fw-semibold text-dark">${q.optionC}</span>
                                        <c:if test="${q.correctAnswer == 'C' || q.correctAnswer == 'c'}">
                                            <i class="fa-solid fa-circle-check text-success ms-auto"></i>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-2 border rounded-3 d-flex align-items-center gap-2 ${q.correctAnswer == 'D' || q.correctAnswer == 'd' ? 'bg-success-subtle border-success' : 'bg-light'}">
                                        <span class="badge ${q.correctAnswer == 'D' || q.correctAnswer == 'd' ? 'bg-success' : 'bg-secondary'}">D</span>
                                        <span class="small fw-semibold text-dark">${q.optionD}</span>
                                        <c:if test="${q.correctAnswer == 'D' || q.correctAnswer == 'd'}">
                                            <i class="fa-solid fa-circle-check text-success ms-auto"></i>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>