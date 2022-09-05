import 'package:flutter/material.dart';
import 'package:flutterclonevue/api/api_service.dart';
import 'package:flutterclonevue/provider/task_provider.dart';
import 'package:flutterclonevue/widgets/add_student.dart';
import 'package:flutterclonevue/widgets/add_task.dart';
import 'package:flutterclonevue/widgets/list_remove_student.dart';
import 'package:flutterclonevue/widgets/list_student.dart';
import 'package:flutterclonevue/widgets/reassign_student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../provider/login_provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var api;
  var routes = "";
  var title = "";

  //Change view
  Widget bodyWidget(provider) {
    switch (routes) {
      case "List_Student":
        return ListRemoveStudent();
      case "Add_Student":
        return AddStudent();
      case "Reassign_Team":
        return ReassignStudent();
      case "Add_Task":
        return AddTask();
      default:
        //Calender
        return SfCalendar(
          dataSource: provider.getDataSource(),
          monthViewSettings: const MonthViewSettings(showAgenda: true),
          allowedViews: const [
            CalendarView.day,
            CalendarView.week,
            CalendarView.month,
          ],
        );
    }
  }

  @override
  void initState() {
    routes = "Calender";
    title = "Calender";
    api = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer2<LoginProvider, TaskProvider>(
      builder: (_, loginProvider, taskProvider, __) {
        return Scaffold(
            key: _key,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () async {
                  _key.currentState!.openDrawer();
                },
              ),
              title: Text(loginProvider.title),
            ),
            drawer: Drawer(
              width: width / 2,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Calender",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      btnDrawer("Calender", Icon(Icons.calendar_month), () {
                        changeView("Calender");
                        loginProvider.changeTitle("Calender");
                      }),
                      const SizedBox(
                        height: 8,
                      ),
                      btnDrawer("Add Task", Icon(Icons.add_task_rounded), () {
                        changeView("Add_Task");
                        loginProvider.changeTitle("Add Task");
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Student",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      btnDrawer("List Student", Icon(Icons.person), () {
                        changeView("List_Student");
                        loginProvider.changeTitle("List Student");
                      }),
                      const SizedBox(
                        height: 8,
                      ),
                      btnDrawer("Add Student", Icon(Icons.person_add), () {
                        changeView("Add_Student");
                        loginProvider.changeTitle("Add Student");
                      }),
                      const SizedBox(
                        height: 8,
                      ),
                      btnDrawer("Reassign Team", Icon(Icons.person_off), () {
                        changeView("Reassign_Team");
                        loginProvider.changeTitle("Reassign Student Team");
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "User",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      btnDrawer("Logout", Icon(Icons.logout), () {
                        loginHandle(loginProvider);
                      }),
                    ]),
              ),
            ),
            body: bodyWidget(taskProvider));
      },
    );
  }

  Widget btnDrawer(text, icon, fn) {
    return Container(
      height: 40,
      width: double.maxFinite,
      child: OutlinedButton.icon(
          onPressed: fn,
          label: Text(text),
          icon: icon,
          style: OutlinedButton.styleFrom(alignment: Alignment.centerLeft)),
    );
  }

  void changeView(view) {
    setState(() {
      routes = view;
    });
    _key.currentState!.closeDrawer();
  }

  void loginHandle(loginProvider) async {
    await api.logout();
    loginProvider.changeHomePathToLogin();
    Navigator.pushNamed(context, '/');
  }
}
