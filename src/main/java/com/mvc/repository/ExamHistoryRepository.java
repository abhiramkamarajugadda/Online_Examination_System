package com.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mvc.model.ExamHistory;

public interface ExamHistoryRepository
        extends JpaRepository<ExamHistory, Long> {

    List<ExamHistory> findByUserIdOrderByAttemptedAtDesc(Long userId);
}