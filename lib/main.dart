import 'package:bem_estar/pages/desafios_screen.dart';
import 'package:bem_estar/pages/home_screen.dart';
import 'package:bem_estar/pages/login_screen.dart';
import 'package:bem_estar/pages/sobre_screen.dart';
import 'package:bem_estar/pages/splash_screen.dart';
import 'package:bem_estar/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFFA2DED0),
          secondary: Color(0xFFAED6F1),
          surface: Color(0xFFF7F7F7),
          onSurface: Color(0xFF333333),
        ),
        scaffoldBackgroundColor: Color(0xFFEDEDED),
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (ctx) => SplashScreen(),
        AppRoutes.login: (ctx) => LoginScreen(),
        AppRoutes.home: (ctx) => HomeScreen(),
        AppRoutes.dessafiosC: (ctx) =>  DesafiosScreen(),
        AppRoutes.sobre: (ctx) => SobreScreen() 
      },
    );
  }
}
