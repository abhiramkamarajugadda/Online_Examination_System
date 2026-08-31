<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Profile - ExamSphere</title>
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
                    <a href="/student/history" class="nav-link-custom"><i class="fa-solid fa-clock-rotate-left"></i> Exam History</a>
                    <a href="/student/profile" class="nav-link-custom active"><i class="fa-regular fa-id-badge"></i> My Profile</a>
                </div>
            </div>
            <a href="/student/dashboard" class="btn btn-outline-custom btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Dashboard
            </a>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="container py-4 flex-grow-1">
        <div class="row g-4">
            <!-- Left Profile Card (8 Fields Display) -->
            <div class="col-lg-5">
                <div class="glass-card p-4">
                    <div class="text-center mb-3">
                        <div class="user-avatar-circle mx-auto mb-3" style="width: 80px; height: 80px; font-size: 2.2rem;">
                            ${user.fullName.substring(0,1)}
                        </div>
                        <h4 class="fw-bold text-dark mb-1">${user.fullName}</h4>
                        <p class="text-muted small mb-2"><i class="fa-regular fa-envelope me-1"></i> ${user.email}</p>
                        <span class="brand-badge mb-3"><i class="fa-solid fa-user-check me-1"></i> Registered Candidate</span>
                    </div>

                    <hr class="my-3">

                    <h6 class="fw-bold text-dark mb-3"><i class="fa-solid fa-address-card text-primary me-2"></i>Candidate Registration Details (8 Fields)</h6>
                    
                    <div class="d-flex flex-column gap-2 small">
                        <div class="p-2 bg-light rounded-2 border">
                            <span class="text-muted d-block fw-semibold">1. Full Name</span>
                            <strong class="text-dark">${user.fullName}</strong>
                        </div>
                        <div class="p-2 bg-light rounded-2 border">
                            <span class="text-muted d-block fw-semibold">2. Email Address</span>
                            <strong class="text-dark">${user.email}</strong>
                        </div>
                        <div class="p-2 bg-light rounded-2 border">
                            <span class="text-muted d-block fw-semibold">3. Phone Number</span>
                            <strong class="text-dark">${not empty user.phoneNumber ? user.phoneNumber : '-'}</strong>
                        </div>
                        <div class="p-2 bg-light rounded-2 border">
                            <span class="text-muted d-block fw-semibold">4. Gender</span>
                            <strong class="text-dark">${not empty user.gender ? user.gender : 'Not Specified'}</strong>
                        </div>
                        <div class="p-2 bg-light rounded-2 border">
                            <span class="text-muted d-block fw-semibold">5. Date of Birth</span>
                            <strong class="text-dark">${not empty user.dob ? user.dob : '-'}</strong>
                        </div>
                        <div class="p-2 bg-light rounded-2 border">
                            <span class="text-muted d-block fw-semibold">6. College / Institution</span>
                            <strong class="text-dark">${not empty user.institution ? user.institution : 'Not Specified'}</strong>
                        </div>
                        <div class="p-2 bg-light rounded-2 border">
                            <span class="text-muted d-block fw-semibold">7. Username</span>
                            <strong class="text-dark">@${user.username}</strong>
                        </div>
                        <div class="p-2 bg-light rounded-2 border">
                            <span class="text-muted d-block fw-semibold">8. Security Credentials</span>
                            <strong class="text-success"><i class="fa-solid fa-shield-halved me-1"></i> Password Protected (Active)</strong>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Analytics Card -->
            <div class="col-lg-7">
                <div class="glass-card mb-4">
                    <div class="card-header-clean">
                        <div>
                            <h5 class="mb-0 fw-bold"><i class="fa-solid fa-chart-pie text-primary me-2"></i>Academic Performance Analytics</h5>
                            <small class="text-muted">Summary of your overall test statistics</small>
                        </div>
                    </div>
                    <div class="card-body-clean">
                        <div class="row g-3 mb-4">
                            <div class="col-sm-6">
                                <div class="p-3 bg-light rounded-3 border text-center">
                                    <small class="text-muted d-block fw-semibold mb-1">TOTAL EXAMS TAKEN</small>
                                    <h3 class="fw-bold text-dark mb-0">${totalExams}</h3>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="p-3 bg-success-subtle border border-success-subtle rounded-3 text-center">
                                    <small class="text-success d-block fw-semibold mb-1">TESTS PASSED</small>
                                    <h3 class="fw-bold text-success mb-0">${passedCount}</h3>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="p-3 bg-light rounded-3 border text-center">
                                    <small class="text-muted d-block fw-semibold mb-1">TOTAL POINTS SCORED</small>
                                    <h3 class="fw-bold text-primary mb-0">${totalScore}</h3>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="p-3 bg-light rounded-3 border text-center">
                                    <small class="text-muted d-block fw-semibold mb-1">AVERAGE SCORE %</small>
                                    <h3 class="fw-bold text-dark mb-0">${averagePercentage}%</h3>
                                </div>
                            </div>
                        </div>

                        <!-- Progress Bar Indicator -->
                        <div class="mb-3">
                            <div class="d-flex justify-content-between text-muted small fw-bold mb-1">
                                <span>Overall Success Metric</span>
                                <span>${averagePercentage}%</span>
                            </div>
                            <div class="progress" style="height: 12px; border-radius: 10px;">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: ${averagePercentage}%;"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Action CTA -->
                <div class="glass-card p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fw-bold mb-1">Ready for your next examination?</h6>
                        <small class="text-muted">Take new test modules to boost your overall ranking.</small>
                    </div>
                    <a href="/student/dashboard" class="btn-primary-gradient">
                        <i class="fa-solid fa-play me-1"></i> Available Tests
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