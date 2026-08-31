/**
 * EXAMSPHERE - MODERN INTERACTIVE JAVASCRIPT ENGINE
 * Handles CBT Engine, Real-time Countdown Timer, Question Navigator Palette,
 * Live Search Filters, Form Validation, and Micro-interactions.
 */

document.addEventListener("DOMContentLoaded", function () {
  // Initialize Bootstrap Tooltips if available
  if (typeof bootstrap !== "undefined" && bootstrap.Tooltip) {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });
  }

  // Password visibility toggle
  const togglePasswordBtns = document.querySelectorAll(".toggle-password-btn");
  togglePasswordBtns.forEach((btn) => {
    btn.addEventListener("click", function () {
      const input = this.closest(".input-group").querySelector("input");
      const icon = this.querySelector("i");
      if (input.type === "password") {
        input.type = "text";
        if (icon) {
          icon.classList.remove("fa-eye");
          icon.classList.add("fa-eye-slash");
        }
      } else {
        input.type = "password";
        if (icon) {
          icon.classList.remove("fa-eye-slash");
          icon.classList.add("fa-eye");
        }
      }
    });
  });

  // Role tab switcher on login page
  const roleTabBtns = document.querySelectorAll(".role-tab-btn");
  roleTabBtns.forEach((btn) => {
    btn.addEventListener("click", function () {
      roleTabBtns.forEach((b) => b.classList.remove("active"));
      this.classList.add("active");
      const role = this.getAttribute("data-role");
      const emailInput = document.getElementById("emailInput");
      const passInput = document.getElementById("passwordInput");
      const roleBadge = document.getElementById("roleBadge");

      if (role === "admin") {
        if (emailInput) emailInput.value = "admin@examsphere.com";
        if (passInput) passInput.value = "admin123";
        if (roleBadge) {
          roleBadge.textContent = "Admin Mode";
          roleBadge.className = "brand-badge bg-danger text-white";
        }
      } else {
        if (emailInput) emailInput.value = "";
        if (passInput) passInput.value = "";
        if (roleBadge) {
          roleBadge.textContent = "Student Mode";
          roleBadge.className = "brand-badge";
        }
      }
    });
  });

  // Quick Table Search Filter
  const tableSearchInput = document.getElementById("tableSearchInput");
  if (tableSearchInput) {
    tableSearchInput.addEventListener("keyup", function () {
      const filter = this.value.toLowerCase();
      const rows = document.querySelectorAll(".searchable-table tbody tr, .searchable-table .glass-card");
      rows.forEach((row) => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(filter) ? "" : "none";
      });
    });
  }

  // =========================================================================
  // CBT ONLINE EXAM ENGINE
  // =========================================================================
  const examForm = document.getElementById("examForm");
  const timerElement = document.getElementById("examTimer");

  if (examForm && timerElement) {
    let durationMinutes = parseInt(timerElement.getAttribute("data-duration") || "30", 10);
    let totalSeconds = durationMinutes * 60;
    const timerPill = document.getElementById("timerPill");
    let isSubmitting = false;

    // Prevent accidental page reload or leave
    window.addEventListener("beforeunload", function (e) {
      if (!isSubmitting) {
        e.preventDefault();
        e.returnValue = "Are you sure you want to leave? Your exam progress will be lost.";
        return e.returnValue;
      }
    });

    // Update countdown timer
    function updateTimer() {
      if (totalSeconds <= 0) {
        clearInterval(timerInterval);
        timerElement.textContent = "00:00";
        if (timerPill) timerPill.className = "exam-timer-pill danger";
        isSubmitting = true;
        alert("Time is up! Your exam is being submitted automatically.");
        examForm.submit();
        return;
      }

      const mins = Math.floor(totalSeconds / 60);
      const secs = totalSeconds % 60;
      const formattedMins = mins < 10 ? "0" + mins : mins;
      const formattedSecs = secs < 10 ? "0" + secs : secs;
      timerElement.textContent = formattedMins + ":" + formattedSecs;

      if (timerPill) {
        if (totalSeconds <= 60) {
          timerPill.className = "exam-timer-pill danger";
        } else if (totalSeconds <= 300) {
          timerPill.className = "exam-timer-pill warning";
        }
      }

      totalSeconds--;
    }

    updateTimer();
    const timerInterval = setInterval(updateTimer, 1000);

    // Option selection & Palette update
    const optionTiles = document.querySelectorAll(".option-tile");
    optionTiles.forEach((tile) => {
      tile.addEventListener("click", function () {
        const radio = this.querySelector('input[type="radio"]');
        if (radio) {
          radio.checked = true;
          const name = radio.getAttribute("name");
          // Remove selected class from sibling option tiles
          document.querySelectorAll(`input[name="${name}"]`).forEach((r) => {
            const parent = r.closest(".option-tile");
            if (parent) parent.classList.remove("selected");
          });
          this.classList.add("selected");

          // Update palette badge to answered
          const qIndex = this.getAttribute("data-qindex");
          const paletteBtn = document.getElementById("palette-btn-" + qIndex);
          if (paletteBtn && !paletteBtn.classList.contains("flagged")) {
            paletteBtn.classList.add("answered");
          }
          updateAnsweredCount();
        }
      });
    });

    // Clear Selection
    document.querySelectorAll(".clear-choice-btn").forEach((btn) => {
      btn.addEventListener("click", function () {
        const qId = this.getAttribute("data-qid");
        const qIndex = this.getAttribute("data-qindex");
        const radios = document.querySelectorAll(`input[name="answer_${qId}"]`);
        radios.forEach((r) => {
          r.checked = false;
          const parent = r.closest(".option-tile");
          if (parent) parent.classList.remove("selected");
        });

        const paletteBtn = document.getElementById("palette-btn-" + qIndex);
        if (paletteBtn) {
          paletteBtn.classList.remove("answered");
        }
        updateAnsweredCount();
      });
    });

    // Flag for Review
    document.querySelectorAll(".flag-review-btn").forEach((btn) => {
      btn.addEventListener("click", function () {
        const qIndex = this.getAttribute("data-qindex");
        const paletteBtn = document.getElementById("palette-btn-" + qIndex);
        if (paletteBtn) {
          paletteBtn.classList.toggle("flagged");
          this.classList.toggle("btn-warning");
          this.classList.toggle("btn-outline-warning");
        }
      });
    });

    // Question Jump from Palette
    document.querySelectorAll(".palette-btn").forEach((btn) => {
      btn.addEventListener("click", function () {
        const targetQ = this.getAttribute("data-target");
        const targetElement = document.getElementById(targetQ);
        if (targetElement) {
          targetElement.scrollIntoView({ behavior: "smooth", block: "center" });
          document.querySelectorAll(".palette-btn").forEach((b) => b.classList.remove("active-q"));
          this.classList.add("active-q");
        }
      });
    });

    function updateAnsweredCount() {
      const checkedRadios = document.querySelectorAll('input[type="radio"]:checked');
      const answeredCount = checkedRadios.length;
      const totalCount = document.querySelectorAll('.question-card').length || document.querySelectorAll('.palette-btn').length;
      const counterEl = document.getElementById("answeredCounter");
      if (counterEl) {
        counterEl.textContent = `${answeredCount} of ${totalCount} Answered`;
      }
      const progressBar = document.getElementById("examProgressBar");
      if (progressBar && totalCount > 0) {
        const pct = Math.round((answeredCount / totalCount) * 100);
        progressBar.style.width = pct + "%";
      }

      // Also update modal numbers synchronously
      updateModalCounts();
    }

    function updateModalCounts() {
      const checkedRadios = document.querySelectorAll('input[type="radio"]:checked');
      const answeredCount = checkedRadios.length;
      const totalCount = document.querySelectorAll('.question-card').length || document.querySelectorAll('.palette-btn').length;
      const unattempted = Math.max(0, totalCount - answeredCount);

      const modalAnswered = document.getElementById("modalAnsweredCount");
      const modalUnattempted = document.getElementById("modalUnattemptedCount");
      if (modalAnswered) modalAnswered.textContent = answeredCount;
      if (modalUnattempted) modalUnattempted.textContent = unattempted;
    }

    // Modal show event listener (Bootstrap 5 modal lifecycle hook)
    const submitModal = document.getElementById("submitConfirmModal");
    if (submitModal) {
      submitModal.addEventListener("show.bs.modal", function () {
        updateModalCounts();
      });
    }

    // Submit confirmation modal final action
    const finalSubmitBtn = document.getElementById("finalSubmitBtn");
    if (finalSubmitBtn) {
      finalSubmitBtn.addEventListener("click", function () {
        isSubmitting = true;
        examForm.submit();
      });
    }

    // Initial calculation on load
    updateAnsweredCount();
  }
});