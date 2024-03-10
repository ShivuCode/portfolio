import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utilis/animatedIconButton.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SocialRow extends StatelessWidget {
  String facebook;
  String instagram;
  String github;
  SocialRow(
      {super.key,
      required this.facebook,
      required this.instagram,
      required this.github});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedIconButton(
          iconData: FontAwesomeIcons.facebook,
          onTap: () async {
            if (await canLaunch(facebook)) {
              // ignore: deprecated_member_use
              await launch(facebook);
            } else {
              throw 'Could not launch $facebook';
            }
          },
        ),
        AnimatedIconButton(
          iconData: FontAwesomeIcons.instagram,
          onTap: () async {
            if (await launchUrl(Uri.parse(facebook))) {
              print('Could not launch $facebook');
              // Or show a message to the user
            }
          },
        ),
        AnimatedIconButton(
          iconData: FontAwesomeIcons.github,
          onTap: () async {
            if (await launchUrl(Uri.parse(github))) {
              throw Exception('Could not launch $github');
            }
          },
        ),
      ],
    );
  }
}
