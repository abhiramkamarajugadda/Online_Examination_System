package com.mvc.model;

import jakarta.persistence.*;

@Entity
public class Question {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String questionText, optionA, optionB, optionC, optionD, correctAnswer;
	private int marks;
	@ManyToOne
	@JoinColumn(name = "exam_id")
	private Exam exam;

	public Long getId() {
		return id;
	}

	public void setId(Long v) {
		id = v;
	}

	public String getQuestionText() {
		return questionText;
	}

	public void setQuestionText(String v) {
		questionText = v;
	}

	public String getOptionA() {
		return optionA;
	}

	public void setOptionA(String v) {
		optionA = v;
	}

	public String getOptionB() {
		return optionB;
	}

	public void setOptionB(String v) {
		optionB = v;
	}

	public String getOptionC() {
		return optionC;
	}

	public void setOptionC(String v) {
		optionC = v;
	}

	public String getOptionD() {
		return optionD;
	}

	public void setOptionD(String v) {
		optionD = v;
	}

	public String getCorrectAnswer() {
		return correctAnswer;
	}

	public void setCorrectAnswer(String v) {
		correctAnswer = v;
	}

	public int getMarks() {
		return marks;
	}

	public void setMarks(int v) {
		marks = v;
	}

	public Exam getExam() {
		return exam;
	}

	public void setExam(Exam v) {
		exam = v;
	}
}