package com.web.backend.security.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.web.backend.security.SecurityUtils;
import com.web.backend.security.model.User;
import com.web.backend.security.repository.UserRepository;

import java.util.Optional;

@Service
@Transactional
public class UserService {

   private final UserRepository userRepository;

   public UserService(UserRepository userRepository) {
      this.userRepository = userRepository;
   }

   @Transactional(readOnly = true)
   public Optional<User> getUserWithAuthorities() {
      return SecurityUtils.getCurrentUsername().flatMap(userRepository::findOneWithAuthoritiesByUsername);
   }

}
