import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/model/projectModel.dart';
import 'package:portfolio/utilis/links.dart';
import 'package:velocity_x/velocity_x.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          const Text("Project Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(project.url), fit: BoxFit.cover)),
          ),
          Text(
            project.title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Vx.purple400),
          ),
          Text(
            project.description,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Linkbutton(
              iconData: FontAwesomeIcons.github,
              onTap: () {},
              url: project.giturl,
              title: project.title)
        ],
      ),
    ));
  }
}
