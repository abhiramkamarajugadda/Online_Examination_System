<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Question - ExamSphere</title>
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
            </div>
            <a href="/admin/questions/${examId}" class="btn btn-outline-custom btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Back to Question Bank
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
                            <span class="brand-badge mb-1">Editing Question #${question.id}</span>
                            <h4 class="mb-0 fw-bold"><i class="fa-solid fa-pen-to-square text-primary me-2"></i>Update MCQ Question</h4>
                        </div>
                    </div>
                    <div class="card-body-clean">
                        <form action="/admin/question/update" method="post">
                            <input type="hidden" name="id" value="${question.id}">

                            <div class="form-floating-custom mb-3">
                                <label><i class="fa-solid fa-question-circle me-1 text-primary"></i> Question Text</label>
                                <textarea name="questionText" class="form-control-custom" rows="3" required>${question.questionText}</textarea>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6 form-floating-custom">
                                    <label><span class="badge bg-secondary me-1">A</span> Option A</label>
                                    <input type="text" name="optionA" class="form-control-custom" value="${question.optionA}" required>
                                </div>
                                <div class="col-md-6 form-floating-custom">
                                    <label><span class="badge bg-secondary me-1">B</span> Option B</label>
                                    <input type="text" name="optionB" class="form-control-custom" value="${question.optionB}" required>
                                </div>
                                <div class="col-md-6 form-floating-custom">
                                    <label><span class="badge bg-secondary me-1">C</span> Option C</label>
                                    <input type="text" name="optionC" class="form-control-custom" value="${question.optionC}" required>
                                </div>
                                <div class="col-md-6 form-floating-custom">
                                    <label><span class="badge bg-secondary me-1">D</span> Option D</label>
                                    <input type="text" name="optionD" class="form-control-custom" value="${question.optionD}" required>
                                </div>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-solid fa-circle-check text-success me-1"></i> Correct Answer</label>
                                    <select name="correctAnswer" class="form-control-custom form-select" required>
                                        <option value="A" ${question.correctAnswer == 'A' || question.correctAnswer == 'a' ? 'selected' : ''}>Option A</option>
                                        <option value="B" ${question.correctAnswer == 'B' || question.correctAnswer == 'b' ? 'selected' : ''}>Option B</option>
                                        <option value="C" ${question.correctAnswer == 'C' || question.correctAnswer == 'c' ? 'selected' : ''}>Option C</option>
                                        <option value="D" ${question.correctAnswer == 'D' || question.correctAnswer == 'd' ? 'selected' : ''}>Option D</option>
                                    </select>
                                </div>
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-solid fa-award text-warning me-1"></i> Points / Marks</label>
                                    <input type="number" name="marks" class="form-control-custom" value="${question.marks}" min="1" max="50" required>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                <a href="/admin/questions/${examId}" class="btn btn-outline-custom">Cancel</a>
                                <button type="submit" class="btn-primary-gradient px-4">
                                    <i class="fa-solid fa-check"></i> Save Changes
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