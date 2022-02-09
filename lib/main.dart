import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences sharedPreferences;
  List<Task> taskList = [];

  @override
  void initState() {
    initSharedPreferenses();
    super.initState();
  }

  initSharedPreferenses() async {
    sharedPreferences = await SharedPreferences.getInstance();
    readData();
  }

  @override
  void dispose() {
    taskList.forEach((e) {
      e.taskFocusNode?.dispose();
      e.taskController?.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topTitleText(),
                plusButton(),
              ],
            ),
            topUnderline(),
            taskBuilder(),
          ],
        ),
      ),
    );
  }

  Widget topTitleText() {
    return Text('Tasks',
        style: GoogleFonts.inter(
            fontSize: 54, fontWeight: FontWeight.w800, color: Colors.black));
  }

  Widget plusButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          taskList.insert(
              0,
              Task(
                  taskFocusNode: FocusNode(),
                  taskController: TextEditingController()));
        });
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          FocusScope.of(context).requestFocus(taskList[0].taskFocusNode);
        });
      },
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xffF2F3FF),
          border: Border.all(width: 1, color: const Color(0xffEBEBEB)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(
          Icons.add_rounded,
          size: 40,
          color: Color(0xff575767),
        ),
      ),
    );
  }

  Widget topUnderline() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      height: 1,
      color: const Color(0xffEBEBEB),
    );
  }

  

  void setCompletness(Task task) {
    task.isCompleted = !task.isCompleted;
  }

  void saveData() {
    List<String> taskListJson =
        taskList.map((e) => jsonEncode(e.toJson())).toList();
    sharedPreferences.setStringList('taskListJson', taskListJson);
  }

  void readData() {
    var taskListJson = sharedPreferences.getStringList('taskListJson');
    if (taskListJson != null) {
      taskList = taskListJson.map((e) => Task.fromJson(jsonDecode(e))).toList();
      setState(() {});
    }
  }
}
