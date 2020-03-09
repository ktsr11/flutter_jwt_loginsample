package com.web.backend.security.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.web.backend.security.model.Authority;

/**
 * Spring Data JPA repository for the {@link Authority} entity.
 */
public interface AuthorityRepository extends JpaRepository<Authority, String> {
}
