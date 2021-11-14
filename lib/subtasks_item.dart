import 'package:flutter/material.dart';

class SubTaskItem extends StatelessWidget {
  final String name;
  final bool completed;
  const SubTaskItem({
    Key? key,
    required this.name,
    required this.completed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 11.5),
      child: Container(
        padding: const EdgeInsets.only(right: 24),
        color: Color(0xFF0F0F12).withOpacity(.3),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
                color: Color(0xFF1A1A28).withOpacity(.4),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 130),
                  child: Text(
                    name,
                    style: TextStyle(color: Color(0xFFFBFBFB), fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                if (completed)
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: Color(0xFFFBFBFB),
                  )
              ],
            )),
      ),
    );
  }
}
