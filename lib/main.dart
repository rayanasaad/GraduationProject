import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:junews/View/screens/splash_screen.dart';
import 'package:junews/helper/app_colors.dart';
import 'package:junews/localization/translation.dart';

String languageCode = "ar";
ThemeMode mode = ThemeMode.light;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // SharedPreferences shared = await SharedPreferences.getInstance();
  // languageCode = shared.getString("language_code") ?? "ar";

  runApp(  const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale:  Locale(languageCode),
      translations: Translation(),
      theme: ThemeData(
        fontFamily: 'NotoKufiArabic',
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: grey.withOpacity(0.2),
      ),
      themeMode: mode,

      home:const SplashScreen(),
    );
  }
}
