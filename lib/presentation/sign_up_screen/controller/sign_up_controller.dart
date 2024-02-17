import '/core/app_export.dart';
import 'package:travelappflutter/presentation/sign_up_screen/models/sign_up_model.dart';
import 'package:flutter/material.dart';

class SignUpController extends GetxController {
  TextEditingController groupFiftyOneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); // Add this line

  Rx<SignUpModel> signUpModelObj = SignUpModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    groupFiftyOneController.dispose();
    emailController.dispose();
    passwordController.dispose(); // Don't forget to dispose it when not needed
  }
}
