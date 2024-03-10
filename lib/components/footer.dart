import 'package:flutter/material.dart';
import 'package:portfolio/utilis/social.dart';

// ignore: must_be_immutable
class Footer extends StatelessWidget {
  String facebook;
  String instagram;
  String github;
  Footer(
      {super.key,
      required this.facebook,
      required this.instagram,
      required this.github});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Column(children: [
        SocialRow(facebook: facebook, instagram: instagram, github: github),
        const Text("Flutter Developer"),
        const Text(
          "Shivani bind",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
        )
      ]),
    );
  }
}
