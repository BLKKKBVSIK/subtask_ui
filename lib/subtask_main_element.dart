import 'dart:math';
import 'package:flutter/material.dart';

class SubTaskMainElement extends StatelessWidget {
  final String text;
  final Color? progressIndicatorColor;
  final int progress;
  final Color? tileBackgroundColor;
  final int goal;

  const SubTaskMainElement({
    Key? key,
    this.progressIndicatorColor,
    this.tileBackgroundColor,
    required this.text,
    required this.progress,
    required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = progress / goal * 100;

    return Container(
      decoration: BoxDecoration(
          color: tileBackgroundColor ?? const Color(0xFF1A1A28),
          borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.fromLTRB(30, 27, 30, 27),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Color(0xFFFCFCFC),
                  fontSize: 24,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                "$progress/$goal",
                style: const TextStyle(color: Color(0xFFFDFDFD), fontSize: 20)
                    .apply(color: progressIndicatorColor),
              )
            ],
          ),
          Stack(
            children: [
              SizedBox(
                  width: 70,
                  height: 70,
                  child: CustomPaint(
                    foregroundPainter: ProgressPainter(
                        progressColor:
                            progressIndicatorColor ?? const Color(0xFFFDFDFD),
                        percentage: percentage,
                        width: 9),
                  )),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top:
                                2), //add padding to center the font that has default bottom spacing
                        child: Text("${percentage.round()}%",
                            style: TextStyle(
                                    color: Color(0xFFFDFDFD), fontSize: 20)
                                .apply(
                                    color: progressIndicatorColor ??
                                        const Color(0xFFFDFDFD))),
                      ))),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  Color progressColor;
  double percentage;
  double width;

  ProgressPainter(
      {required this.progressColor,
      required this.percentage,
      required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = Color(0xFF0F0F12)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint progress = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, line);

    double arcAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, progress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
