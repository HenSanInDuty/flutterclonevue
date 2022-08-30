package com.clonevue.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.clonevue.entities.Users;

public interface UsersRepository extends JpaRepository<Users,Integer> {
	Users findByUsername(String username);
}
