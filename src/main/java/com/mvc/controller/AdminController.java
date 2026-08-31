package com.mvc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.mvc.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private final ExamService examService;
	private final QuestionService questionService;
	private final ResultService resultService;
	private final UserService userService;

	public AdminController(ExamService examService, QuestionService questionService, 
	                       ResultService resultService, UserService userService) {
		this.examService = examService;
		this.questionService = questionService;
		this.resultService = resultService;
		this.userService = userService;
	}

	private boolean checkAdmin(HttpSession session) {
		String email = (String) session.getAttribute("adminEmail");
		return email != null && "admin@examsphere.com".equalsIgnoreCase(email);
	}

	// Admin Dashboard
	@GetMapping("/dashboard")
	public ModelAndView dashboard(HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}

		List<Exam> examList = examService.getAllExams();
		List<Result> recentResults = resultService.getAllResults();
		long totalQuestions = questionService.getTotalQuestionCount();
		long totalStudents = userService.getStudentCount();
		long totalAttempts = resultService.getTotalResultsCount();

		// Question counts map per exam
		Map<Long, Long> questionCounts = new HashMap<>();
		for (Exam exam : examList) {
			questionCounts.put(exam.getId(), questionService.getQuestionCountByExam(exam.getId()));
		}

		ModelAndView mv = new ModelAndView("admin-dashboard");
		mv.addObject("examList", examList);
		mv.addObject("questionCounts", questionCounts);
		mv.addObject("totalExams", examList.size());
		mv.addObject("totalQuestions", totalQuestions);
		mv.addObject("totalStudents", totalStudents);
		mv.addObject("totalAttempts", totalAttempts);
		mv.addObject("recentResults", recentResults != null && recentResults.size() > 5 ? recentResults.subList(0, 5) : recentResults);
		return mv;
	}

	// Manage All Exams
	@GetMapping({"/findAllExams", "/exams"})
	public ModelAndView manageExams(HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}

		List<Exam> examList = examService.getAllExams();
		Map<Long, Long> questionCounts = new HashMap<>();
		for (Exam exam : examList) {
			questionCounts.put(exam.getId(), questionService.getQuestionCountByExam(exam.getId()));
		}

		ModelAndView mv = new ModelAndView("manage-exams");
		mv.addObject("examList", examList);
		mv.addObject("questionCounts", questionCounts);
		return mv;
	}

	// Create Exam Page
	@GetMapping("/exam/create")
	public ModelAndView createExamPage(HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		return new ModelAndView("create-exam");
	}

	// Save Created Exam
	@PostMapping("/createExam")
	public ModelAndView createExam(@ModelAttribute Exam exam, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		examService.saveExam(exam);
		return new ModelAndView("redirect:/admin/findAllExams?success=ExamCreated");
	}

	// Edit Exam Page
	@GetMapping("/exam/edit/{id}")
	public ModelAndView editExamPage(@PathVariable Long id, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		Exam exam = examService.searchExam(id);
		if (exam == null || exam.getId() == null) {
			return new ModelAndView("redirect:/admin/findAllExams");
		}
		ModelAndView mv = new ModelAndView("create-exam");
		mv.addObject("exam", exam);
		mv.addObject("isEdit", true);
		return mv;
	}

	// Update Exam
	@PostMapping("/exam/update")
	public ModelAndView updateExam(@ModelAttribute Exam exam, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		examService.saveExam(exam);
		return new ModelAndView("redirect:/admin/findAllExams?success=ExamUpdated");
	}

	// Delete Exam
	@GetMapping("/deleteExam/{id}")
	public ModelAndView deleteExam(@PathVariable Long id, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		examService.deleteExam(id);
		return new ModelAndView("redirect:/admin/findAllExams?success=ExamDeleted");
	}

	// View Questions of an Exam
	@GetMapping("/questions/{examId}")
	public ModelAndView viewQuestions(@PathVariable Long examId, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		Exam exam = examService.searchExam(examId);
		if (exam == null || exam.getId() == null) {
			return new ModelAndView("redirect:/admin/findAllExams");
		}
		List<Question> questionList = questionService.getQuestionsByExam(examId);

		ModelAndView mv = new ModelAndView("view-questions");
		mv.addObject("exam", exam);
		mv.addObject("questionList", questionList);
		return mv;
	}

	// Open Add Question Page
	@GetMapping("/question/add")
	public ModelAndView openAddQuestionPage(@RequestParam Long examId, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		Exam exam = examService.searchExam(examId);
		if (exam == null || exam.getId() == null) {
			return new ModelAndView("redirect:/admin/findAllExams");
		}

		ModelAndView mv = new ModelAndView("add-question");
		mv.addObject("exam", exam);
		mv.addObject("examId", examId);
		return mv;
	}

	// Save Question
	@PostMapping("/addQuestion")
	public ModelAndView addQuestion(@RequestParam Long examId, @ModelAttribute Question question, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		Exam exam = examService.searchExam(examId);
		if (exam == null || exam.getId() == null) {
			return new ModelAndView("redirect:/admin/findAllExams");
		}
		question.setExam(exam);
		questionService.saveQuestion(question);
		return new ModelAndView("redirect:/admin/questions/" + examId + "?success=QuestionAdded");
	}

	// Open Edit Question Page
	@GetMapping("/question/edit/{id}")
	public ModelAndView openEditQuestionPage(@PathVariable Long id, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		Question question = questionService.getQuestionById(id);
		if (question == null) {
			return new ModelAndView("redirect:/admin/findAllExams");
		}

		ModelAndView mv = new ModelAndView("edit-question");
		mv.addObject("question", question);
		if (question.getExam() != null) {
			mv.addObject("examId", question.getExam().getId());
			mv.addObject("exam", question.getExam());
		}
		return mv;
	}

	// Update Question
	@PostMapping("/question/update")
	public ModelAndView updateQuestion(@ModelAttribute Question question, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		Question existingQuestion = questionService.getQuestionById(question.getId());
		if (existingQuestion == null) {
			return new ModelAndView("redirect:/admin/findAllExams");
		}

		Long examId = (existingQuestion.getExam() != null) ? existingQuestion.getExam().getId() : null;

		existingQuestion.setQuestionText(question.getQuestionText());
		existingQuestion.setOptionA(question.getOptionA());
		existingQuestion.setOptionB(question.getOptionB());
		existingQuestion.setOptionC(question.getOptionC());
		existingQuestion.setOptionD(question.getOptionD());
		existingQuestion.setCorrectAnswer(question.getCorrectAnswer());
		existingQuestion.setMarks(question.getMarks());

		questionService.updateQuestion(existingQuestion);

		if (examId != null) {
			return new ModelAndView("redirect:/admin/questions/" + examId + "?success=QuestionUpdated");
		}
		return new ModelAndView("redirect:/admin/findAllExams");
	}

	// Delete Question
	@GetMapping("/question/delete/{id}")
	public ModelAndView deleteQuestion(@PathVariable Long id, @RequestParam Long examId, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		questionService.deleteQuestion(id);
		return new ModelAndView("redirect:/admin/questions/" + examId + "?success=QuestionDeleted");
	}

	// View All Results
	@GetMapping("/results")
	public ModelAndView viewAllResults(HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		List<Result> results = resultService.getAllResults();
		ModelAndView mv = new ModelAndView("manage-results");
		mv.addObject("resultList", results);
		return mv;
	}

	// View Students Directory
	@GetMapping("/students")
	public ModelAndView viewStudents(@RequestParam(required = false) String success, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		List<User> students = userService.getAllStudents();
		ModelAndView mv = new ModelAndView("manage-students");
		mv.addObject("studentList", students);
		if (success != null) {
			if ("StudentUpdated".equals(success)) {
				mv.addObject("successMsg", "Student details updated successfully!");
			} else if ("StudentDeleted".equals(success)) {
				mv.addObject("successMsg", "Student account and associated records deleted successfully!");
			}
		}
		return mv;
	}

	// Open Edit Student Page
	@GetMapping("/student/edit/{id}")
	public ModelAndView openEditStudentPage(@PathVariable Long id, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		User student = userService.getUserById(id);
		if (student == null) {
			return new ModelAndView("redirect:/admin/students");
		}
		ModelAndView mv = new ModelAndView("edit-student");
		mv.addObject("student", student);
		return mv;
	}

	// Update Student Action (Supports all 8 fields)
	@PostMapping("/student/update")
	public ModelAndView updateStudent(@ModelAttribute User user, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		User existing = userService.getUserById(user.getId());
		if (existing == null) {
			return new ModelAndView("redirect:/admin/students");
		}

		existing.setFullName(user.getFullName());
		existing.setEmail(user.getEmail());
		existing.setPhoneNumber(user.getPhoneNumber());
		existing.setGender(user.getGender());
		existing.setDob(user.getDob());
		existing.setInstitution(user.getInstitution());
		existing.setUsername(user.getUsername());
		if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
			existing.setPassword(user.getPassword().trim());
		}

		userService.saveUser(existing);
		return new ModelAndView("redirect:/admin/students?success=StudentUpdated");
	}

	// Delete Student Action
	@GetMapping("/student/delete/{id}")
	public ModelAndView deleteStudent(@PathVariable Long id, HttpSession session) {
		if (!checkAdmin(session)) {
			return new ModelAndView("redirect:/login");
		}
		// First delete candidate results to satisfy FK constraint
		resultService.deleteResultsByStudentId(id);
		// Delete user
		userService.deleteUser(id);
		return new ModelAndView("redirect:/admin/students?success=StudentDeleted");
	}
}