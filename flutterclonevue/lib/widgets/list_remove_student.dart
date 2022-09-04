import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutterclonevue/widgets/list_student.dart';

class ListRemoveStudent extends StatefulWidget {
  const ListRemoveStudent({Key? key}) : super(key: key);

  @override
  State<ListRemoveStudent> createState() => _ListRemoveStudentState();
}

class _ListRemoveStudentState extends State<ListRemoveStudent> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [ListStudent()]);
  }
}
