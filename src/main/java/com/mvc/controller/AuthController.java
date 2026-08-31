package com.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mvc.model.User;
import com.mvc.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

	private final UserService userService;

	public AuthController(UserService userService) {
		this.userService = userService;
	}

	// Home page
	@GetMapping("/")
	public ModelAndView home() {
		return new ModelAndView("home");
	}

	// Registration page
	@GetMapping("/register")
	public ModelAndView registerPage() {
		return new ModelAndView("register");
	}

	// Register user
	@PostMapping("/register")
	public ModelAndView registerUser(@ModelAttribute User user) {
		User existingUser = userService.searchUser(user.getEmail());

		if (existingUser != null && existingUser.getId() != null) {
			ModelAndView mv = new ModelAndView("register");
			mv.addObject("errorMsg", "This email address is already registered. Please login.");
			return mv;
		}

		user.setRole("STUDENT");
		userService.saveUser(user);

		ModelAndView mv = new ModelAndView("login");
		mv.addObject("successMsg", "Registration successful! You can now sign in.");
		return mv;
	}

	// Login page
	@GetMapping("/login")
	public ModelAndView loginPage() {
		return new ModelAndView("login");
	}

	// Process login
	@PostMapping("/login")
	public ModelAndView login(@RequestParam String email, @RequestParam String password, HttpSession session) {
		// Admin login check
		if ("admin@examsphere.com".equalsIgnoreCase(email) && "admin123".equals(password)) {
			session.setAttribute("adminEmail", email);
			session.setAttribute("adminName", "Administrator");
			return new ModelAndView("redirect:/admin/dashboard");
		}

		// Student login check
		User user = userService.checkLogin(email, password);
		if (user != null && user.getId() != null) {
			session.setAttribute("email", email);
			session.setAttribute("user", user);
			return new ModelAndView("redirect:/student/dashboard");
		}

		ModelAndView mv = new ModelAndView("login");
		mv.addObject("errorMsg", "Invalid email address or password. Please try again.");
		return mv;
	}

	// Logout
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		return new ModelAndView("redirect:/login?loggedOut=true");
	}
}
