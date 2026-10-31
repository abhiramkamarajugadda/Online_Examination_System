<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Examination Result - ${exam.title}</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Custom Modern CSS -->
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="bg-main">

    <!-- NAVBAR -->
    <nav class="custom-navbar no-print">
        <div class="container d-flex justify-content-between align-items-center">
            <a href="/student/dashboard" class="brand-logo">
                <span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span>
                ExamSphere
            </a>
            <div class="d-flex gap-2">
                <button onclick="window.print();" class="btn btn-outline-custom btn-sm">
                    <i class="fa-solid fa-print"></i> Print Certificate
                </button>
                <a href="/student/dashboard" class="btn-primary-gradient py-1 px-3 fs-6">
                    <i class="fa-solid fa-house"></i> Dashboard
                </a>
            </div>
        </div>
    </nav>

    <!-- MAIN RESULT CONTAINER -->
    <main class="container py-4 flex-grow-1">
        <div class="row justify-content-center g-4">
            <div class="col-lg-9">
                <!-- Score Celebration Card -->
                <div class="result-card-celebration mb-4">
                    <span class="brand-badge mb-2">Official Evaluation Report</span>
                    <h2 class="fw-bold text-dark mb-1">${exam.title}</h2>
                    <p class="text-muted small mb-3">Candidate: <strong>${user.fullName}</strong> • Completed on ${result.formattedDate}</p>

                    <!-- Circular Score Dial -->
                    <div class="score-dial-wrapper" style="--percentage: ${result.percentage};">
                        <div class="score-dial-inner">
                            <span class="percentage-text">${result.percentage}%</span>
                            <span class="marks-subtext">${result.score} / ${result.totalMarks} pts</span>
                        </div>
                    </div>

                    <!-- Pass/Fail Status Banner -->
                    <div class="d-inline-block mb-4">
                        <c:choose>
                            <c:when test="${result.percentage >= 40}">
                                <div class="status-banner-pass px-4">
                                    <i class="fa-solid fa-circle-check me-2"></i> Congratulations! You Passed with ${result.grade}
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="status-banner-fail px-4">
                                    <i class="fa-solid fa-triangle-exclamation me-2"></i> Result: Did Not Meet Passing Criteria (${result.grade})
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Performance Breakdown Grid -->
                    <div class="row g-3 text-start">
                        <div class="col-sm-6 col-md-3">
                            <div class="p-3 bg-light rounded-3 border">
                                <small class="text-muted d-block fw-semibold mb-1">SCORE OBTAINED</small>
                                <h4 class="fw-bold text-primary mb-0">${result.score} <small class="fs-6 text-muted">/ ${result.totalMarks}</small></h4>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3">
                            <div class="p-3 bg-success-subtle border border-success-subtle rounded-3">
                                <small class="text-success d-block fw-semibold mb-1">CORRECT ANSWERS</small>
                                <h4 class="fw-bold text-success mb-0">${result.correctCount}</h4>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3">
                            <div class="p-3 bg-danger-subtle border border-danger-subtle rounded-3">
                                <small class="text-danger d-block fw-semibold mb-1">INCORRECT ANSWERS</small>
                                <h4 class="fw-bold text-danger mb-0">${result.incorrectCount}</h4>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3">
                            <div class="p-3 bg-light rounded-3 border">
                                <small class="text-muted d-block fw-semibold mb-1">PASSING THRESHOLD</small>
                                <h4 class="fw-bold text-dark mb-0">40.0%</h4>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Detailed Question-by-Question Review -->
                <c:if test="${not empty reviewList}">
                    <div class="glass-card mb-4">
                        <div class="card-header-clean">
                            <div>
                                <h5 class="mb-0 fw-bold"><i class="fa-solid fa-list-check text-primary me-2"></i>Question-by-Question Evaluation</h5>
                                <small class="text-muted">Review your submitted responses alongside correct answers</small>
                            </div>
                            <span class="badge bg-light text-dark border">${reviewList.size()} Questions Evaluated</span>
                        </div>
                        <div class="card-body-clean">
                            <div class="d-flex flex-column gap-3">
                                <c:forEach items="${reviewList}" var="item">
                                    <div class="review-item ${item.isCorrect ? 'is-correct' : (item.isAttempted ? 'is-wrong' : 'is-skipped')}">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <span class="badge ${item.isCorrect ? 'bg-success' : (item.isAttempted ? 'bg-danger' : 'bg-secondary')} fw-bold">
                                                Question ${item.questionIndex}
                                            </span>
                                            <span class="small fw-bold ${item.isCorrect ? 'text-success' : 'text-danger'}">
                                                ${item.isCorrect ? '+ '.concat(item.question.marks).concat(' Marks (Correct)') : (item.isAttempted ? '0 Marks (Incorrect)' : '0 Marks (Skipped)')}
                                            </span>
                                        </div>

                                        <h6 class="fw-bold text-dark mb-3">${item.question.questionText}</h6>

                                        <div class="row g-2 small">
                                            <div class="col-md-6">
                                                <div class="p-2 rounded-2 border ${item.question.correctAnswer == 'A' ? 'bg-success-subtle border-success fw-bold text-success' : 'bg-light'}">
                                                    A. ${item.question.optionA}
                                                    <c:if test="${item.question.correctAnswer == 'A'}"><i class="fa-solid fa-check text-success ms-1"></i> (Correct)</c:if>
                                                    <c:if test="${item.selectedOption == 'A' && !item.isCorrect}"><i class="fa-solid fa-xmark text-danger ms-1"></i> (Your Choice)</c:if>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="p-2 rounded-2 border ${item.question.correctAnswer == 'B' ? 'bg-success-subtle border-success fw-bold text-success' : 'bg-light'}">
                                                    B. ${item.question.optionB}
                                                    <c:if test="${item.question.correctAnswer == 'B'}"><i class="fa-solid fa-check text-success ms-1"></i> (Correct)</c:if>
                                                    <c:if test="${item.selectedOption == 'B' && !item.isCorrect}"><i class="fa-solid fa-xmark text-danger ms-1"></i> (Your Choice)</c:if>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="p-2 rounded-2 border ${item.question.correctAnswer == 'C' ? 'bg-success-subtle border-success fw-bold text-success' : 'bg-light'}">
                                                    C. ${item.question.optionC}
                                                    <c:if test="${item.question.correctAnswer == 'C'}"><i class="fa-solid fa-check text-success ms-1"></i> (Correct)</c:if>
                                                    <c:if test="${item.selectedOption == 'C' && !item.isCorrect}"><i class="fa-solid fa-xmark text-danger ms-1"></i> (Your Choice)</c:if>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="p-2 rounded-2 border ${item.question.correctAnswer == 'D' ? 'bg-success-subtle border-success fw-bold text-success' : 'bg-light'}">
                                                    D. ${item.question.optionD}
                                                    <c:if test="${item.question.correctAnswer == 'D'}"><i class="fa-solid fa-check text-success ms-1"></i> (Correct)</c:if>
                                                    <c:if test="${item.selectedOption == 'D' && !item.isCorrect}"><i class="fa-solid fa-xmark text-danger ms-1"></i> (Your Choice)</c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Actions -->
                <div class="d-flex justify-content-between align-items-center no-print">
                    <a href="/student/history" class="btn btn-outline-custom">
                        <i class="fa-solid fa-clock-rotate-left me-1"></i> View Exam History
                    </a>
                    <a href="/student/dashboard" class="btn-primary-gradient">
                        <i class="fa-solid fa-house me-1"></i> Back to Student Dashboard
                    </a>
                </div>
            </div>
        </div>
    </main>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>