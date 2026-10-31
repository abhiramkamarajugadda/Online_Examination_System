<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CBT Examination: ${exam.title} - ExamSphere</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Custom Modern CSS -->
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="bg-main">

    <!-- CBT STICKY HEADER -->
    <header class="exam-top-bar">
        <div class="container-fluid d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div class="d-flex align-items-center gap-3">
                <span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span>
                <div>
                    <h5 class="fw-bold mb-0 text-dark">${exam.title}</h5>
                    <small class="text-muted d-none d-sm-inline">Candidate: <strong>${user.fullName}</strong> (${user.email})</small>
                </div>
            </div>

            <!-- Timer & Action -->
            <div class="d-flex align-items-center gap-3">
                <div class="exam-timer-pill" id="timerPill">
                    <i class="fa-regular fa-clock"></i>
                    <span id="examTimer" data-duration="${exam.duration}">00:00</span>
                </div>
                <button type="button" class="btn-primary-gradient py-2 px-3 fs-6" id="openSubmitModalBtn" data-bs-toggle="modal" data-bs-target="#submitConfirmModal">
                    <i class="fa-solid fa-cloud-arrow-up me-1"></i> Submit Test
                </button>
            </div>
        </div>

        <!-- Live Progress Strip -->
        <div class="progress mt-2" style="height: 4px;">
            <div class="progress-bar bg-success" id="examProgressBar" role="progressbar" style="width: 0%;"></div>
        </div>
    </header>

    <!-- EXAM BODY -->
    <main class="container-fluid py-4 px-md-4">
        <form id="examForm" action="/student/submit/${exam.id}" method="post">
            <div class="row g-4">
                <!-- Left Main: Question Stream -->
                <div class="col-lg-8 col-xl-9">
                    <c:choose>
                        <c:when test="${empty questionList}">
                            <div class="glass-card text-center py-5">
                                <div class="fs-1 text-muted mb-2">📋</div>
                                <h4 class="fw-bold text-dark">No Questions Found in this Exam</h4>
                                <p class="text-muted small mb-3">Please notify your administrator or return to the dashboard.</p>
                                <a href="/student/dashboard" class="btn btn-outline-custom">Return to Dashboard</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${questionList}" var="q" varStatus="loop">
                                <div class="question-card" id="q-card-${loop.count}">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="question-badge">
                                            QUESTION ${loop.count} OF ${questionList.size()}
                                        </span>
                                        <div class="d-flex align-items-center gap-2">
                                            <span class="badge bg-light text-muted border">${q.marks} Mark(s)</span>
                                            <button type="button" class="btn btn-sm btn-outline-warning flag-review-btn py-1 px-2" data-qindex="${loop.count}">
                                                <i class="fa-regular fa-bookmark me-1"></i> Flag for Review
                                            </button>
                                            <button type="button" class="btn btn-sm btn-outline-secondary clear-choice-btn py-1 px-2" data-qid="${q.id}" data-qindex="${loop.count}">
                                                <i class="fa-solid fa-eraser me-1"></i> Clear
                                            </button>
                                        </div>
                                    </div>

                                    <div class="question-text">
                                        ${q.questionText}
                                    </div>

                                    <!-- Options Grid -->
                                    <div class="options-container">
                                        <label class="option-tile" data-qindex="${loop.count}">
                                            <input type="radio" name="answer_${q.id}" value="A">
                                            <div class="option-letter-badge">A</div>
                                            <div class="option-text">${q.optionA}</div>
                                        </label>

                                        <label class="option-tile" data-qindex="${loop.count}">
                                            <input type="radio" name="answer_${q.id}" value="B">
                                            <div class="option-letter-badge">B</div>
                                            <div class="option-text">${q.optionB}</div>
                                        </label>

                                        <label class="option-tile" data-qindex="${loop.count}">
                                            <input type="radio" name="answer_${q.id}" value="C">
                                            <div class="option-letter-badge">C</div>
                                            <div class="option-text">${q.optionC}</div>
                                        </label>

                                        <label class="option-tile" data-qindex="${loop.count}">
                                            <input type="radio" name="answer_${q.id}" value="D">
                                            <div class="option-letter-badge">D</div>
                                            <div class="option-text">${q.optionD}</div>
                                        </label>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Right Sidebar: Question Palette & Live Status -->
                <div class="col-lg-4 col-xl-3">
                    <div class="glass-card p-3 sticky-top" style="top: 85px; z-index: 1020;">
                        <div class="d-flex justify-content-between align-items-center mb-2 pb-2 border-bottom">
                            <h6 class="fw-bold text-dark mb-0"><i class="fa-solid fa-table-cells text-primary me-2"></i>Question Palette</h6>
                            <span class="badge bg-primary-subtle text-primary" id="answeredCounter">0 of ${questionList.size()} Answered</span>
                        </div>

                        <!-- Numbered Grid -->
                        <div class="palette-grid">
                            <c:forEach items="${questionList}" var="q" varStatus="loop">
                                <button type="button" class="palette-btn" id="palette-btn-${loop.count}" data-target="q-card-${loop.count}">
                                    ${loop.count}
                                </button>
                            </c:forEach>
                        </div>

                        <!-- Legend -->
                        <div class="palette-legend">
                            <div class="legend-item"><div class="legend-dot bg-success"></div> Answered</div>
                            <div class="legend-item"><div class="legend-dot bg-light border"></div> Not Answered</div>
                            <div class="legend-item"><div class="legend-dot bg-warning"></div> Flagged for Review</div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="button" class="btn-primary-gradient py-2" data-bs-toggle="modal" data-bs-target="#submitConfirmModal">
                                <i class="fa-solid fa-paper-plane me-1"></i> Submit Examination
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </main>

    <!-- SUBMIT CONFIRMATION MODAL -->
    <div class="modal fade" id="submitConfirmModal" tabindex="-1" aria-labelledby="submitModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 shadow-lg border-0">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold" id="submitModalLabel">Ready to Submit Examination? 🎯</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <p class="text-muted small mb-4">Please review your question attempt summary before confirming submission. Once submitted, your answers cannot be modified.</p>
                    <div class="row g-3 text-center">
                        <div class="col-6">
                            <div class="p-3 bg-success-subtle border border-success-subtle rounded-3">
                                <div class="fs-2 fw-bold text-success" id="modalAnsweredCount">0</div>
                                <div class="small fw-semibold text-success">Questions Answered</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 bg-danger-subtle border border-danger-subtle rounded-3">
                                <div class="fs-2 fw-bold text-danger" id="modalUnattemptedCount">${questionList.size()}</div>
                                <div class="small fw-semibold text-danger">Unanswered Questions</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Return to Test</button>
                    <button type="button" class="btn-primary-gradient px-4" id="finalSubmitBtn">
                        <i class="fa-solid fa-check"></i> Yes, Submit Now
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>