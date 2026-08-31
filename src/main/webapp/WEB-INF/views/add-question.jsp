<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Question - ${exam.title}</title>
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
                            <span class="brand-badge mb-1">${exam.title}</span>
                            <h4 class="mb-0 fw-bold"><i class="fa-solid fa-circle-plus text-primary me-2"></i>Add MCQ Question</h4>
                        </div>
                        <span class="badge bg-light text-dark border px-3 py-2">
                            <i class="fa-regular fa-clock me-1 text-primary"></i> ${exam.duration} Mins
                        </span>
                    </div>
                    <div class="card-body-clean">
                        <form action="/admin/addQuestion" method="post">
                            <input type="hidden" name="examId" value="${examId}">

                            <div class="form-floating-custom mb-3">
                                <label><i class="fa-solid fa-question-circle me-1 text-primary"></i> Question Text</label>
                                <textarea name="questionText" class="form-control-custom" rows="3" placeholder="Enter the complete question prompt..." required></textarea>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6 form-floating-custom">
                                    <label><span class="badge bg-secondary me-1">A</span> Option A</label>
                                    <input type="text" name="optionA" class="form-control-custom" placeholder="Option A description" required>
                                </div>
                                <div class="col-md-6 form-floating-custom">
                                    <label><span class="badge bg-secondary me-1">B</span> Option B</label>
                                    <input type="text" name="optionB" class="form-control-custom" placeholder="Option B description" required>
                                </div>
                                <div class="col-md-6 form-floating-custom">
                                    <label><span class="badge bg-secondary me-1">C</span> Option C</label>
                                    <input type="text" name="optionC" class="form-control-custom" placeholder="Option C description" required>
                                </div>
                                <div class="col-md-6 form-floating-custom">
                                    <label><span class="badge bg-secondary me-1">D</span> Option D</label>
                                    <input type="text" name="optionD" class="form-control-custom" placeholder="Option D description" required>
                                </div>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-solid fa-circle-check text-success me-1"></i> Correct Answer</label>
                                    <select name="correctAnswer" class="form-control-custom form-select" required>
                                        <option value="" disabled selected>-- Select Correct Option --</option>
                                        <option value="A">Option A</option>
                                        <option value="B">Option B</option>
                                        <option value="C">Option C</option>
                                        <option value="D">Option D</option>
                                    </select>
                                </div>
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-solid fa-award text-warning me-1"></i> Points / Marks</label>
                                    <input type="number" name="marks" class="form-control-custom" value="1" min="1" max="50" required>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                <a href="/admin/questions/${examId}" class="btn btn-outline-custom">Cancel</a>
                                <button type="submit" class="btn-primary-gradient px-4">
                                    <i class="fa-solid fa-plus"></i> Save Question to Bank
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