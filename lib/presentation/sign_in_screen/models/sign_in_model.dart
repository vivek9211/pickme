import 'package:get/get.dart';

class SignInModel {
  final RxBool isLoggedIn;

  SignInModel({bool initialValue = false}) : isLoggedIn = initialValue.obs;
}
