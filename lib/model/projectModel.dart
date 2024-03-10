class Project {
  String title;
  String description;
  String url;
  String giturl;

  Project({
    required this.title,
    required this.description,
    required this.url,
    required this.giturl,
  });

  // Convert Project object to a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'giturl': giturl,
    };
  }
}
