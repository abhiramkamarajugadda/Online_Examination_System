<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - ExamSphere</title>
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
            <a href="/" class="btn btn-outline-custom btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Back to Home
            </a>
        </div>
    </nav>

    <!-- AUTH CONTAINER -->
    <div class="auth-page-container flex-grow-1">
        <div class="auth-box">
            <!-- Header -->
            <div class="text-center mb-4">
                <span class="brand-badge mb-2" id="roleBadge">Student Mode</span>
                <h3 class="fw-bold mb-1">Welcome Back 👋</h3>
                <p class="text-muted small">Sign in to access your examinations and dashboard.</p>
            </div>

            <!-- Role Selector Tabs -->
            <div class="role-tabs">
                <button type="button" class="role-tab-btn active" data-role="student">
                    <i class="fa-solid fa-user-graduate"></i> Student Sign In
                </button>
                <button type="button" class="role-tab-btn" data-role="admin">
                    <i class="fa-solid fa-user-shield"></i> Admin Portal
                </button>
            </div>

            <!-- Flash Error Message -->
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger d-flex align-items-center gap-2 py-2 px-3 mb-3 border-0 rounded-3 shadow-sm" role="alert">
                    <i class="fa-solid fa-circle-exclamation fs-5"></i>
                    <div class="small fw-semibold">${errorMsg}</div>
                </div>
            </c:if>

            <!-- Flash Success Message -->
            <c:if test="${not empty successMsg}">
                <div class="alert alert-success d-flex align-items-center gap-2 py-2 px-3 mb-3 border-0 rounded-3 shadow-sm" role="alert">
                    <i class="fa-solid fa-circle-check fs-5"></i>
                    <div class="small fw-semibold">${successMsg}</div>
                </div>
            </c:if>

            <!-- Login Form -->
            <form action="/login" method="post" id="loginForm">
                <div class="form-floating-custom">
                    <label for="emailInput"><i class="fa-regular fa-envelope me-1 text-primary"></i> Email Address</label>
                    <input type="email" name="email" id="emailInput" class="form-control-custom" placeholder="name@example.com" required autocomplete="email">
                </div>

                <div class="form-floating-custom">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <label for="passwordInput" class="mb-0"><i class="fa-solid fa-lock me-1 text-primary"></i> Password</label>
                    </div>
                    <div class="input-group">
                        <input type="password" name="password" id="passwordInput" class="form-control-custom" placeholder="Enter your password" required>
                        <button type="button" class="btn btn-outline-secondary toggle-password-btn" style="border: 1.5px solid var(--border-color); border-left: 0; border-radius: 0 var(--radius-md) var(--radius-md) 0;">
                            <i class="fa-solid fa-eye text-muted"></i>
                        </button>
                    </div>
                </div>

                <div class="d-grid mt-4">
                    <button type="submit" class="btn-primary-gradient py-2 fs-6">
                        Sign In to ExamSphere <i class="fa-solid fa-arrow-right ms-1"></i>
                    </button>
                </div>
            </form>

            <!-- Footer / Register Link -->
            <div class="text-center mt-4 pt-3 border-top">
                <p class="text-muted small mb-0">
                    Don't have an account yet? 
                    <a href="/register" class="fw-bold text-primary">Create Student Account</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>