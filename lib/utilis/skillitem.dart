import 'package:flutter/material.dart';

class AddSkill extends StatelessWidget {
  final String name;
  final Color color;
  const AddSkill({super.key, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.white,
      label: Text(name),
      labelStyle: TextStyle(color: color, fontSize: 12),
      side: BorderSide(color: color),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
