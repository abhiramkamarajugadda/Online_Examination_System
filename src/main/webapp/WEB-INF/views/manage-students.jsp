<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Students - ExamSphere Admin</title>
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
                    <a href="/admin/findAllExams" class="nav-link-custom"><i class="fa-solid fa-book-open"></i> Manage Exams</a>
                    <a href="/admin/results" class="nav-link-custom"><i class="fa-solid fa-chart-simple"></i> Test Results</a>
                    <a href="/admin/students" class="nav-link-custom active"><i class="fa-solid fa-users"></i> Students</a>
                </div>
            </div>
            <a href="/admin/dashboard" class="btn btn-outline-custom btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Dashboard
            </a>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="container py-4 flex-grow-1">
        <!-- Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
            <div>
                <h2 class="fw-bold text-dark mb-1">Registered Students Directory 🎓</h2>
                <p class="text-muted mb-0">View, edit student details, reset passwords, or remove student accounts.</p>
            </div>
        </div>

        <!-- Success Alert Message -->
        <c:if test="${not empty successMsg}">
            <div class="alert alert-success d-flex align-items-center gap-2 py-2 px-3 mb-4 border-0 rounded-3 shadow-sm" role="alert">
                <i class="fa-solid fa-circle-check fs-5"></i>
                <div class="small fw-semibold">${successMsg}</div>
            </div>
        </c:if>

        <!-- Filter Bar -->
        <div class="glass-card p-3 mb-4">
            <div class="row align-items-center g-3">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" id="tableSearchInput" class="form-control border-start-0" placeholder="Search students by name, email, college, or username...">
                    </div>
                </div>
                <div class="col-md-6 text-md-end text-muted small">
                    Total Registered Students: <strong>${studentList.size()}</strong>
                </div>
            </div>
        </div>

        <!-- Students Table -->
        <div class="glass-card">
            <div class="card-body-clean p-0">
                <c:choose>
                    <c:when test="${empty studentList}">
                        <div class="text-center py-5">
                            <div class="fs-1 text-muted mb-2">👥</div>
                            <h5 class="fw-bold text-dark">No Students Registered Yet</h5>
                            <p class="text-muted small mb-0">Registered students will appear in this directory automatically.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table-custom searchable-table">
                                <thead>
                                    <tr>
                                        <th style="width: 70px;">#ID</th>
                                        <th>Student Details</th>
                                        <th>Email Address</th>
                                        <th>Phone & Gender</th>
                                        <th>College / Institution</th>
                                        <th>Username</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${studentList}" var="std">
                                        <tr>
                                            <td><span class="badge bg-light text-muted border">#${std.id}</span></td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="user-avatar-circle" style="width: 32px; height: 32px; font-size: 0.85rem;">
                                                        ${std.fullName.substring(0,1)}
                                                    </div>
                                                    <div>
                                                        <div class="fw-bold text-dark">${std.fullName}</div>
                                                        <small class="text-muted">${not empty std.dob ? 'DOB: '.concat(std.dob) : ''}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><a href="mailto:${std.email}" class="text-primary">${std.email}</a></td>
                                            <td>
                                                <div>${not empty std.phoneNumber ? std.phoneNumber : '-'}</div>
                                                <small class="badge bg-light text-muted border">${not empty std.gender ? std.gender : 'Unspecified'}</small>
                                            </td>
                                            <td>
                                                <span class="fw-semibold text-dark">${not empty std.institution ? std.institution : '-'}</span>
                                            </td>
                                            <td><span class="badge bg-light text-dark border">@${std.username}</span></td>
                                            <td class="text-end">
                                                <div class="d-inline-flex gap-2">
                                                    <a href="/admin/student/edit/${std.id}" class="btn btn-sm btn-outline-secondary py-1 px-2" title="Edit Student Profile">
                                                        <i class="fa-solid fa-pen-to-square"></i> Edit
                                                    </a>
                                                    <a href="/admin/student/delete/${std.id}" class="btn btn-sm btn-outline-danger py-1 px-2" onclick="return confirm('Are you sure you want to delete student ${std.fullName}? All associated test attempts and results will also be deleted.');" title="Delete Student">
                                                        <i class="fa-solid fa-trash-can"></i> Delete
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>