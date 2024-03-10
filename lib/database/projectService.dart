import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/projectModel.dart';

class ProjectService {
  static String? uid;
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  static Future<bool> addProject(String uid, Project project) async {
    try {
      await userCollection.doc(uid).update({
        'projects': FieldValue.arrayUnion([project.toMap()])
      });
      return true;
    } catch (error) {
      if (kDebugMode) {
        print('Error adding project: $error');
      }
      return false;
    }
  }

  static Future<void> deleteProject(String uid, String projectId) async {
    try {
      await userCollection.doc(uid).update({
        'projects': FieldValue.arrayRemove([
          {'projectId': projectId}
        ])
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error deleting project: $error');
      }
      rethrow;
    }
  }

  static Future<void> updateProject(
      String uid, String projectId, Project updatedProject) async {
    try {
      await userCollection.doc(uid).update({
        'projects': FieldValue.arrayUnion([updatedProject.toMap()])
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error updating project: $error');
      }
      rethrow;
    }
  }

  static Future<List<Project>> getAllProjects(String uid) async {
    try {
      DocumentSnapshot userSnapshot = await userCollection.doc(uid).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        List<dynamic> projectsData = userData['projects'] ?? [];
        return projectsData.map((projectData) {
          return Project(
            title: projectData['title'] ?? '',
            url: projectData['url'] ?? '',
            description: projectData['description'] ?? '',
            giturl: projectData['giturl'] ?? '',
          );
        }).toList();
      } else {
        return []; // User not found or has no projects
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error getting user projects: $error');
      }
      rethrow;
    }
  }

  static Future<bool> deleteAllProjects(String uid) async {
    try {
      await userCollection.doc(uid).update({'projects': FieldValue.delete()});
      return true;
    } catch (error) {
      if (kDebugMode) {
        print('Error deleting all projects: $error');
      }
      return false;
    }
  }
}
