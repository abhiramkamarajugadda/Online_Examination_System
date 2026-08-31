package com.mvc.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.mvc.model.Question;
import com.mvc.repository.QuestionRepository;

@Service
public class QuestionService {

	private final QuestionRepository repository;

	public QuestionService(QuestionRepository repository) {
		this.repository = repository;
	}

	public Question saveQuestion(Question question) {
		return repository.save(question);
	}

	public List<Question> getQuestionsByExam(Long examId) {
		return repository.findByExamId(examId);
	}

	public Question getQuestionById(Long id) {
		return repository.findById(id).orElse(null);
	}

	public Question updateQuestion(Question question) {
		return repository.save(question);
	}

	public void deleteQuestion(Long id) {
		repository.deleteById(id);
	}

	public long getQuestionCountByExam(Long examId) {
		return repository.countByExamId(examId);
	}

	public long getTotalQuestionCount() {
		return repository.count();
	}
}
