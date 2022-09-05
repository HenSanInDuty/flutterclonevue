import 'package:flutter/material.dart';
import 'package:flutterclonevue/api/api_service.dart';
import 'package:flutterclonevue/models/student.dart';

class ListRemoveStudent extends StatefulWidget {
  const ListRemoveStudent({Key? key}) : super(key: key);

  @override
  State<ListRemoveStudent> createState() => _ListRemoveStudentState();
}

class _ListRemoveStudentState extends State<ListRemoveStudent> {
  var api = ApiService();
  List<Student> listStudent = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var gender = "A";
  @override
  Widget build(BuildContext context) {
    getAllStudent();
    final heights = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: heights / 3,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search by name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(hintText: "Enter the name"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Search by email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration:
                        const InputDecoration(hintText: "Enter the email"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Gender",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  RadioListTile(
                      value: "M",
                      groupValue: gender,
                      title: Text("Male"),
                      onChanged: (String? value) {
                        setState(() {
                          
                        gender = value ?? "A";
                        });
                      }),
                      RadioListTile(
                      value: "F",
                      groupValue: gender,
                      title: Text("Female"),
                      onChanged: (String? value) {
                        setState(() {
                        gender = value ?? "A";
                        });
                      }),
                      RadioListTile(
                      value: "A",
                      groupValue: gender,
                      title: Text("All"),
                      onChanged: (String? value) {
                        setState(() {
                        gender = value ?? "A";
                        });
                      }),
                ],
              )),
            ),
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
                      tableCellContainer('Gender', fontWeight: FontWeight.bold),
                      tableCellContainer('Action', fontWeight: FontWeight.bold),
                    ]),
                for (var i = 0; i < listStudent.length; i++)
                  TableRow(children: [
                    tableCellContainer(listStudent[i].id.toString()),
                    tableCellContainer(listStudent[i].name.trim()),
                    tableCellContainer(listStudent[i].email.trim()),
                    tableCellContainer(listStudent[i].teams.trim()),
                    tableCellContainer(
                        listStudent[i].gender == 'M' ? 'Male' : 'Female'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () async {
                          var ok = await api.deleteStudent(listStudent[i].id);
                          if (ok) {
                            setState() {}
                            ;
                          }
                        },
                      ),
                    )
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
        //height: 40,
        child: Text(
          text,
          style: TextStyle(fontWeight: fontWeight),
        ),
      ),
    );
  }

  void getAllStudent() async {
    var rawListStudent = await api.getAllStudent() ?? [];
    listStudent = rawListStudent.where((e) => e.gender==gender|| gender=='A').toList();
    if (nameController.text!=""){
      listStudent = listStudent.where((e) => e.name.toLowerCase().contains(nameController.text.toLowerCase())).toList();
    }
    if (emailController.text!=""){
      listStudent = listStudent.where((e) => e.email.toLowerCase().contains(emailController.text.toLowerCase())).toList();
    }
    setState(() {});
  }
}
