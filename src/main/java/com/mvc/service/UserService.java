package com.mvc.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.mvc.model.User;
import com.mvc.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

    public User saveUser(User user) {
        return repository.save(user);
    }

    public User getUserById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public User checkLogin(String email, String password) {
        return repository.findByEmailAndPassword(email, password).orElse(null);
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