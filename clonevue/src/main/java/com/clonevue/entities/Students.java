package com.clonevue.entities;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="students")
public class Students {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	private String email;
	private char gender;
	private String teams;
	
	
	
	public Students() {
		super();
	}
	public Students(int id, String name, String email, char gender, String teams) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.teams = teams;
	}
	
	public Students(String name, String email, char gender, String teams) {
		super();
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.teams = teams;
	}
	public int getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	public String getTeams() {
		return teams;
	}
	public void setTeams(String teams) {
		this.teams = teams;
	}
	@Override
	public String toString() {
		return "Students [id=" + id + ", name=" + name + ", email=" + email + ", gender=" + gender + ", teams=" + teams
				+ "]";
	}
	
	
}
