package com.mvc.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.mvc.model.Result;

@Repository
public interface ResultRepository extends JpaRepository<Result, Long> {
	List<Result> findByStudent_Id(Long studentId);
	List<Result> findByStudent_IdOrderByIdDesc(Long studentId);
	List<Result> findByStudent_IdAndExam_Id(Long studentId, Long examId);
	long countByStudent_IdAndExam_Id(Long studentId, Long examId);
	List<Result> findAllByOrderByIdDesc();
	long countByStudent_Id(Long studentId);
}