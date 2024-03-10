import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class Linkbutton extends StatefulWidget {
  final IconData iconData;
  final String title;
  final String url;
  final VoidCallback onTap;
  const Linkbutton(
      {super.key,
      required this.iconData,
      required this.onTap,
      required this.url,
      required this.title});

  @override
  State<Linkbutton> createState() => _AnimatedContentState();
}

class _AnimatedContentState extends State<Linkbutton> {
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
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: isHovering ? Colors.grey.shade300 : Vx.white,
                border:
                    Border.all(color: isHovering ? Colors.grey : Colors.white),
                borderRadius: BorderRadius.circular(12.0)),
            child: Row(
              children: [
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FaIcon(
                    widget.iconData,
                    size: 20,
                  ),
                )),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.url,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
