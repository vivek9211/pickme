import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/app_export.dart';
import 'package:travelappflutter/presentation/sign_in_screen/models/sign_in_model.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<SignInModel> signInModelObj = SignInModel().obs;

  final String _emailKey = 'email';
  final String _passwordKey = 'password';
  final String _timestampKey = 'timestamp';

  @override
  void onReady() {
    super.onReady();
    autoSignIn();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      print('User signed in: ${userCredential.user}');
      // Store credentials and timestamp upon successful sign-in
      await storeCredentials(emailController.text, passwordController.text);
      signInModelObj.value.isLoggedIn.value = true; // Update authentication status
      Get.toNamed(AppRoutes.homeScreen);
    } catch (e) {
      print('Sign-in error: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Clear stored credentials
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_emailKey);
      await prefs.remove(_passwordKey);
      await prefs.remove(_timestampKey);
      signInModelObj.value.isLoggedIn.value = false; // Update authentication status
      Get.offAllNamed(AppRoutes.signInScreen); // Navigate to the sign-in screen
    } catch (e) {
      print('Sign-out error: $e');
    }
  }

  Future<void> storeCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
    await prefs.setInt(_timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> autoSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedEmail = prefs.getString(_emailKey);
    final String? storedPassword = prefs.getString(_passwordKey);
    final int? timestamp = prefs.getInt(_timestampKey);

    if (storedEmail != null &&
        storedPassword != null &&
        timestamp != null &&
        DateTime.now()
            .difference(DateTime.fromMillisecondsSinceEpoch(timestamp))
            .inDays <=
            30) {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: storedEmail,
          password: storedPassword,
        );
        print('User automatically signed in: ${userCredential.user}');
        signInModelObj.value.isLoggedIn.value = true; // Update authentication status
      } catch (e) {
        print('Auto sign-in error: $e');
        signInModelObj.value.isLoggedIn.value = false;
      }
    }
  }
}
