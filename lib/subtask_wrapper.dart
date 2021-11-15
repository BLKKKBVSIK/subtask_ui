import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:subtask_ui/subtasks_viewmodel.dart';

class SubtaskWrapper extends StatelessWidget {
  final Widget child;
  final Function onChange;
  final SubTasksViewModel model;

  SubtaskWrapper({
    Key? key,
    required this.onChange,
    required this.model,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback(postFrameCallback);

    return Container(
      key: widgetKey,
      child: child,
    );
  }

  GlobalKey widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(_) {
    BuildContext? context = widgetKey.currentContext;
    if (context == null) return;

    Size? newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    onChange(newSize, model);
  }
}
