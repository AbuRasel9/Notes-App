import 'package:bloc_clean_architecture/config/routes/routes.dart';
import 'package:bloc_clean_architecture/utils/theme/app_theme_data.dart';
import 'package:bloc_clean_architecture/view/home/home_screen.dart';
import 'package:bloc_clean_architecture/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import '';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

      debugShowCheckedModeBanner: false,
      routerConfig:RoutesManager.router,
      themeMode: ThemeMode.light,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
    );
  }
}
