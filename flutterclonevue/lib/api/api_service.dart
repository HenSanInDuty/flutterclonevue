import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterclonevue/api/constant.dart';
import 'package:flutterclonevue/models/student.dart';

class ApiService{

  Future<bool> login(data) async{
    try{
      var url = Uri.parse("http://10.32.61.5:8000/login");
      var response = await http.post(url,
      body:jsonEncode(data),
      headers:<String,String> {
        'Content-Type':'application/json; charset=UTF-8'
      });
      if (response.statusCode == 200){
        return true;
      }
    } catch(e){
      log(e.toString());
    }
    return false;
  }

  Future<List<Student>?> getAllStudent() async {
    try{
       var url = Uri.parse("http://10.32.61.5:8000/studentlist");
       var response = await http.get(url);
       if (response.statusCode == 200){
        List<Student> studentList = studentFromJson(response.body);
        return studentList;
       }
    } catch(e) {
      log(e.toString());
    }
    return null;
  }
}
