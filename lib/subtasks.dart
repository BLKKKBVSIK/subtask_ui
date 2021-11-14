library subtask_ui;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:subtask_ui/subtasks_item.dart';
import 'package:subtask_ui/subtasks_viewmodel.dart';

class SubTasks extends StatelessWidget {
  SubTasks({
    Key? key,
    this.topTree,
    this.bottomTree,
    this.lineColor,
    required this.mainElement,
  }) : super(key: key);

  final List<SubTaskItem>? topTree;
  final List<SubTaskItem>? bottomTree;
  final Widget mainElement;
  final Color? subTaskItemBackgroundColor = Color(0xFF1A1A28);
  final Color? lineColor;
  final double lineWidth = 5;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubTasksViewModel>.reactive(
      viewModelBuilder: () => SubTasksViewModel(),
      onModelReady: (model) => model.initialize(
        topChildren: topTree,
        bottomChildren: bottomTree,
        mainElement: mainElement,
      ),
      builder: (context, model, child) => Column(
        children: [
          CustomPaint(
            painter: TreePainter(
              topTree: topTree,
              //bottomTree: bottomTree,
              model: model,
              lineColor: lineColor,
              lineWidth: lineWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <SubtaskWrapper>[
                ...model.topTree,
                model.mainElement,
                //...model.bottomTree,
              ],
            ),
          )
        ],
      ),
    );
  }
}

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

class TreePainter extends CustomPainter {
  final List<Widget>? topTree;
  final List<Widget>? bottomTree;
  final SubTasksViewModel model;
  final Color? lineColor;
  final double lineWidth;

  TreePainter({
    this.bottomTree,
    this.topTree,
    this.lineColor,
    required this.lineWidth,
    required this.model,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor ?? const Color(0xFFFBFBFB) // Line Color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    double degToRad(num deg) => deg * (pi / 180.0);

    double rectSize = 50; // Arrondi angle
    double currentHeight = 0;
    double currentWidth = size.width - 45; // Emplacement barre blanche

    Path path = Path();
    double savedHeight = 0;

    void drawBottomTree() {
      savedHeight = currentHeight + model.mainElementSize.height - 12;
      currentHeight = savedHeight;
      path.moveTo(currentWidth, savedHeight);

      if (model.bottomSizeList.isNotEmpty) {
        for (var i = 0; i < model.bottomTree.length; i++) {
          if (i == 0) {
            print(model.bottomSizeList.elementAt(i).height);
            currentHeight += model.bottomSizeList.elementAt(i).height / 2;
          } else {
            savedHeight += model.bottomSizeList.elementAt(i - 1).height;
            currentHeight =
                savedHeight + model.bottomSizeList.elementAt(i).height / 2;
          }

          path.arcTo(
            Rect.fromLTWH(
                currentWidth - rectSize - 0.15,
                currentHeight,
                rectSize, // -0.15 just for pixel perfect
                rectSize),
            degToRad(0),
            degToRad(90),
            false,
          );

          path.lineTo(20, currentHeight + rectSize);
          path.moveTo(currentWidth, currentHeight);

          //Go to next position
          if (i != model.topTree.length - 1) {
            currentHeight += model.bottomSizeList.elementAt(i).height + 20;
          }
        }
      }
    }

    void drawTopTree() {
      currentHeight =
          model.topSizeList.isEmpty ? 0 : model.topSizeList.last.height;

      if (model.topSizeList.isNotEmpty) {
        for (var i = 0; i < model.topTree.length; i++) {
          currentHeight = 0;

          if (i == 0) {
            currentHeight += model.topSizeList.elementAt(i).height / 2;
          } else {
            savedHeight += model.topSizeList.elementAt(i - 1).height;
            currentHeight =
                savedHeight + model.topSizeList.elementAt(i).height / 2;
            if (i == model.topSizeList.length - 1) {
              savedHeight += model.topSizeList.elementAt(i).height;
            }
          }

          path.moveTo(model.topSizeList.elementAt(i).width - 10, currentHeight);
          path.lineTo(currentWidth - 25, currentHeight);

          path.arcTo(
              Rect.fromLTWH(
                  currentWidth - rectSize - 0.15,
                  currentHeight,
                  rectSize, // -0.15 just for pixel perfect
                  rectSize),
              degToRad(-90),
              degToRad(90),
              false);

          if (i != model.topTree.length - 1) {
            currentHeight += model.topSizeList.elementAt(i).height + 30;
          }

          path.lineTo(currentWidth + 0.15, currentHeight + rectSize);
        }
      }
    }

    drawTopTree();
    drawBottomTree();

    //Draw the tree
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant TreePainter oldDelegate) {
    return false;
  }
}
