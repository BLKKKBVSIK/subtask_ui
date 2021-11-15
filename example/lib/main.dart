import 'package:flutter/material.dart';
import 'package:subtask_ui/subtasks.dart';
import 'package:subtask_ui/subtask_item.dart';
import 'package:subtask_ui/subtask_main_element.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SubTasks(
                  lineColor: Colors.orange,
                  mainElement: SubTaskMainElement(
                    progressIndicatorColor: Colors.green,
                    goal: 5,
                    progress: 2,
                    text: "Example",
                  ),
                  topTree: [
                    SubTaskItem(
                      text: "First task",
                    ),
                    SubTaskItem(
                      text: "Second task with a longer text",
                    ),
                    SubTaskItem(
                      text: "A really long task that takes more than 4 lines",
                    ),
                    SubTaskItem(
                      text: "Just another task",
                    ),
                  ],
                  //bottomTree: [],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
