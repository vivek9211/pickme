import 'package:flutter/material.dart';
import 'package:travelappflutter/core/app_export.dart';
import 'package:travelappflutter/core/utils/validation_functions.dart';
import 'package:travelappflutter/widgets/custom_button.dart';
import 'package:travelappflutter/widgets/custom_icon_button.dart';
import 'package:travelappflutter/widgets/custom_text_form_field.dart';

import 'controller/sign_in_controller.dart';

// ignore_for_file: must_be_immutable
class SignInScreen extends GetWidget<SignInController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: Container(
                width: size.width,
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomIconButton(
                                  height: 44,
                                  width: 44,
                                  margin:
                                      getMargin(left: 20, top: 8, right: 20),
                                  alignment: Alignment.centerLeft,
                                  onTap: () {
                                    onTapBtntf();
                                  },
                                  child: CommonImageView(
                                      svgPath: ImageConstant.imgArrowleft)),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 20, top: 40, right: 20),
                                      child: Text("lbl_sign_in_now".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtSFUIDisplaySemibold26
                                              .copyWith(height: 1.00)))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 20, top: 12, right: 20),
                                      child: Text("msg_please_sign_in".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtSFUIDisplayRegular16
                                              .copyWith(height: 1.00)))),
                              CustomTextFormField(
                                  width: 335,
                                  focusNode: FocusNode(),
                                  controller: controller.emailController,
                                  hintText: "msg_www_example_gmail".tr,
                                  margin:
                                      getMargin(left: 20, top: 40, right: 20),
                                  textInputAction: TextInputAction.done,
                                  alignment: Alignment.center,
                                  validator: (value) {
                                    if (value == null ||
                                        (!isValidEmail(value,
                                            isRequired: true))) {
                                      return "Please enter valid email";
                                    }
                                    return null;
                                  }),
                              CustomTextFormField(
                                width: 335,
                                focusNode: FocusNode(),
                                controller: controller.passwordController, // Assuming you have a TextEditingController named passwordController in your controller
                                hintText: "Enter your password",
                                margin: getMargin(left: 20, top: 24, right: 20), // Adjust the margin as needed
                                textInputAction: TextInputAction.done,
                                alignment: Alignment.center,
                                isObscureText: true, // This will obscure/hide the entered password
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  } else if (value.length < 6) { // Example: Minimum password length is 6 characters
                                    return "Password must be at least 6 characters long";
                                  }
                                  // You can add additional validation logic if needed
                                  return null;
                                },
                              ),
                              CustomButton(
                                  onTap: () {
                                    controller.signInWithEmailAndPassword();
                                  },
                                  width: 335,
                                  text: "lbl_sign_in".tr,
                                  margin:
                                      getMargin(left: 20, top: 40, right: 20),
                                  alignment: Alignment.center),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 20, top: 40, right: 20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text("msg_don_t_have_an_a".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtSFUIDisplayRegular14
                                                    .copyWith(height: 1.00)),
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                    AppRoutes.signUpScreen);
                                              },
                                              child: Padding(
                                                  padding: getPadding(left: 8),
                                                  child: Text("lbl_sign_up".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtSFUIDisplayMedium14
                                                          .copyWith(
                                                              height: 1.00))),
                                            )
                                          ]))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 20, top: 20, right: 20),
                                      child: Text("lbl_or_connect".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtSFUIDisplayRegular14
                                              .copyWith(height: 1.00)))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 20,
                                          top: 100,
                                          right: 20,
                                          bottom: 5),
                                      child: CommonImageView(
                                          imagePath: ImageConstant.imgGroup335,
                                          height: getVerticalSize(44.00),
                                          width: getHorizontalSize(172.00))))
                            ]))))));
  }

  onTapBtntf() {
    Get.back();
  }
}
