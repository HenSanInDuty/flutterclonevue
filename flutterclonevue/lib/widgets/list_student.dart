import 'package:flutter/material.dart';
import 'package:flutterclonevue/api/api_service.dart';


class ListStudent extends StatefulWidget {
  ListStudent({Key? key}) : super(key: key);

  @override
  State<ListStudent> createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  @override
  var api = ApiService();
  Widget build(BuildContext context) {
    getAllStudent();
    return Container();
  }

  void getAllStudent() async{
    print(await api.getAllStudent());
  }
}