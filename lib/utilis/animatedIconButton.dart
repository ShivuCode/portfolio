import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class AnimatedIconButton extends StatefulWidget {
  final IconData iconData;

  final VoidCallback onTap;
  const AnimatedIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedContentState();
}

class _AnimatedContentState extends State<AnimatedIconButton> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
          onTap: () {},
          onHover: (value) => setState(() {
                isHovering = value;
              }),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                color: isHovering ? Colors.grey.shade300 : Vx.white,
                border:
                    Border.all(color: isHovering ? Colors.grey : Colors.white),
                borderRadius: BorderRadius.circular(12.0)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FaIcon(
                    widget.iconData,
                    size: 20,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
