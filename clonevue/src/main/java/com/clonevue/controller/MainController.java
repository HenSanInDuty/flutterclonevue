package com.clonevue.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.clonevue.entities.Students;
import com.clonevue.entities.Users;
import com.clonevue.repositories.StudentsRepository;
import com.clonevue.repositories.UsersRepository;
import com.clonevue.service.UserService;

@RestController
@CrossOrigin
@RequestMapping("/")
public class MainController {
	@Autowired
    private AuthenticationManager authenticationManager;
	
	@Autowired
    PasswordEncoder passwordEncoder;
	
	@Autowired
	StudentsRepository studentsRepository;
	
	@Autowired
	UsersRepository usersRepository;
	
	@Autowired
	UserService userService;
	
	@GetMapping("/studentlist")
	List<Students> getAllStudent(){
		return studentsRepository.findAll();
	}
	
	@PostMapping("/addstudent")
	ResponseEntity<String> addStudent(@RequestBody Students newStudent){
		try{
			if (studentsRepository.save(newStudent) != null) {
				return ResponseEntity.ok("Them thanh cong");
			} else {
				return ResponseEntity.badRequest().body("Them that bai");
			}
		} catch (Exception e) {
			return ResponseEntity.badRequest().body("Them that bai");
		}
		
	}
	
	@DeleteMapping("/deletestudent/{id}")
	ResponseEntity<String> deleteStudent(@PathVariable(name="id") int id){
		try{
			Optional<Students> findedStudent = studentsRepository.findById(id);
			if(findedStudent.isPresent()) {
				studentsRepository.delete(findedStudent.get());
				return ResponseEntity.ok("Xoa thanh cong");
			} else {
				return ResponseEntity.badRequest().body("Xoa that bai");
			}
		} catch (Exception e) {
			return ResponseEntity.badRequest().body("Xoa that bai");
		}
		
	}
	
	@PatchMapping("/assignteam")
	ResponseEntity<String> updateTeam(@RequestBody Map<String,String> data){
		Optional<String> nameValid = Optional.of(data.get("id"));
		Optional<String> teamValid = Optional.of(data.get("team"));
		List<String> teams = new ArrayList<String>();
		teams.add("Team 1");
		teams.add("Team 2");
		teams.add("Team 3");
		teams.add("Team 4");
		System.out.println(nameValid.get() + " " + teamValid.get());
		if (nameValid.isPresent() && teamValid.isPresent() && teams.indexOf(teamValid.get())!=-1) {
			Optional<Students> student = studentsRepository.findById(Integer.parseInt(nameValid.get()));
			if (student.isPresent()) {
				student.get().setTeams(teamValid.get());
				studentsRepository.save(student.get());
				return ResponseEntity.ok().body("Sua thanh cong");
			} 
		}
		return ResponseEntity.badRequest().body("Sua that bai");
	}
	
	@PostMapping("/register")
	ResponseEntity<String> createUser(@RequestBody Users user){
		try {
			user.setPassword(passwordEncoder.encode(user.getPassword()));
			if (usersRepository.findByUsername(user.getUsername())!=null) {
				return ResponseEntity.badRequest().body("User da ton tai");
			}
			usersRepository.save(user);
			return ResponseEntity.ok().body("Them user thanh cong");
		} catch (Exception e)
		{
			return ResponseEntity.badRequest().body("Them user that bai");
		}	
	}
	
	 @PostMapping("/login")
	    public ResponseEntity<?> login(@RequestBody Users user){
		 Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
				 user.getUsername(), user.getPassword()));
		 if (authentication.getPrincipal()!=null) {
			 SecurityContextHolder.getContext().setAuthentication(authentication);
		        return ResponseEntity.ok("Dang nhap thanh cong");
		 } else {
			 return ResponseEntity.badRequest().body("Sai mat khau hoac tai khoan");
		 }
	        
	 }
	 
}
