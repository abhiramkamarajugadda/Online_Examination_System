package com.mvc.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Exam {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String title;

	private String description;

	private Integer duration;

	private Integer totalMarks;

	private Integer maxAttempts = 1;

	public Exam() {
	}

	public Exam(Long id, String title, String description, Integer duration, Integer totalMarks, Integer maxAttempts) {
		this.id = id;
		this.title = title;
		this.description = description;
		this.duration = duration;
		this.totalMarks = totalMarks;
		this.maxAttempts = (maxAttempts != null && maxAttempts > 0) ? maxAttempts : 1;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getDuration() {
		return duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}

	public Integer getTotalMarks() {
		return totalMarks;
	}

	public void setTotalMarks(Integer totalMarks) {
		this.totalMarks = totalMarks;
	}

	public Integer getMaxAttempts() {
		return (maxAttempts != null && maxAttempts > 0) ? maxAttempts : 1;
	}

	public void setMaxAttempts(Integer maxAttempts) {
		this.maxAttempts = (maxAttempts != null && maxAttempts > 0) ? maxAttempts : 1;
	}
}