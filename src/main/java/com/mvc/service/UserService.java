package com.mvc.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.mvc.model.User;
import com.mvc.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository repository, PasswordEncoder passwordEncoder) {
        this.repository = repository;
        this.passwordEncoder = passwordEncoder;
    }

    public User saveUser(User user) {
        return repository.save(user);
    }

    /** Registers a new student with a BCrypt-hashed password. */
    public User registerStudent(User user) {
        user.setRole("STUDENT");
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return repository.save(user);
    }

    /** Sets a new password (hashed) on an existing user. */
    public void changePassword(User user, String rawPassword) {
        user.setPassword(passwordEncoder.encode(rawPassword));
    }

    public User getUserById(Long id) {
        return repository.findById(id).orElse(null);
    }

    /**
     * Checks a login against the BCrypt hash. Rows saved before hashing was added
     * (plain text) still sign in once and are upgraded to a hash on that login.
     */
    public User checkLogin(String email, String password) {
        User user = repository.findByEmail(email).orElse(null);
        if (user == null || user.getPassword() == null || password == null) {
            return null;
        }
        String stored = user.getPassword();
        if (isBcrypt(stored)) {
            return passwordEncoder.matches(password, stored) ? user : null;
        }
        if (stored.equals(password)) {
            user.setPassword(passwordEncoder.encode(password));
            return repository.save(user);
        }
        return null;
    }

    private static boolean isBcrypt(String value) {
        return value.startsWith("$2a$") || value.startsWith("$2b$") || value.startsWith("$2y$");
    }

    public User searchUser(String email) {
        return repository.findByEmail(email).orElse(null);
    }

    public List<User> getAllStudents() {
        return repository.findByRole("STUDENT");
    }

    public long getStudentCount() {
        return repository.countByRole("STUDENT");
    }

    public void deleteUser(Long id) {
        repository.deleteById(id);
    }
}
