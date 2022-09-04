import 'package:flutter/material.dart';
import 'package:flutterclonevue/api/api_service.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  //Dialog property
  var textDialog = "";
  var _isShow = false;
  //Api
  var api = ApiService();
  var loading = false;

  final TEAMS = ['Team 1', 'Team 2', 'Team 3', 'Team 4'];

  var teamValue = 'Team 1';
  var gender = 'M';
  var namesController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text("Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                  decoration: const InputDecoration(hintText: "Enter name"),
                  controller: namesController),
              const SizedBox(
                height: 16,
              ),
              const Text("Email",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                  decoration: const InputDecoration(hintText: "Enter email"),
                  controller: emailController),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                height: 150,
                child: GridView.count(
                  primary: false,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Teams",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 4,
                        ),
                        DropdownButtonFormField(
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
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Gender",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 4,
                        ),
                        ListTile(
                            title: const Text('Male'),
                            leading: Radio<String>(
                              value: 'M',
                              groupValue: gender,
                              onChanged: (String? value) {
                                setState(() {
                                  gender = value ?? 'M';
                                });
                              },
                            )),
                        ListTile(
                            title: const Text('Female'),
                            leading: Radio<String>(
                              value: 'F',
                              groupValue: gender,
                              onChanged: (String? value) {
                                setState(() {
                                  gender = value ?? 'M';
                                });
                              },
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    var student = {
                      'name': namesController.text,
                      'email': emailController.text,
                      'teams': teamValue,
                      'gender': gender
                    };

                    var status = await api.addStudent(student);
                    if (status) {
                      namesController.text = '';
                      emailController.text = '';
                      teamValue = 'Team 1';
                      gender = 'M';
                      setState(() {
                        _isShow = true;
                        textDialog = "Them sinh vien thanh cong";
                        loading = false;
                      });
                    } else {
                      setState(() {
                        _isShow = true;
                        textDialog = "Them sinh vien that bai";
                        loading = false;
                      });
                    }

                    setState(() {});
                  },
                  child: loading
                      ? const Padding(
                          padding: EdgeInsets.all(4),
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                        )
                      : const Text('Add Student'))
            ],
          ),
        ),
        bottomSheet: _showBottomSheet(textDialog),
      ),
    );
  }

  Widget? _showBottomSheet(text) {
    if (_isShow) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(text),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _isShow = false;
                    setState(() {});
                  },
                  child: const Text("Close"),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return null;
    }
  }
}
