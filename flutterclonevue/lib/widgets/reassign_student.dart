import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutterclonevue/widgets/list_student.dart';

import '../api/api_service.dart';

class ReassignStudent extends StatefulWidget {
  const ReassignStudent({Key? key}) : super(key: key);

  @override
  State<ReassignStudent> createState() => _ReassignStudentState();
}

class _ReassignStudentState extends State<ReassignStudent> {
  final TEAMS = ['Team 1', 'Team 2', 'Team 3', 'Team 4'];

  var teamValue = 'Team 1';
  var nameController = TextEditingController();

  var api = ApiService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //Form
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("List Student",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          width: double.infinity,
          height: height / 2,
          child: const ListStudent(),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Reassgin Team",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Text("Student id", style: TextStyle(fontSize: 16)),
        ),
        widgetWithPadding(TextFormField(
          controller: nameController,
          decoration:
              const InputDecoration(hintText: "Enter the id of student"),
        )),
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Text("Team reassign", style: TextStyle(fontSize: 16)),
        ),
        widgetWithPadding(DropdownButtonFormField(
          value: teamValue,
          onChanged: (String? value) {
            setState(() {
              teamValue = value ?? 'Team 1';
            });
          },
          items: [
            for (var team in TEAMS)
              DropdownMenuItem(
                value: team,
                child: Text(team),
              )
          ],
        )),
        widgetWithPadding(ElevatedButton(
            onPressed: () async {
              var data = {'id': nameController.text, 'team': teamValue};

              var signal = await api.reassign(data);
              if (signal) {
                nameController.text = '';
              }
            },
            child: Text("Reassign")))
      ]),
    );
  }

  Widget widgetWithPadding(child) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: child,
    );
  }
}
