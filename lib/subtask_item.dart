import 'package:flutter/material.dart';

class SubTaskItem extends StatelessWidget {
  final String text;
  final Color? taskItemBackgroundColor;
  final double? taskItemBorderRadius;
  final TextStyle? taskItemTextStyle;
  final double? taskItemVerticalPadding;
  const SubTaskItem({
    Key? key,
    this.taskItemBackgroundColor,
    this.taskItemBorderRadius,
    this.taskItemTextStyle,
    this.taskItemVerticalPadding,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: taskItemVerticalPadding ?? 12),
      child: Container(
        padding: const EdgeInsets.only(right: 24),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
                color: taskItemBackgroundColor ?? const Color(0xFF1A1A28),
                borderRadius:
                    BorderRadius.circular(taskItemBorderRadius ?? 12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 130),
                  child: Text(
                    text,
                    style: taskItemTextStyle ??
                        const TextStyle(color: Color(0xFFFBFBFB), fontSize: 20),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
