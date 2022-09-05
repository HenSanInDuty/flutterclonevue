import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskProvider extends CalendarDataSource {
  List<Appointment> task = [];
  TaskProvider(List<Appointment> source) {
    appointments = source;
  }

  TaskProvider getDataSource() {
    return TaskProvider(task);
  }

  TaskProvider addDataSource(
      {startTime,
      endTime,
      isAllDay = true,
      subject = "New task",
      color = Colors.blue}) {
    Appointment appointments = Appointment(
      startTime: startTime ?? DateTime.now(),
      endTime: endTime ?? DateTime.now().add(Duration(hours: 1)),
      isAllDay: isAllDay,
      subject: subject,
      color: color,
      startTimeZone: '',
      endTimeZone: '',
    );
    task.add(appointments);
    //writeCounter(appointments);
    return TaskProvider(task);
  }

  void deleteDataSource(Appointment appointment){
    task.remove(appointment);
  }

  void deleteAll(){
    task = [];
  }
  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return directory.path;
  // }

  // Future<File> get _localFile async {
  //   final path = await _localPath;

  //   return File('$path/storagej.json');
  // }

  // Future<File> writeCounter(Appointment appointment) async {
  //   final file = await _localFile;
  //   //Read the file
  //   var storage = await file.readAsString();
  //   //Decode content to json
  //   var json = jsonDecode(storage);
  //   //If json is null
  //   json = json ?? [];
  //   json.add(appointment);
  //   return file.writeAsString(jsonEncode(json));
  // }

  // Future<dynamic> readCounter() async {
  //   try {
  //     final file = await _localFile;

  //     // Read the file
  //     final contents = await file.readAsString();
  //     final json = jsonDecode(contents);
  //     return json;
  //   } catch (e) {
  //     // If encountering an error, return 0
  //     return 0;
  //   }
  // }
}
