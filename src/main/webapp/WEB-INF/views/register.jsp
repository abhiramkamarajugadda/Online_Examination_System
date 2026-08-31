<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Registration (8 Fields) - ExamSphere</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Custom Modern CSS -->
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="bg-main">

    <!-- NAVBAR -->
    <nav class="custom-navbar">
        <div class="container d-flex justify-content-between align-items-center">
            <a href="/" class="brand-logo">
                <span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span>
                ExamSphere
            </a>
            <a href="/login" class="btn btn-outline-custom btn-sm">
                <i class="fa-solid fa-arrow-right-to-bracket"></i> Sign In
            </a>
        </div>
    </nav>

    <!-- REGISTER CONTAINER -->
    <div class="auth-page-container flex-grow-1">
        <div class="auth-box" style="max-width: 650px;">
            <!-- Header -->
            <div class="text-center mb-4">
                <span class="brand-badge mb-2"><i class="fa-solid fa-id-card me-1"></i> Student Registration</span>
                <h3 class="fw-bold mb-1">Create Candidate Account 🚀</h3>
                <p class="text-muted small">Fill in the 8 required candidate details to register for examinations.</p>
            </div>

            <!-- Flash Error Message -->
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger d-flex align-items-center gap-2 py-2 px-3 mb-3 border-0 rounded-3 shadow-sm" role="alert">
                    <i class="fa-solid fa-circle-exclamation fs-5"></i>
                    <div class="small fw-semibold">${errorMsg}</div>
                </div>
            </c:if>

            <!-- Registration Form (8 Fields) -->
            <form action="/register" method="post">
                <div class="row g-3">
                    <!-- Field 1: Full Name -->
                    <div class="col-md-6 form-floating-custom">
                        <label><i class="fa-regular fa-user me-1 text-primary"></i> 1. Full Name</label>
                        <input type="text" name="fullName" class="form-control-custom" placeholder="e.g. John Doe" required>
                    </div>

                    <!-- Field 2: Email Address -->
                    <div class="col-md-6 form-floating-custom">
                        <label><i class="fa-regular fa-envelope me-1 text-primary"></i> 2. Email Address</label>
                        <input type="email" name="email" class="form-control-custom" placeholder="john.doe@example.com" required>
                    </div>

                    <!-- Field 3: Phone Number -->
                    <div class="col-md-6 form-floating-custom">
                        <label><i class="fa-solid fa-phone me-1 text-primary"></i> 3. Phone Number</label>
                        <input type="tel" name="phoneNumber" class="form-control-custom" placeholder="e.g. 9876543210" required>
                    </div>

                    <!-- Field 4: Gender -->
                    <div class="col-md-6 form-floating-custom">
                        <label><i class="fa-solid fa-venus-mars me-1 text-primary"></i> 4. Gender</label>
                        <select name="gender" class="form-control-custom form-select" required>
                            <option value="" disabled selected>-- Select Gender --</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <!-- Field 5: Date of Birth -->
                    <div class="col-md-6 form-floating-custom">
                        <label><i class="fa-regular fa-calendar me-1 text-primary"></i> 5. Date of Birth</label>
                        <input type="date" name="dob" class="form-control-custom" required>
                    </div>

                    <!-- Field 6: College / Institution -->
                    <div class="col-md-6 form-floating-custom">
                        <label><i class="fa-solid fa-building-columns me-1 text-primary"></i> 6. College / Institution</label>
                        <input type="text" name="institution" class="form-control-custom" placeholder="e.g. MIT / IIT / Tech Institute" required>
                    </div>

                    <!-- Field 7: Username -->
                    <div class="col-md-6 form-floating-custom">
                        <label><i class="fa-solid fa-at me-1 text-primary"></i> 7. Username / Roll No</label>
                        <input type="text" name="username" class="form-control-custom" placeholder="e.g. johndoe26" required>
                    </div>

                    <!-- Field 8: Password -->
                    <div class="col-md-6 form-floating-custom">
                        <label><i class="fa-solid fa-lock me-1 text-primary"></i> 8. Password</label>
                        <div class="input-group">
                            <input type="password" name="password" class="form-control-custom" placeholder="Min. 6 characters" required minlength="6">
                            <button type="button" class="btn btn-outline-secondary toggle-password-btn" style="border: 1.5px solid var(--border-color); border-left: 0; border-radius: 0 var(--radius-md) var(--radius-md) 0;">
                                <i class="fa-solid fa-eye text-muted"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="form-check my-3">
                    <input class="form-check-input" type="checkbox" id="termsCheck" required checked>
                    <label class="form-check-label small text-muted" for="termsCheck">
                        I confirm that the 8 details provided above are accurate and agree to the Honor Code.
                    </label>
                </div>

                <div class="d-grid mt-4">
                    <button type="submit" class="btn-primary-gradient py-2 fs-6">
                        Complete Registration (8 Fields) <i class="fa-solid fa-user-check ms-1"></i>
                    </button>
                </div>
            </form>

            <!-- Footer / Login Link -->
            <div class="text-center mt-4 pt-3 border-top">
                <p class="text-muted small mb-0">
                    Already registered? 
                    <a href="/login" class="fw-bold text-primary">Sign In here</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>