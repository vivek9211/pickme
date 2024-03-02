import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/core/app_export.dart';
import 'package:travelappflutter/presentation/sign_up_screen/models/sign_up_model.dart';

class SignUpController extends GetxController {
  TextEditingController groupFiftyOneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<SignUpModel> signUpModelObj = SignUpModel().obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onClose() {
    super.onClose();
    groupFiftyOneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> signUpWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Add user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': groupFiftyOneController.text.trim(),
        'email': emailController.text.trim(),
        // Add more fields if needed
      });

      print('User signed up: ${userCredential.user}');
      // You can navigate to the next screen or perform any other action here
      // Example: Get.toNamed(AppRoutes.homeScreen);
      Get.toNamed(AppRoutes.appNavigationScreen);
    } catch (e) {
      print('Sign-up error: $e');
    }
  }
}
