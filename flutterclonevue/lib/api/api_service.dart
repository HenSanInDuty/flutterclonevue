import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterclonevue/api/constant.dart';
import 'package:flutterclonevue/models/student.dart';

class ApiService extends ChangeNotifier {
  final String baseUrl = "http://192.168.1.87:8000";

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'cookie': ''
  };

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      header['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  Future<bool> register(data) async {
    try {
      var url = Uri.parse("$baseUrl/register");
      var response =
          await http.post(url, body: jsonEncode(data), headers: header);
      if (response.statusCode == 200) {
        header['cookie'] = '';
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> login(data) async {
    try {
      var url = Uri.parse("$baseUrl/login");
      var response = await http.post(url,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        updateCookie(response);
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> checkLogin() async {
    try {
      var url = Uri.parse("$baseUrl/is-login");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> logout() async {
    var url = Uri.parse("$baseUrl/logout");
    await http.get(url);
    return true;
  }

  Future<List<Student>?> getAllStudent() async {
    try {
      var url = Uri.parse("$baseUrl/studentlist");
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        List<Student> studentList = studentFromJson(response.body);
        return studentList;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> addStudent(data) async {
    try {
      var url = Uri.parse("$baseUrl/addstudent");
      var response =
          await http.post(url, headers: header, body: jsonEncode(data));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> reassign(data) async {
    try {
      var url = Uri.parse("$baseUrl/assignteam");
      var response =
          await http.patch(url, headers: header, body: jsonEncode(data));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
