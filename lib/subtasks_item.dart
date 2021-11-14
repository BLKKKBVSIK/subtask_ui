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
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
                color: Color(0xFF1A1A28),
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
              ],
            )),
      ),
    );
  }
}
