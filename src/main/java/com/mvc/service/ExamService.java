package com.mvc.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.mvc.model.Exam;
import com.mvc.repository.ExamRepository;
import com.mvc.repository.QuestionRepository;

@Service
public class ExamService {

    private final ExamRepository repository;
    private final QuestionRepository questionRepository;

    public ExamService(ExamRepository repository, QuestionRepository questionRepository) {
        this.repository = repository;
        this.questionRepository = questionRepository;
    }

    public Exam saveExam(Exam exam) {
        return repository.save(exam);
    }

    public List<Exam> getAllExams() {
        return repository.findAllByOrderByIdDesc();
    }

    public Exam searchExam(Long id) {
        return repository.findById(id).orElse(new Exam());
    }

    public void deleteExam(Long id) {
        // First delete questions associated with the exam
        var questions = questionRepository.findByExamId(id);
        if (questions != null && !questions.isEmpty()) {
            questionRepository.deleteAll(questions);
        }
        repository.deleteById(id);
    }

    public long getExamCount() {
        return repository.count();
    }
}
