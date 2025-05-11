import 'package:bloc_clean_architecture/config/routes/route_name.dart';
import 'package:bloc_clean_architecture/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutesManager {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: RoutesName.homeScreen,
      pageBuilder: (context, state) => MaterialPage(
        child: const HomeScreen(),
        key: state.pageKey,
      ),
    )
  ]);
}
