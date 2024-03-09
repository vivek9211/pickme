import 'dart:async';
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

  late Timer _timer;

  @override
  void onClose() {
    super.onClose();
    groupFiftyOneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    _timer.cancel(); // Cancel timer when controller is closed
  }

  Future<void> signUpWithEmailAndPassword() async {
    try {
      bool isEmailExists = await isEmailAlreadyRegistered(emailController.text.trim());
      if (isEmailExists) {
        Get.snackbar('Warning', 'Email already registered');
        return;
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Add user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': groupFiftyOneController.text.trim(),
        'email': emailController.text.trim(),
      });

      sendEmailVerification();

      Get.toNamed(AppRoutes.verificationScreen);
    } catch (e) {
      print('Sign-up error: $e');
    }
  }

  Future<bool> isEmailAlreadyRegistered(String email) async {
    try {
      // Query Firestore to check if the email exists
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email registration: $e');
      return false;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      setTimerForAutoRedirect();
    } catch (error) {
      print('Error sending verification email: $error');
    }
  }

  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        Get.offAllNamed(AppRoutes.appNavigationScreen);
      }
    });
  }

  void redirectToSignIn() {
    Get.toNamed(AppRoutes.signInScreen);
  }
}
