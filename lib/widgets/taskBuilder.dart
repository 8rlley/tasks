
import 'package:flutter/material.dart';

Widget taskBuilder() {
    return Flexible(
      child: SingleChildScrollView(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Checkbox(
                      value: taskList[index].isCompleted,
                      onChanged: (_) {
                        setState(() {
                          setCompletness(taskList[index]);
                        });
                      }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      focusNode: taskList[index].taskFocusNode,
                      controller: taskList[index].taskController,
                      onSubmitted: (value) => setState(() {
                        taskList[index].title = value;
                        saveData();
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
    );
  }