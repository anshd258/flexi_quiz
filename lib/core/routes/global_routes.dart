import 'package:flexi_quiz/presentation/views/Signuppage/page.dart';
import 'package:flexi_quiz/presentation/views/homepage/page.dart';
import 'package:flexi_quiz/presentation/views/loginpage/page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Globalroute {
  static List<RouteBase> globalroute = [
    GoRoute(
      path: LoginPage.loginRoute,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          double begin = 0; // Start from the right
          double end = 1;
          const curve = Curves.easeInOut;

          final tween = Tween<double>(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          final offsetAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: offsetAnimation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: Signuppage.signupPageRoute,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const Signuppage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          double begin = 0; // Start from the right
          double end = 1;
          const curve = Curves.easeInOut;

          final tween = Tween<double>(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          final offsetAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: offsetAnimation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: HomePage.homePageRoute,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          double begin = 0; // Start from the right
          double end = 1;
          const curve = Curves.easeInOut;

          final tween = Tween<double>(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          final offsetAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: offsetAnimation,
            child: child,
          );
        },
      ),
    )
  ];
}
