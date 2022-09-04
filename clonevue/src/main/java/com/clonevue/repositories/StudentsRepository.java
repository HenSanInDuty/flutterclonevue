package com.clonevue.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.clonevue.entities.Students;

public interface StudentsRepository extends JpaRepository<Students,Integer>{
	 Optional<Students> findByName(String name);
}
