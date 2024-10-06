import 'package:flexi_quiz/presentation/views/Signuppage/page.dart';
import 'package:flexi_quiz/presentation/views/homepage/page.dart';
import 'package:flexi_quiz/presentation/views/loginpage/page.dart';
import 'package:go_router/go_router.dart';

class Globalroute {
  static List<RouteBase> globalroute = [
    GoRoute(
      path: LoginPage.loginRoute,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: Signuppage.signupPageRoute,
      builder: (context, state) => const Signuppage(),
    ),
    GoRoute(
      path: HomePage.homePageRoute,
      builder: (context, state) => const HomePage(),
    )
  ];
}
