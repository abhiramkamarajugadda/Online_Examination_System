package com.mvc;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import com.mvc.model.User;
import com.mvc.repository.ExamRepository;
import com.mvc.repository.QuestionRepository;
import com.mvc.service.UserService;

/** Boots the full app on H2: demo seed, BCrypt registration and login, admin login. */
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
class ExamSphereApplicationTests {

    @Autowired private MockMvc mockMvc;
    @Autowired private ExamRepository examRepository;
    @Autowired private QuestionRepository questionRepository;
    @Autowired private UserService userService;

    @Test
    void sampleExamAndDemoStudentAreSeeded() {
        assertThat(examRepository.count()).isEqualTo(1);
        assertThat(questionRepository.count()).isEqualTo(5);
        User demo = userService.searchUser("demo@examsphere.com");
        assertThat(demo).isNotNull();
        assertThat(demo.getPassword()).startsWith("$2").isNotEqualTo("demo123");
        assertThat(userService.checkLogin("demo@examsphere.com", "demo123")).isNotNull();
        assertThat(userService.checkLogin("demo@examsphere.com", "wrong")).isNull();
    }

    @Test
    void homeAndLoginPagesResolve() throws Exception {
        mockMvc.perform(get("/")).andExpect(status().isOk()).andExpect(view().name("home"));
        mockMvc.perform(get("/login")).andExpect(status().isOk()).andExpect(view().name("login"));
    }

    @Test
    void registrationHashesPasswordAndForcesStudentRole() throws Exception {
        mockMvc.perform(post("/register")
                        .param("fullName", "Test Student")
                        .param("email", "student1@example.com")
                        .param("password", "s3cretPass")
                        .param("role", "ADMIN"))
                .andExpect(status().isOk())
                .andExpect(view().name("login"));

        User saved = userService.searchUser("student1@example.com");
        assertThat(saved.getRole()).isEqualTo("STUDENT");
        assertThat(saved.getPassword()).startsWith("$2");

        mockMvc.perform(post("/login").param("email", "student1@example.com").param("password", "s3cretPass"))
                .andExpect(redirectedUrl("/student/dashboard"));
    }

    @Test
    void legacyPlainTextPasswordIsUpgradedOnLogin() {
        User legacy = new User();
        legacy.setEmail("legacy@example.com");
        legacy.setPassword("oldpass");
        legacy.setRole("STUDENT");
        userService.saveUser(legacy);

        assertThat(userService.checkLogin("legacy@example.com", "oldpass")).isNotNull();
        assertThat(userService.searchUser("legacy@example.com").getPassword()).startsWith("$2");
    }

    @Test
    void adminLoginUsesConfiguredCredentials() throws Exception {
        mockMvc.perform(post("/login").param("email", "admin@examsphere.com").param("password", "admin123"))
                .andExpect(redirectedUrl("/admin/dashboard"));
        mockMvc.perform(get("/admin/dashboard")).andExpect(redirectedUrl("/login"));
    }
}
