import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/database/projectService.dart';
import 'package:portfolio/model/projectModel.dart';

import 'package:portfolio/utilis/addProject.dart';
import 'package:velocity_x/velocity_x.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  List<Project> projects = [];
  final formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController(),
      desc = TextEditingController(),
      url = TextEditingController(),
      giturl = TextEditingController();
  fetch() async {
    final data = await ProjectService.getAllProjects(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      projects = data;
    });
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth < 900 ? 20.0 : 35, vertical: 10),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "My Projects",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if (await ProjectService.deleteAllProjects(FirebaseAuth.instance.currentUser!.uid)) {
                          // ignore: use_build_context_synchronously
                          toast(context, "Deleted");
                          fetch();
                        } else {
                          // ignore: use_build_context_synchronously
                          toast(context, "Try again");
                        }
                      },
                      tooltip: "Delete All",
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.grey,
                      ))
                ],
              )),
          Wrap(
              runSpacing: 20,
              spacing: 20,
              children: projects.isEmpty
                  ? [showForm()]
                  : List.generate(projects.length, (index) {
                      if (index == projects.length - 1) {
                        return Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          children: [
                            AddProject(
                              projectName: projects[index].title,
                              description: projects[index].description,
                              url: projects[index].url,
                              giturl: projects[index].giturl,
                            ),
                            showForm()
                          ],
                        );
                      } else {
                        return AddProject(
                          projectName: projects[index].title,
                          description: projects[index].description,
                          url: projects[index].url,
                          giturl: projects[index].giturl,
                        );
                      }
                    })),
        ],
      ),
    );
  }

  bool _isValidUrl(String url) {
    //validate url
    final urlRegExp = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
      multiLine: false,
    );
    return urlRegExp.hasMatch(url);
  }

  showForm() {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => Dialog(
                  child: SingleChildScrollView(
                    child: Container(
                      width: context.screenWidth < 900
                          ? context.screenWidth * 0.8
                          : context.screenWidth * 0.6,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Form(
                        key: formKey,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Give Project Details Properly",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(FontAwesomeIcons.xmark))
                                ],
                              ),
                              TextFormField(
                                controller: title,
                                keyboardType: TextInputType.text,
                                decoration:
                                    const InputDecoration(label: Text("Title")),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill details';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              TextFormField(
                                controller: desc,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    label: Text("Description")),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill details';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              TextFormField(
                                controller: url,
                                keyboardType: TextInputType.url,
                                decoration: const InputDecoration(
                                    label: Text("Project Screenshot url")),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please fill in the details';
                                  } else if (!_isValidUrl(value)) {
                                    return 'Please enter a valid URL';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              TextFormField(
                                controller: giturl,
                                keyboardType: TextInputType.url,
                                decoration: const InputDecoration(
                                    label: Text("Project github url")),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please fill in the details';
                                  } else if (!_isValidUrl(value)) {
                                    return 'Please enter a valid URL';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(150, 45)),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        // if (await DbHelper.insertProject(
                                        //     Project(
                                        //         title: title.text,
                                        //         description: desc.text,
                                        //         url: url.text,
                                        //         giturl: giturl.text))) {
                                        //   // ignore: use_build_context_synchronously
                                        //   toast(context, "Project added");
                                        // } else {
                                        //   // ignore: use_build_context_synchronously
                                        //   toast(context, 'Try again');
                                        // }
                                        if (await ProjectService.addProject(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            Project(
                                                title: title.text,
                                                description: desc.text,
                                                url: url.text,
                                                giturl: giturl.text))) {
                                          // ignore: use_build_context_synchronously
                                          toast(context, "Project added");
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          toast(context, 'Try again');
                                        }
                                      }
                                    },
                                    child: const Text("Save")),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: context.screenWidth < 600
            ? context.screenWidth * 0.9
            : context.screenWidth < 1000
                ? (context.screenWidth * 0.89) / 2
                : (context.screenWidth * 0.89) / 3,
        height: 200,
        child: const Center(
            child: Icon(
          Icons.add,
          size: 30,
          color: Vx.purple400,
        )),
      ),
    );
  }
}
