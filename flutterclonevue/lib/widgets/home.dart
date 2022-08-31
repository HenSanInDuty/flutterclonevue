import 'package:flutter/material.dart';
import 'package:flutterclonevue/api/api_service.dart';
import 'package:flutterclonevue/widgets/list_student.dart';
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

  var routes = "";

  Widget bodyWidget() {
    switch (routes) {
      case "List_Student":
        return ListStudent();
      default:
        return SfCalendar(
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
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<LoginProvider>(
      builder: (_, loginProvider, __) {
        return Scaffold(
            key: _key,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _key.currentState!.openDrawer();
                },
              ),
              title: Text("Calender"),
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
            body: bodyWidget());
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
    ;
  }

  void changeView(view){
    setState(() {
      routes = view;
    });
    _key.currentState!.closeDrawer();
  }

  void loginHandle(loginProvider) async {
    var api = ApiService();
    await api.logout();
    loginProvider.changeHomePathToLogin();
    Navigator.pushNamed(context, '/');
  }
}
