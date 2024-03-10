import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio/model/user.dart';

class DatabaseService {
  static String uid = FirebaseAuth.instance.currentUser!.uid;
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> savingUserData(UserModel user) async {
    try {
      await userCollection.doc(uid).set({
        'name': user.name,
        'email': user.email,
        'githubId': user.githubId,
        'linkedin': user.linkedin,
        'facebook': user.facebook,
        'instagram': '',
        'projects': user.projects.map((project) => project.toMap()).toList(),
        'skills': {'pl': [], 'fw': [], 'other': []},
        'education': {}
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error creating user: $error');
      }
      rethrow;
    }
  }

  static Future<UserModel?> getUserById() async {
    try {
      DocumentSnapshot userSnapshot = await userCollection.doc(uid).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        print(userData);
        return UserModel.fromMap(userData);
      } else {
        return null; // User not found
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error getting user: $error');
      }
      rethrow;
    }
  }

  static Future<void> updateUser(UserModel updatedUser) async {
    try {
      await userCollection.doc(uid).update({
        'name': updatedUser.name,
        'email': updatedUser.email,
        'githubId': updatedUser.githubId,
        'linkedin': updatedUser.linkedin,
        'facebook': updatedUser.facebook,
        'projects':
            updatedUser.projects.map((project) => project.toMap()).toList(),
        'skills': updatedUser.skills,
        'education': updatedUser.education
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error updating user: $error');
      }
      rethrow;
    }
  }

  static Future<void> deleteUser(String uid) async {
    try {
      await userCollection.doc(uid).delete();
    } catch (error) {
      if (kDebugMode) {
        print('Error deleting user: $error');
      }
      rethrow;
    }
  }
}
