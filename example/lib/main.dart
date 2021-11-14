import 'package:example/main_element.dart';
import 'package:flutter/material.dart';
import 'package:subtask_ui/subtasks.dart';
import 'package:subtask_ui/subtasks_item.dart';

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
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SubTasks(
                  mainElement: MainElement(
                    color: Colors.green,
                    goal: 5,
                    name: "Example",
                    progress: 2,
                  ),
                  topTree: const [
                    SubTaskItem(
                      name: "Un texte plus long",
                      completed: true,
                    ),
                    SubTaskItem(
                      name: "Task3",
                      completed: true,
                    ),
                    SubTaskItem(
                      name:
                          "Task4 with a lot of text too and even much text is bigger etc etc etc",
                      completed: true,
                    ),
                    SubTaskItem(
                      name: "Task4 with very long text and much more details",
                      completed: true,
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
