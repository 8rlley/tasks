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
  List<TextEditingController> taskContrtollerList = [];
  late FocusNode newTaskFocusNode;

  List<Task> taskList = [];

  @override
  void initState() {
    newTaskFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskList.forEach((e) {
            print('${e.title},${e.isCompleted}');
          });
        },
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tasks',
                    style: GoogleFonts.inter(
                        fontSize: 54,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
                GestureDetector(
                  onTap: () {
                    taskList.insert(0, Task(title: ''));
                    taskContrtollerList.insert(0, TextEditingController());
                    setState(() {});
                  },
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F3FF),
                      border:
                          Border.all(width: 1, color: const Color(0xffEBEBEB)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      size: 40,
                      color: Color(0xff575767),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              height: 1,
              color: const Color(0xffEBEBEB),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      // taskList[index].title = taskContrtollerList[index].text;
                      return Row(
                        children: [
                          Checkbox(
                              value: taskList[index].isCompleted,
                              onChanged: (_) {
                                setState(() {
                                  taskList[index].isCompleted =
                                      !taskList[index].isCompleted;
                                });
                              }),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextField(
                              controller: taskContrtollerList[index],
                              // autofocus: taskContrtollerList[index] == 0
                              //     ? true
                              //     : false,
                              onSubmitted: (value) => setState(() {
                                taskList[index].title = value;
                              }),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: taskList[index].title),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
