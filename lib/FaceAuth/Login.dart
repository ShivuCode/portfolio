import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class FaceAuthenticationPage extends StatefulWidget {
  @override
  _FaceAuthenticationPageState createState() => _FaceAuthenticationPageState();
}

class _FaceAuthenticationPageState extends State<FaceAuthenticationPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _detectAndAuthenticate() async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(_imageFile!);
    final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
    final List<Face> faces = await faceDetector.processImage(visionImage);

    if (faces.isNotEmpty) {
      // If face is detected, authenticate user with Firebase
      AuthService authService = AuthService();
      UserCredential? userCredential = await authService.signInWithFace();
      if (userCredential != null) {
        // Authentication successful, navigate to home screen or perform actions
        print('User authenticated successfully!');
      } else {
        // Authentication failed, handle error
        print('Error: User authentication failed.');
      }
    } else {
      // No face detected, handle error
      print('Error: No face detected.');
    }

    faceDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile == null
                ? Text('No image selected.')
                : Image.file(_imageFile!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _detectAndAuthenticate,
              child: Text('Detect and Authenticate'),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with Firebase using face authentication
  Future<UserCredential?> signInWithFace() async {
    try {
      // Perform face detection and obtain user face data

      // Authenticate with Firebase using face data
      // You would need to implement this part using Firebase Authentication
      // For demonstration purposes, let's assume the face authentication is successful
      UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential;
    } catch (e) {
      print('Error signing in with face: $e');
      return null;
    }
  }
}
