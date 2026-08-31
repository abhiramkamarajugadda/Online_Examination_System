package com.mvc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mvc.model.Exam;
import com.mvc.model.Question;
import com.mvc.model.Result;
import com.mvc.model.User;
import com.mvc.service.ExamService;
import com.mvc.service.QuestionService;
import com.mvc.service.ResultService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/student")
public class StudentController {

	private final ExamService examService;
	private final QuestionService questionService;
	private final ResultService resultService;

	public StudentController(ExamService examService, QuestionService questionService, ResultService resultService) {
		this.examService = examService;
		this.questionService = questionService;
		this.resultService = resultService;
	}

	// Student Dashboard
	@GetMapping("/dashboard")
	public ModelAndView dashboard(@RequestParam(required = false) String error, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return new ModelAndView("redirect:/login");
		}

		List<Exam> examList = examService.getAllExams();
		List<Result> resultList = resultService.getStudentResults(user.getId());

		int examCount = (examList != null) ? examList.size() : 0;
		int completedCount = (resultList != null) ? resultList.size() : 0;
		int totalScore = 0;
		int totalMarks = 0;
		int topScore = 0;

		if (resultList != null && !resultList.isEmpty()) {
			for (Result r : resultList) {
				totalScore += r.getScore();
				totalMarks += r.getTotalMarks();
				if (r.getScore() > topScore) {
					topScore = r.getScore();
				}
			}
		}

		double avgPercentage = (totalMarks > 0) ? Math.round(((double) totalScore / totalMarks) * 10000.0) / 100.0 : 0.0;
		String latestScore = (resultList != null && !resultList.isEmpty()) 
				? resultList.get(0).getScore() + " / " + resultList.get(0).getTotalMarks() 
				: "-";

		// Question counts & Student attempt counts per exam
		Map<Long, Long> questionCounts = new HashMap<>();
		Map<Long, Long> studentAttempts = new HashMap<>();
		if (examList != null) {
			for (Exam exam : examList) {
				questionCounts.put(exam.getId(), questionService.getQuestionCountByExam(exam.getId()));
				studentAttempts.put(exam.getId(), resultService.getAttemptCount(user.getId(), exam.getId()));
			}
		}

		ModelAndView mv = new ModelAndView("student-dashboard");
		mv.addObject("user", user);
		mv.addObject("examList", examList);
		mv.addObject("questionCounts", questionCounts);
		mv.addObject("studentAttempts", studentAttempts);
		mv.addObject("examCount", examCount);
		mv.addObject("completedCount", completedCount);
		mv.addObject("latestScore", latestScore);
		mv.addObject("avgPercentage", avgPercentage);
		mv.addObject("topScore", topScore);
		mv.addObject("recentResults", (resultList != null && resultList.size() > 4) ? resultList.subList(0, 4) : resultList);
		
		if ("MaxAttemptsReached".equals(error)) {
			mv.addObject("errorMsg", "You have already reached the maximum allowed attempts for this examination.");
		}
		
		return mv;
	}

	// Start Exam
	@GetMapping({"/exam/{id}", "/take-exam/{id}"})
	public ModelAndView startExam(@PathVariable Long id, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return new ModelAndView("redirect:/login");
		}

		Exam exam = examService.searchExam(id);
		if (exam == null || exam.getId() == null) {
			return new ModelAndView("redirect:/student/dashboard");
		}

		// Enforce attempt limit
		long attemptsTaken = resultService.getAttemptCount(user.getId(), id);
		int allowedAttempts = (exam.getMaxAttempts() != null && exam.getMaxAttempts() > 0) ? exam.getMaxAttempts() : 1;
		if (attemptsTaken >= allowedAttempts) {
			return new ModelAndView("redirect:/student/dashboard?error=MaxAttemptsReached");
		}

		List<Question> questionList = questionService.getQuestionsByExam(id);

		ModelAndView mv = new ModelAndView("take-exam");
		mv.addObject("exam", exam);
		mv.addObject("questionList", questionList);
		mv.addObject("user", user);
		mv.addObject("currentAttempt", attemptsTaken + 1);
		return mv;
	}

	// Submit Exam
	@PostMapping("/submit/{id}")
	public ModelAndView submitExam(@PathVariable Long id, 
	                              @RequestParam Map<String, String> answers, 
	                              HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return new ModelAndView("redirect:/login");
		}

		Exam exam = examService.searchExam(id);
		if (exam == null || exam.getId() == null) {
			return new ModelAndView("redirect:/student/dashboard");
		}

		// Verify attempt limit before processing
		long attemptsTaken = resultService.getAttemptCount(user.getId(), id);
		int allowedAttempts = (exam.getMaxAttempts() != null && exam.getMaxAttempts() > 0) ? exam.getMaxAttempts() : 1;
		if (attemptsTaken >= allowedAttempts) {
			return new ModelAndView("redirect:/student/dashboard?error=MaxAttemptsReached");
		}

		List<Question> questionList = questionService.getQuestionsByExam(id);
		int score = 0;
		int correctCount = 0;
		int incorrectCount = 0;
		int totalExamMarks = (exam.getTotalMarks() != null && exam.getTotalMarks() > 0) ? exam.getTotalMarks() : 0;

		// Build detailed review data
		List<Map<String, Object>> reviewList = new ArrayList<>();

		for (int i = 0; i < questionList.size(); i++) {
			Question q = questionList.get(i);
			String selectedOption = answers.get("answer_" + q.getId());
			boolean isCorrect = false;
			boolean isAttempted = (selectedOption != null && !selectedOption.trim().isEmpty());

			if (isAttempted) {
				if (selectedOption.trim().equalsIgnoreCase(q.getCorrectAnswer().trim())) {
					score += q.getMarks();
					correctCount++;
					isCorrect = true;
				} else {
					incorrectCount++;
				}
			}

			Map<String, Object> qReview = new HashMap<>();
			qReview.put("questionIndex", i + 1);
			qReview.put("question", q);
			qReview.put("selectedOption", selectedOption);
			qReview.put("isCorrect", isCorrect);
			qReview.put("isAttempted", isAttempted);
			reviewList.add(qReview);
		}

		if (totalExamMarks == 0) {
			for (Question q : questionList) {
				totalExamMarks += q.getMarks();
			}
		}

		Result result = new Result();
		result.setStudent(user);
		result.setExam(exam);
		result.setScore(score);
		result.setTotalMarks(totalExamMarks);
		result.setCorrectCount(correctCount);
		result.setIncorrectCount(incorrectCount);
		result.setPercentage(totalExamMarks > 0 ? Math.round(((double) score / totalExamMarks) * 10000.0) / 100.0 : 0.0);
		result.setPassStatus((result.getPercentage() >= 40.0) ? "Passed" : "Failed");

		Result savedResult = resultService.saveResult(result);

		ModelAndView mv = new ModelAndView("result");
		mv.addObject("exam", exam);
		mv.addObject("score", score);
		mv.addObject("totalMarks", totalExamMarks);
		mv.addObject("result", savedResult);
		mv.addObject("reviewList", reviewList);
		mv.addObject("user", user);
		return mv;
	}

	// Exam History
	@GetMapping("/history")
	public ModelAndView examHistory(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return new ModelAndView("redirect:/login");
		}

		List<Result> resultList = resultService.getStudentResults(user.getId());

		ModelAndView mv = new ModelAndView("history");
		mv.addObject("user", user);
		mv.addObject("resultList", resultList);
		return mv;
	}

	// Student Profile
	@GetMapping("/profile")
	public ModelAndView profile(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return new ModelAndView("redirect:/login");
		}

		List<Result> resultList = resultService.getStudentResults(user.getId());

		int totalExams = (resultList != null) ? resultList.size() : 0;
		int totalScore = 0;
		int totalMarks = 0;
		int passedCount = 0;

		if (resultList != null) {
			for (Result result : resultList) {
				totalScore += result.getScore();
				totalMarks += result.getTotalMarks();
				if ("Passed".equalsIgnoreCase(result.getPassStatus())) {
					passedCount++;
				}
			}
		}

		double averagePercentage = (totalMarks > 0) ? Math.round(((double) totalScore / totalMarks) * 10000.0) / 100.0 : 0.0;

		ModelAndView mv = new ModelAndView("profile");
		mv.addObject("user", user);
		mv.addObject("totalExams", totalExams);
		mv.addObject("passedCount", passedCount);
		mv.addObject("totalScore", totalScore);
		mv.addObject("totalMarks", totalMarks);
		mv.addObject("averagePercentage", averagePercentage);
		mv.addObject("resultList", resultList);
		return mv;
	}
}