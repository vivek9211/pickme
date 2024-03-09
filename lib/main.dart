import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCUw9TRamC6WOtalfzOmyTcgLo2LR8GRQ4",
        appId: "1:1009922140377:android:523ce3e44932fcb3e176c8",
        messagingSenderId: "1009922140377",
        projectId: "pickme-9211",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppLocalization(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      title: 'PickMe',
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
    );
  }
}
