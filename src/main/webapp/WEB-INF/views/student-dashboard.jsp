<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal - ExamSphere</title>
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
                    <span class="brand-badge ms-2 d-none d-sm-inline">STUDENT</span>
                </a>
                <div class="d-none d-md-flex align-items-center gap-1 ms-3">
                    <a href="/student/dashboard" class="nav-link-custom active"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
                    <a href="/student/history" class="nav-link-custom"><i class="fa-solid fa-clock-rotate-left"></i> Exam History</a>
                    <a href="/student/profile" class="nav-link-custom"><i class="fa-regular fa-id-badge"></i> My Profile</a>
                </div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="user-profile-badge d-none d-sm-flex">
                    <div class="user-avatar-circle">
                        <c:choose>
                            <c:when test="${not empty user.fullName}">
                                ${user.fullName.substring(0,1)}
                            </c:when>
                            <c:otherwise>S</c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <div class="fw-bold text-dark small" style="line-height: 1.1;">${user.fullName}</div>
                        <small class="text-muted" style="font-size: 0.72rem;">${user.email}</small>
                    </div>
                </div>
                <a href="/logout" class="btn btn-outline-custom btn-sm text-danger border-danger-subtle">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="container py-4 flex-grow-1">
        <!-- Error Alert (e.g. Max Attempts reached) -->
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-warning d-flex align-items-center gap-2 py-3 px-4 mb-4 border-0 rounded-4 shadow-sm" role="alert">
                <i class="fa-solid fa-circle-exclamation fs-4 text-warning"></i>
                <div>
                    <div class="fw-bold">Attempt Limit Notice</div>
                    <div class="small">${errorMsg}</div>
                </div>
            </div>
        </c:if>

        <!-- Hero Greeting Banner -->
        <div class="glass-card p-4 mb-4" style="background: radial-gradient(circle at 95% 20%, rgba(79, 70, 229, 0.12), transparent 50%), #ffffff;">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div>
                    <span class="brand-badge mb-2"><i class="fa-solid fa-award text-warning"></i> Certified Candidate</span>
                    <h2 class="fw-bold text-dark mb-1">Welcome back, ${user.fullName} 👋</h2>
                    <p class="text-muted mb-0">Select an examination below to launch the interactive testing environment.</p>
                </div>
                <div class="d-flex gap-2">
                    <a href="/student/history" class="btn btn-outline-custom">
                        <i class="fa-solid fa-clock-rotate-left text-primary"></i> View History
                    </a>
                </div>
            </div>
        </div>

        <!-- 4 KPI Metrics -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon-circle stat-icon-indigo">
                        <i class="fa-solid fa-book-open"></i>
                    </div>
                    <div>
                        <div class="stat-title">Available Exams</div>
                        <div class="stat-value">${examCount}</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon-circle stat-icon-emerald">
                        <i class="fa-solid fa-circle-check"></i>
                    </div>
                    <div>
                        <div class="stat-title">Tests Completed</div>
                        <div class="stat-value">${completedCount}</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon-circle stat-icon-sky">
                        <i class="fa-solid fa-chart-line"></i>
                    </div>
                    <div>
                        <div class="stat-title">Average Score</div>
                        <div class="stat-value">${avgPercentage}%</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon-circle stat-icon-amber">
                        <i class="fa-solid fa-trophy"></i>
                    </div>
                    <div>
                        <div class="stat-title">Top Score</div>
                        <div class="stat-value">${topScore} pts</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Available Exams Section -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h4 class="fw-bold text-dark mb-0"><i class="fa-solid fa-laptop-code text-primary me-2"></i>Available Examinations</h4>
                <small class="text-muted">Take your tests online with real-time countdown timer & instant grading.</small>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty examList}">
                <div class="glass-card text-center py-5 mb-4">
                    <div class="fs-1 text-muted mb-2">📚</div>
                    <h5 class="fw-bold text-dark">No Examinations Currently Available</h5>
                    <p class="text-muted small mb-0">Check back soon or contact your administrator for new test schedules.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4 mb-4">
                    <c:forEach items="${examList}" var="exam">
                        <c:set var="usedAttempts" value="${not empty studentAttempts[exam.id] ? studentAttempts[exam.id] : 0}" />
                        <c:set var="maxAllowed" value="${not empty exam.maxAttempts && exam.maxAttempts > 0 ? exam.maxAttempts : 1}" />
                        <c:set var="isLimitReached" value="${usedAttempts >= maxAllowed}" />

                        <div class="col-md-6 col-lg-4">
                            <div class="glass-card h-100 d-flex flex-column p-4 ${isLimitReached ? 'border-secondary-subtle opacity-90' : ''}">
                                <div class="d-flex justify-content-between align-items-start mb-3 gap-2 flex-wrap">
                                    <span class="badge bg-primary-subtle text-primary fw-bold px-2 py-1">
                                        <i class="fa-solid fa-layer-group me-1"></i> ${questionCounts[exam.id]} Questions
                                    </span>
                                    
                                    <c:choose>
                                        <c:when test="${isLimitReached}">
                                            <span class="badge bg-secondary text-white fw-bold px-2 py-1">
                                                <i class="fa-solid fa-lock me-1"></i> Completed (${usedAttempts}/${maxAllowed})
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-success-subtle text-success fw-bold px-2 py-1">
                                                <i class="fa-solid fa-unlock me-1"></i> Attempt ${usedAttempts + 1} of ${maxAllowed}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <h5 class="fw-bold text-dark mb-2">${exam.title}</h5>
                                <p class="text-muted small flex-grow-1 mb-3">
                                    ${not empty exam.description ? exam.description : 'Standard online comprehensive assessment covering modern syllabus.'}
                                </p>

                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="badge bg-light text-dark border px-2 py-1">
                                        <i class="fa-regular fa-clock text-primary me-1"></i> ${exam.duration} Mins
                                    </span>
                                    <span class="badge bg-light text-dark border px-2 py-1">
                                        <i class="fa-solid fa-bullseye text-success me-1"></i> ${exam.totalMarks} Points
                                    </span>
                                </div>

                                <div class="d-flex justify-content-between align-items-center pt-3 border-top mt-auto">
                                    <c:choose>
                                        <c:when test="${isLimitReached}">
                                            <small class="text-muted fw-semibold"><i class="fa-solid fa-circle-check text-success"></i> Submitted</small>
                                            <a href="/student/history" class="btn btn-outline-success py-2 px-3 fs-6">
                                                <i class="fa-solid fa-square-poll-vertical me-1"></i> View Result
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <small class="text-muted fw-semibold">Ready to take</small>
                                            <a href="/student/take-exam/${exam.id}" class="btn-primary-gradient py-2 px-3 fs-6">
                                                Start Test <i class="fa-solid fa-arrow-right ms-1"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Recent Completed Tests Feed -->
        <c:if test="${not empty recentResults}">
            <div class="glass-card">
                <div class="card-header-clean">
                    <div>
                        <h5 class="mb-0 fw-bold"><i class="fa-solid fa-clock-rotate-left text-primary me-2"></i>Recent Test Attempts</h5>
                        <small class="text-muted">Your latest evaluated results</small>
                    </div>
                    <a href="/student/history" class="btn btn-outline-custom btn-sm">Full History →</a>
                </div>
                <div class="card-body-clean p-0">
                    <div class="table-responsive">
                        <table class="table-custom">
                            <thead>
                                <tr>
                                    <th>Exam Title</th>
                                    <th>Score</th>
                                    <th>Percentage</th>
                                    <th>Grade</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentResults}" var="res">
                                    <tr>
                                        <td><span class="fw-bold text-dark">${res.exam.title}</span></td>
                                        <td><strong class="text-primary">${res.score}</strong> / ${res.totalMarks}</td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="progress flex-grow-1" style="height: 6px; width: 60px;">
                                                    <div class="progress-bar ${res.percentage >= 40 ? 'bg-success' : 'bg-danger'}" style="width: ${res.percentage}%;"></div>
                                                </div>
                                                <span class="small fw-bold">${res.percentage}%</span>
                                            </div>
                                        </td>
                                        <td><span class="badge bg-light text-dark border px-2 py-1">${res.grade}</span></td>
                                        <td>
                                            <span class="badge ${res.percentage >= 40 ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'} fw-bold px-2 py-1">
                                                ${res.passStatus}
                                            </span>
                                        </td>
                                        <td><small class="text-muted">${res.formattedDate}</small></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>
    </main>

    <!-- FOOTER -->
    <footer class="bg-white border-top py-3 mt-auto">
        <div class="container d-flex justify-content-between align-items-center text-muted small">
            <div>ExamSphere Student Portal © 2026</div>
            <div>Spring Boot + JSP Experience</div>
        </div>
    </footer>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>