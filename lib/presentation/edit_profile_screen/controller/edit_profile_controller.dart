import '/core/app_export.dart';
import 'package:travelappflutter/presentation/edit_profile_screen/models/edit_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:travelappflutter/users/user_info.dart';

class EditProfileController extends GetxController {
  TextEditingController languageController = TextEditingController();
  TextEditingController languageOneController = TextEditingController();
  TextEditingController group249Controller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Rx<EditProfileModel> editProfileModelObj = EditProfileModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    languageController.dispose();
    languageOneController.dispose();
    group249Controller.dispose();
    phoneNumberController.dispose();
  }

  Future<void> updateUserProfile() async {
    print('Function Called');
    String username = languageController.text;
    String aadharNumber = languageOneController.text;
    String location = group249Controller.text;
    String phoneNumber = phoneNumberController.text;

    try {
      // Create an instance of FirebaseService
      FirebaseService firebaseService = FirebaseService();
      // Call the updateUserProfile method on the instance
      await firebaseService.updateUserProfile(username, aadharNumber, location, phoneNumber);
      Get.toNamed(AppRoutes.homeScreen);
    } catch (error) {
      print('Failed to update user profile: $error');
      // Handle error here, such as showing an error message to the user
    }
  }

}