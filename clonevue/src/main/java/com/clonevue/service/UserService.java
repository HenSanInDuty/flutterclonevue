package com.clonevue.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.clonevue.entities.Users;
import com.clonevue.repositories.UsersRepository;

@Service
public class UserService implements UserDetailsService {
	@Autowired
	private UsersRepository usersRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		Users user = usersRepository.findByUsername(username);
		if (user == null) {
			throw new UsernameNotFoundException(username);
		} else {
			return new CustomUserDetails(user);
		}
	}
	
}
