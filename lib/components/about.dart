import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/model/user.dart';
import 'package:portfolio/utilis/animatedContent.dart';
import 'package:portfolio/utilis/social.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class About extends StatefulWidget {
  UserModel user;
  About({super.key, required this.user});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenWidth < 900
          ? 650
          : context.screenWidth > 1200
              ? 600
              : 700,
      margin: const EdgeInsets.only(top: 20),
      width: context.screenWidth < 900
          ? context.screenWidth * 0.9
          : context.screenWidth * 0.4,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          Image.asset(
            widget.user.img.isEmpty ? "assets/user.png" : '',
            height: 156,
          ),
          Text(widget.user.name.isEmpty ? 'New user' : widget.user.name,
              style:
                  const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600)),
          Text(
            widget.user.desc.isEmpty
                ? 'I am beginner developer and newly joined with it.'
                : widget.user.desc,
            textAlign: TextAlign.center,
          ),
          Wrap(
              spacing: 10.0,
              runSpacing: 6.0,
              alignment: WrapAlignment.center,
              children: widget.user.roles.isEmpty
                  ? []
                  : List.generate(
                      widget.user.roles.length,
                      (index) => Chip(
                            label: Text(widget.user.roles[index]),
                            backgroundColor: Vx.purple400,
                            padding: const EdgeInsets.all(8.0),
                            labelStyle: const TextStyle(
                                color: Colors.white, fontSize: 14.0),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Vx.purple400),
                                borderRadius: BorderRadius.circular(20)),
                          ))),
          const Divider(),
          AnimatedContent(
            iconData: FontAwesomeIcons.linkedin,
            
            title: "LinkedIn",
            subTitle: widget.user.linkedin.isEmpty
                ? 'Linkedin.in'
                : widget.user.linkedin,
            onTap: () {},
          ),
          AnimatedContent(
            iconData: FontAwesomeIcons.github,
            title: "Githup",
            subTitle: widget.user.githubId.isEmpty
                ? 'githup://hup/account'
                : widget.user.githubId,
            onTap: () {},
          ),
          const Spacer(),
          SocialRow(
            facebook: widget.user.facebook.isEmpty
                ? 'https://www.facebook.com/'
                : widget.user.facebook,
            instagram: widget.user.instagram.isEmpty
                ? 'https://www.instagram.com/'
                : widget.user.instagram,
            github: widget.user.githubId.isEmpty
                ? 'https://github.com/'
                : widget.user.githubId,
          )
        ]),
      ),
    );
  }
}
