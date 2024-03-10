import 'package:portfolio/model/projectModel.dart';

class UserModel {
  String name;
  String desc;
  String email;
  String githubId;
  String img;
  String linkedin;
  String facebook;
  String instagram;
  List roles;
  Map<String, dynamic> education;

  Map<String, dynamic> skills;
  List<Project> projects;

  UserModel(
      {required this.name,
      required this.desc,
      required this.email,
      required this.githubId,
      required this.linkedin,
      required this.facebook,
      required this.instagram,
      required this.roles,
      required this.education,
      required this.projects,
      required this.skills,
      required this.img});

  // Constructor to handle null values
  UserModel.fromMap(Map<String, dynamic> data)
      : name = data['name'] ?? '',
        desc = data['desc'] ?? '',
        email = data['email'] ?? '',
        githubId = data['githubId'] ?? '',
        linkedin = data['linkedin'] ?? '',
        facebook = data['facebook'] ?? '',
        instagram = data['instagram'] ?? '',
        roles = data['roles'] ?? [],
        education = data['education'] ?? {},
        projects = (data['projects'] as List<dynamic>? ?? [])
            .map((projectData) => Project(
                  title: projectData['title'] ?? '',
                  url: projectData['url'] ?? '',
                  description: projectData['description'] ?? '',
                  giturl: projectData['giturl'] ?? '',
                ))
            .toList(),
        skills = data['skills'] is List<dynamic>
            ? {'fw': [], 'other': [], 'pl': []} // Default value for list
            : (data['skills'] as Map<String, dynamic>? ?? {})
                .cast<String, dynamic>(),
        img = data['img'] ?? '';
}
