<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student: ${student.fullName} - ExamSphere Admin</title>
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
            <a href="/admin/students" class="btn btn-outline-custom btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Back to Students
            </a>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="container py-4 flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="glass-card">
                    <div class="card-header-clean">
                        <div>
                            <span class="brand-badge mb-1">Student Account #${student.id}</span>
                            <h4 class="mb-0 fw-bold"><i class="fa-solid fa-user-pen text-primary me-2"></i>Edit Student Profile (8 Fields)</h4>
                        </div>
                        <div class="user-avatar-circle">${student.fullName.substring(0,1)}</div>
                    </div>
                    <div class="card-body-clean">
                        <form action="/admin/student/update" method="post">
                            <input type="hidden" name="id" value="${student.id}">

                            <div class="row g-3">
                                <!-- 1. Full Name -->
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-regular fa-user me-1 text-primary"></i> 1. Full Name</label>
                                    <input type="text" name="fullName" class="form-control-custom" value="${student.fullName}" required>
                                </div>

                                <!-- 2. Email Address -->
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-regular fa-envelope me-1 text-primary"></i> 2. Email Address</label>
                                    <input type="email" name="email" class="form-control-custom" value="${student.email}" required>
                                </div>

                                <!-- 3. Phone Number -->
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-solid fa-phone me-1 text-primary"></i> 3. Phone Number</label>
                                    <input type="tel" name="phoneNumber" class="form-control-custom" value="${student.phoneNumber}">
                                </div>

                                <!-- 4. Gender -->
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-solid fa-venus-mars me-1 text-primary"></i> 4. Gender</label>
                                    <select name="gender" class="form-control-custom form-select">
                                        <option value="" disabled ${empty student.gender ? 'selected' : ''}>-- Select Gender --</option>
                                        <option value="Male" ${student.gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${student.gender == 'Female' ? 'selected' : ''}>Female</option>
                                        <option value="Other" ${student.gender == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>

                                <!-- 5. Date of Birth -->
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-regular fa-calendar me-1 text-primary"></i> 5. Date of Birth</label>
                                    <input type="date" name="dob" class="form-control-custom" value="${student.dob}">
                                </div>

                                <!-- 6. College / Institution -->
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-solid fa-building-columns me-1 text-primary"></i> 6. College / Institution</label>
                                    <input type="text" name="institution" class="form-control-custom" value="${student.institution}">
                                </div>

                                <!-- 7. Username -->
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-solid fa-at me-1 text-primary"></i> 7. Username</label>
                                    <input type="text" name="username" class="form-control-custom" value="${student.username}" required>
                                </div>

                                <!-- 8. Password Reset -->
                                <div class="col-md-6 form-floating-custom">
                                    <label><i class="fa-solid fa-lock me-1 text-primary"></i> 8. Reset Password</label>
                                    <div class="input-group">
                                        <input type="password" name="password" class="form-control-custom" placeholder="Leave blank to keep current">
                                        <button type="button" class="btn btn-outline-secondary toggle-password-btn" style="border: 1.5px solid var(--border-color); border-left: 0; border-radius: 0 var(--radius-md) var(--radius-md) 0;">
                                            <i class="fa-solid fa-eye text-muted"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between align-items-center pt-3 border-top mt-4">
                                <a href="/admin/students" class="btn btn-outline-custom">Cancel</a>
                                <button type="submit" class="btn-primary-gradient px-4">
                                    <i class="fa-solid fa-check"></i> Save Student Details
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