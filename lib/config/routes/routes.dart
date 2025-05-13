import 'package:bloc_clean_architecture/view/addNotes/add_notes_screen.dart';
import 'package:bloc_clean_architecture/view/detailsNotes/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bloc_clean_architecture/view/splash/splash_screen.dart';
import 'package:bloc_clean_architecture/view/home/home_screen.dart';
import 'package:bloc_clean_architecture/view/auth/login_screen.dart';
import 'package:bloc_clean_architecture/view/auth/registration_screen.dart';
import 'route_name.dart';

class RoutesManager {
  static final GoRouter router = GoRouter(
    initialLocation: RoutesName.splashScreen,
    routes: [
      GoRoute(
        path: RoutesName.splashScreen,
        name: RoutesName.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutesName.homeScreen,
        name: RoutesName.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RoutesName.loginScreen,
        name: RoutesName.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutesName.registrationScreen,
        name: RoutesName.registrationScreen,
        builder: (context, state) => const RegistrationScreen(),
      ),   GoRoute(
        path: RoutesName.addNewNotes,
        name: RoutesName.addNewNotes,
        builder: (context, state) => const AddNoteScreen(),
      ),
    ],
  );
}
