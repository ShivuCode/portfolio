import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SkillService {
  static String uid = FirebaseAuth.instance.currentUser!.uid;
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Add a skill to a specific category
  static Future<bool> addSkill(String category, String skill) async {
    try {
      await userCollection.doc(uid).update({
        'skills.$category': FieldValue.arrayUnion([skill])
      });
      return true;
    } catch (error) {
      if (kDebugMode) {
        print('Error adding skill: $error');
      }
      return false;
    }
  }

  // Remove a skill from a specific category
  static Future<bool> removeSkill(String category, String skill) async {
    try {
      await userCollection.doc(uid).update({
        'skills.$category': FieldValue.arrayRemove([skill])
      });
      return true;
    } catch (error) {
      if (kDebugMode) {
        print('Error removing skill: $error');
      }
      return false;
    }
  }

  // Delete all skills from a specific category
  static Future<bool> deleteAllSkills(String category) async {
    try {
      await userCollection
          .doc(uid)
          .update({'skills.$category': FieldValue.delete()});
      return true;
    } catch (error) {
      if (kDebugMode) {
        print('Error deleting skills: $error');
      }
      return false;
    }
  }

  static Future<List<String>> getSkills(String category) async {
    try {
      DocumentSnapshot userSnapshot = await userCollection.doc(uid).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        List<dynamic> skills = userData['skills'][category] ?? [];
        return List<String>.from(skills);
      } else {
        return []; // User not found or has no skills in that category
      }
    } catch (error) {
      print('Error getting skills: $error');
      throw error;
    }
  }
}
