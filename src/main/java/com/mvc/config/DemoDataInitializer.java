package com.mvc.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.mvc.model.Exam;
import com.mvc.model.Question;
import com.mvc.model.User;
import com.mvc.repository.ExamRepository;
import com.mvc.repository.QuestionRepository;
import com.mvc.service.UserService;

/**
 * Seeds a sample exam and a public demo student on an empty database so a live demo
 * has something to try. Turn off with DEMO_SEED=false.
 */
@Component
public class DemoDataInitializer implements CommandLineRunner {

    private final ExamRepository examRepository;
    private final QuestionRepository questionRepository;
    private final UserService userService;
    private final boolean seed;
    private final String demoEmail;
    private final String demoPassword;

    public DemoDataInitializer(ExamRepository examRepository, QuestionRepository questionRepository,
                               UserService userService,
                               @Value("${app.demo.seed:true}") boolean seed,
                               @Value("${app.demo.student-email:demo@examsphere.com}") String demoEmail,
                               @Value("${app.demo.student-password:demo123}") String demoPassword) {
        this.examRepository = examRepository;
        this.questionRepository = questionRepository;
        this.userService = userService;
        this.seed = seed;
        this.demoEmail = demoEmail;
        this.demoPassword = demoPassword;
    }

    @Override
    public void run(String... args) {
        if (!seed) {
            return;
        }
        if (userService.searchUser(demoEmail) == null) {
            User demo = new User();
            demo.setFullName("Demo Student");
            demo.setUsername("demo");
            demo.setEmail(demoEmail);
            demo.setPassword(demoPassword);
            demo.setInstitution("ExamSphere Demo");
            userService.registerStudent(demo);
        }
        if (examRepository.count() == 0) {
            // Many attempts allowed because the demo student account is shared
            Exam exam = examRepository.save(new Exam(null, "Java Fundamentals (Sample)",
                    "A short sample quiz on core Java. 5 questions, 2 marks each.", 10, 10, 100));
            question(exam, "Which keyword is used to inherit a class in Java?",
                    "implements", "extends", "inherits", "super", "B");
            question(exam, "What is the default value of an int field in a Java class?",
                    "0", "null", "1", "Undefined", "A");
            question(exam, "Which collection does not allow duplicate elements?",
                    "ArrayList", "LinkedList", "HashSet", "Vector", "C");
            question(exam, "Which method is the entry point of a Java application?",
                    "start()", "run()", "init()", "main()", "D");
            question(exam, "Which of these is not a Java access modifier?",
                    "public", "protected", "friend", "private", "C");
        }
    }

    private void question(Exam exam, String text, String a, String b, String c, String d, String correct) {
        Question q = new Question();
        q.setExam(exam);
        q.setQuestionText(text);
        q.setOptionA(a);
        q.setOptionB(b);
        q.setOptionC(c);
        q.setOptionD(d);
        q.setCorrectAnswer(correct);
        q.setMarks(2);
        questionRepository.save(q);
    }
}
