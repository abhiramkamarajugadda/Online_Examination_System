package com.mvc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mvc.model.ExamHistory;
import com.mvc.repository.ExamHistoryRepository;

@Service
public class ExamHistoryService {

    private ExamHistoryRepository repository;

    public ExamHistoryService(ExamHistoryRepository repository) {
        this.repository = repository;
    }

    // Save exam result
    public ExamHistory saveHistory(ExamHistory history) {
        return repository.save(history);
    }

    // Get history of one student
    public List<ExamHistory> getHistoryByUserId(Long userId) {

        return repository
                .findByUserIdOrderByAttemptedAtDesc(userId);
    }
}