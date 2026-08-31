package com.mvc.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.mvc.model.Result;
import com.mvc.repository.ResultRepository;

@Service
public class ResultService {

	private final ResultRepository repository;

	public ResultService(ResultRepository repository) {
		this.repository = repository;
	}

	public Result saveResult(Result result) {
		return repository.save(result);
	}

	public List<Result> getStudentResults(Long studentId) {
		return repository.findByStudent_IdOrderByIdDesc(studentId);
	}

	public List<Result> getAllResults() {
		return repository.findAllByOrderByIdDesc();
	}

	public Result getResultById(Long id) {
		return repository.findById(id).orElse(null);
	}

	public long getTotalResultsCount() {
		return repository.count();
	}

	public void deleteResultsByStudentId(Long studentId) {
		List<Result> results = repository.findByStudent_Id(studentId);
		if (results != null && !results.isEmpty()) {
			repository.deleteAll(results);
		}
	}

	public long getAttemptCount(Long studentId, Long examId) {
		return repository.countByStudent_IdAndExam_Id(studentId, examId);
	}

	public List<Result> getStudentExamResults(Long studentId, Long examId) {
		return repository.findByStudent_IdAndExam_Id(studentId, examId);
	}
}