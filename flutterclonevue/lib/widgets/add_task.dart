import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutterclonevue/provider/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../api/api_service.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var api = ApiService();

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  var nameController = TextEditingController();
  var startDay = DateTime.now();
  var endDay = DateTime.now();
  var startTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  var endTime = TimeOfDay(
      hour: DateTime.now().add(const Duration(hours: 1)).hour,
      minute: DateTime.now().minute);


  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void reinitVar() {
    pickerColor = Color(0xff443a49);
    currentColor = Color(0xff443a49);
    nameController.text = "";
    startDay = DateTime.now();
    endDay = DateTime.now();
    startTime =
        TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    endTime = TimeOfDay(
        hour: DateTime.now().add(const Duration(hours: 1)).hour,
        minute: DateTime.now().minute);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer<TaskProvider>(builder: (_, taskProvider, __) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height / 4,
              child: Card(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "New Task",
                          suffix: SizedBox(
                            width: width / 3,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width / 20,
                                ),
                                IconButton(
                                  icon: Icon(Icons.calendar_month),
                                  onPressed: () {
                                    setState(() {
                                      showDialog(
                                        context: context,
                                        builder: (contexts) {
                                          return AlertDialog(
                                            title: const Text('Choose Time'),
                                            content: StatefulBuilder(
                                                builder: (context, setState) {
                                              return SingleChildScrollView(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      const Text("Start day"),
                                                      DropdownButton<DateTime>(
                                                          hint: const Text(
                                                              'Start Day'),
                                                          items: [startDay]
                                                              .map((e) => DropdownMenuItem<
                                                                      DateTime>(
                                                                  child: Text(
                                                                      DateFormat(
                                                                              'MM/dd/yyyy')
                                                                          .format(
                                                                              e))))
                                                              .toList(),
                                                          onChanged: (value) {
                                                            showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            2001),
                                                                    lastDate:
                                                                        DateTime(
                                                                            2099))
                                                                .then((date) {
                                                              setState(() {
                                                                startDay = date ??
                                                                    DateTime
                                                                        .now();
                                                                endDay = startDay
                                                                        .isAfter(
                                                                            endDay)
                                                                    ? startDay
                                                                    : endDay;
                                                              });
                                                            });
                                                          }),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      Text("End day"),
                                                      DropdownButton<DateTime>(
                                                          hint: const Text(
                                                              'End Day'),
                                                          items: [endDay]
                                                              .map((e) => DropdownMenuItem<
                                                                      DateTime>(
                                                                  child: Text(
                                                                      DateFormat(
                                                                              'MM/dd/yyyy')
                                                                          .format(
                                                                              e))))
                                                              .toList(),
                                                          onChanged: (value) {
                                                            showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            2001),
                                                                    lastDate:
                                                                        DateTime(
                                                                            2099))
                                                                .then((date) {
                                                              setState(() {
                                                                endDay = date ??
                                                                    DateTime
                                                                        .now();
                                                              });
                                                            });
                                                          }),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      Text("Start time"),
                                                      DropdownButton<TimeOfDay>(
                                                          hint: const Text(
                                                              'Start Time'),
                                                          items: [startTime]
                                                              .map((e) => DropdownMenuItem<
                                                                      TimeOfDay>(
                                                                  child: Text(
                                                                      e.format(
                                                                          context))))
                                                              .toList(),
                                                          onChanged: (value) {
                                                            showTimePicker(
                                                                    context:
                                                                        contexts,
                                                                    initialTime:
                                                                        startTime)
                                                                .then((time) {
                                                              setState(() {
                                                                startTime =
                                                                    time ??
                                                                        startTime;
                                                                if (startTime
                                                                        .hour >
                                                                    endTime
                                                                        .hour) {
                                                                  endTime =
                                                                      startTime;
                                                                } else if (startTime
                                                                        .hour ==
                                                                    endTime
                                                                        .hour) {
                                                                  if (startTime
                                                                          .minute >
                                                                      endTime
                                                                          .minute) {
                                                                    endTime =
                                                                        startTime;
                                                                  }
                                                                }
                                                              });
                                                            });
                                                          }),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      Text("End time"),
                                                      DropdownButton<TimeOfDay>(
                                                          hint: const Text(
                                                              'Start Time'),
                                                          items: [endTime]
                                                              .map((e) => DropdownMenuItem<
                                                                      TimeOfDay>(
                                                                  child: Text(
                                                                      e.format(
                                                                          context))))
                                                              .toList(),
                                                          onChanged: (value) {
                                                            showTimePicker(
                                                                    context:
                                                                        contexts,
                                                                    initialTime:
                                                                        endTime)
                                                                .then((time) {
                                                              setState(() {
                                                                endTime = time ??
                                                                    endTime;
                                                              });
                                                            });
                                                          }),
                                                    ]),
                                              );
                                            }),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: const Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.color_lens),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Pick a color!'),
                                          content: SingleChildScrollView(
                                            child: ColorPicker(
                                              pickerColor: pickerColor,
                                              onColorChanged: changeColor,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: const Text('Got it'),
                                              onPressed: () {
                                                setState(() =>
                                                    currentColor = pickerColor);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          )),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          startDay = DateTime(startDay.year, startDay.month,
                              startDay.day, startTime.hour, startTime.minute);
                          endDay = DateTime(endDay.year, endDay.month, endDay.day,
                              endTime.hour, endTime.minute);
                          taskProvider.addDataSource(
                              color: currentColor,
                              startTime: startDay,
                              endTime: endDay,
                              subject: nameController.text,
                              isAllDay: false);
                          reinitVar();
                          setState(() {
                            
                          });
                        },
                        child: Text("Add"))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: height/2.2,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              child: ListView.builder(
                itemCount: taskProvider.task.length,
                itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Card(
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            child: ListTile(
                              title: Text(taskProvider.task[index].subject),
                              trailing: IconButton(icon: Icon(Icons.cancel_outlined),onPressed:(
                                
                              ){
                                taskProvider.deleteDataSource(taskProvider.task[index]);
                                setState(() {
                                  
                                });
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4,)
                      ],
                    );
                  },
      
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton.icon(onPressed: (){
              taskProvider.deleteAll();
              setState(() {
                
              });
            }, icon: Icon(Icons.check), label: Text("Clear all"))
          ],
        ),
      );
    });
  }
}
