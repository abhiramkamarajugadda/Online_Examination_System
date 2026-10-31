<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ExamSphere - Next-Gen Online Examination System</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Custom Modern CSS -->
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

    <!-- NAVBAR -->
    <nav class="custom-navbar">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a href="/" class="brand-logo">
                <span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span>
                ExamSphere
                <span class="brand-badge ms-2 d-none d-sm-inline">v2.0 Pro</span>
            </a>
            <div class="d-flex align-items-center gap-3">
                <a href="/login" class="btn btn-outline-custom">
                    <i class="fa-solid fa-arrow-right-to-bracket"></i> Sign In
                </a>
                <a href="/register" class="btn-primary-gradient">
                    <i class="fa-solid fa-user-plus"></i> Get Started
                </a>
            </div>
        </div>
    </nav>

    <!-- HERO SECTION -->
    <main class="hero-wrapper flex-grow-1">
        <div class="container py-4">
            <div class="row align-items-center g-5">
                <!-- Left Hero Text -->
                <div class="col-lg-6">
                    <div class="hero-pill-badge">
                        <i class="fa-solid fa-sparkles text-warning"></i> Smart • Simple • Ultra-Secure Testing
                    </div>
                    <h1 class="hero-title">
                        Next-Gen Online <br>
                        <span class="gradient-text">Examination System</span> <br>
                        Engineered for Speed.
                    </h1>
                    <p class="hero-subtitle">
                        ExamSphere empowers educational institutions, educators, and students with real-time computer-based testing, instant automated evaluation, and deep performance analytics.
                    </p>
                    <div class="d-flex flex-wrap gap-3 mb-4">
                        <a href="/register" class="btn-primary-gradient px-4 py-3 fs-6">
                            <i class="fa-solid fa-rocket"></i> Launch Free Student Account
                        </a>
                        <a href="/login" class="btn btn-outline-custom px-4 py-3 fs-6">
                            <i class="fa-solid fa-shield-halved text-primary"></i> Admin & Student Portal →
                        </a>
                    </div>
                    <!-- Micro Stats -->
                    <div class="row g-3 pt-3 border-top">
                        <div class="col-4">
                            <div class="fw-bold text-dark fs-4">⚡ 0s Latency</div>
                            <small class="text-muted">Instant Grading</small>
                        </div>
                        <div class="col-4">
                            <div class="fw-bold text-dark fs-4">🔒 100% Secure</div>
                            <small class="text-muted">Anti-Cheating UI</small>
                        </div>
                        <div class="col-4">
                            <div class="fw-bold text-dark fs-4">📊 Real-Time</div>
                            <small class="text-muted">Score Analytics</small>
                        </div>
                    </div>
                </div>

                <!-- Right Hero Interactive Demo Card -->
                <div class="col-lg-6">
                    <div class="demo-exam-card">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <span class="badge bg-primary-subtle text-primary fw-bold text-uppercase px-2 py-1 mb-1">
                                    <i class="fa-solid fa-laptop-code"></i> Live CBT Simulation
                                </span>
                                <h4 class="mb-0 fw-bold">Java Full Stack Certification Test</h4>
                            </div>
                            <div class="exam-timer-pill py-1 px-3 fs-6">
                                <i class="fa-regular fa-clock text-primary"></i> 29:45
                            </div>
                        </div>

                        <div class="progress mb-3" style="height: 8px;">
                            <div class="progress-bar bg-primary" role="progressbar" style="width: 40%"></div>
                        </div>

                        <div class="card p-3 border-0 bg-light rounded-3 mb-3">
                            <div class="text-muted small fw-bold mb-1">QUESTION 04 OF 10 • (2 MARKS)</div>
                            <div class="fw-bold text-dark fs-6">
                                Which Java 21 feature provides lightweight threads for high-throughput concurrent applications?
                            </div>
                        </div>

                        <div class="d-flex flex-column gap-2">
                            <div class="option-tile selected p-2 mb-1">
                                <div class="option-letter-badge bg-primary text-white">A</div>
                                <div class="option-text fw-bold text-primary">Virtual Threads (Project Loom) <i class="fa-solid fa-circle-check text-success ms-2"></i></div>
                            </div>
                            <div class="option-tile p-2 mb-1">
                                <div class="option-letter-badge">B</div>
                                <div class="option-text">Java Native Interface (JNI)</div>
                            </div>
                            <div class="option-tile p-2 mb-1">
                                <div class="option-letter-badge">C</div>
                                <div class="option-text">Record Patterns</div>
                            </div>
                            <div class="option-tile p-2 mb-1">
                                <div class="option-letter-badge">D</div>
                                <div class="option-text">Thread Pool Executor</div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                            <small class="text-muted"><i class="fa-solid fa-shield-check text-success"></i> Auto-Save Enabled</small>
                            <span class="btn-primary-gradient py-1 px-3 fs-6">Next Question →</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- FOOTER -->
    <footer class="bg-white border-top py-4 mt-auto">
        <div class="container d-flex flex-wrap justify-content-between align-items-center text-muted small">
            <div>© 2026 ExamSphere Platform. All rights reserved. Designed with Spring Boot & JSP.</div>
            <div class="d-flex gap-3">
                <a href="/login" class="text-muted">Sign In</a>
                <a href="/register" class="text-muted">Register</a>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>