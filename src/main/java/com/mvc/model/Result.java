package com.mvc.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name = "results")
public class Result {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private int score;

	private int totalMarks;

	private double percentage;

	private String passStatus;

	private int correctCount;

	private int incorrectCount;

	private LocalDateTime attemptedAt;

	@ManyToOne
	@JoinColumn(name = "student_id")
	private User student;

	@ManyToOne
	@JoinColumn(name = "exam_id")
	private Exam exam;

	public Result() {
	}

	@PrePersist
	public void prePersist() {
		if (this.attemptedAt == null) {
			this.attemptedAt = LocalDateTime.now();
		}
		if (this.totalMarks > 0) {
			this.percentage = Math.round(((double) this.score / this.totalMarks) * 10000.0) / 100.0;
			this.passStatus = (this.percentage >= 40.0) ? "Passed" : "Failed";
		}
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public int getTotalMarks() {
		return totalMarks;
	}

	public void setTotalMarks(int totalMarks) {
		this.totalMarks = totalMarks;
	}

	public double getPercentage() {
		if (percentage == 0 && totalMarks > 0) {
			return Math.round(((double) score / totalMarks) * 10000.0) / 100.0;
		}
		return percentage;
	}

	public void setPercentage(double percentage) {
		this.percentage = percentage;
	}

	public String getPassStatus() {
		if (passStatus == null && totalMarks > 0) {
			return (getPercentage() >= 40.0) ? "Passed" : "Failed";
		}
		return passStatus;
	}

	public void setPassStatus(String passStatus) {
		this.passStatus = passStatus;
	}

	public int getCorrectCount() {
		return correctCount;
	}

	public void setCorrectCount(int correctCount) {
		this.correctCount = correctCount;
	}

	public int getIncorrectCount() {
		return incorrectCount;
	}

	public void setIncorrectCount(int incorrectCount) {
		this.incorrectCount = incorrectCount;
	}

	public LocalDateTime getAttemptedAt() {
		return attemptedAt;
	}

	public void setAttemptedAt(LocalDateTime attemptedAt) {
		this.attemptedAt = attemptedAt;
	}

	public User getStudent() {
		return student;
	}

	public void setStudent(User student) {
		this.student = student;
	}

	public Exam getExam() {
		return exam;
	}

	public void setExam(Exam exam) {
		this.exam = exam;
	}

	// Helper methods for JSP
	public String getFormattedDate() {
		if (attemptedAt != null) {
			return attemptedAt.format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a"));
		}
		return "-";
	}

	public int getPercentageInt() {
		return (int) Math.round(getPercentage());
	}

	public String getGrade() {
		double pct = getPercentage();
		if (pct >= 90) return "A+ (Outstanding)";
		if (pct >= 80) return "A (Excellent)";
		if (pct >= 70) return "B (Very Good)";
		if (pct >= 60) return "C (Good)";
		if (pct >= 40) return "D (Pass)";
		return "F (Needs Improvement)";
	}
}
