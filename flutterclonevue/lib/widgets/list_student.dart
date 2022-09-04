import 'package:flutter/material.dart';
import 'package:flutterclonevue/api/api_service.dart';
import 'package:flutterclonevue/models/student.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  State<ListStudent> createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  var api = ApiService();
  List<Student> listStudent = [];

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FixedColumnWidth(40),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FixedColumnWidth(64),
                4: FixedColumnWidth(64)
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                    decoration: const BoxDecoration(color: Colors.amber),
                    children: [
                      tableCellContainer('No', fontWeight: FontWeight.bold),
                      tableCellContainer('Name', fontWeight: FontWeight.bold),
                      tableCellContainer('Email', fontWeight: FontWeight.bold),
                      tableCellContainer('Teams', fontWeight: FontWeight.bold),
                      tableCellContainer('Gender', fontWeight: FontWeight.bold)
                    ]),
                for (var i = 0; i < listStudent.length; i++)
                  TableRow(children: [
                    tableCellContainer(listStudent[i].id.toString()),
                    tableCellContainer(listStudent[i].name),
                    tableCellContainer(listStudent[i].email),
                    tableCellContainer(listStudent[i].teams),
                    tableCellContainer(
                        listStudent[i].gender == 'M' ? 'Male' : 'Female'),
                  ])
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tableCellContainer(String text,
      {FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        child: Text(
          text,
          style: TextStyle(fontWeight: fontWeight),
        ),
      ),
    );
  }

  void getAllStudent() async {
    listStudent = await api.getAllStudent() ?? [];
    setState(() {});
  }
}
