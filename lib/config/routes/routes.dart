import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bloc_clean_architecture/view/splash/splash_screen.dart';
import 'package:bloc_clean_architecture/view/home/home_screen.dart';
import '../../view/auth/login/login_screen.dart';
import 'route_name.dart';

class RoutesManager {
  static final GoRouter router = GoRouter(
    initialLocation: RoutesName.splashScreen,
    routes: [
      GoRoute(
        path: RoutesName.splashScreen,
        builder: (context, state) => const SplashScreen(),
        routes: [
          GoRoute(
            path: RoutesName.homeScreen.substring(1),
            name: RoutesName.homeScreen,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(path: RoutesName.loginScreen,
          name: RoutesName.loginScreen,
          builder: (context, state) => const LoginScreen(),
          )
        ],
      ),
    ],
  );
}
