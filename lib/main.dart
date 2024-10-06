import 'package:flexi_quiz/core/extension/buildcontext.dart';
import 'package:flexi_quiz/core/log/logger.dart';
import 'package:flexi_quiz/core/routes/global_routes.dart';
import 'package:flexi_quiz/core/theme/apptheme.dart';
import 'package:flexi_quiz/data/helper/firebase_remote_config.dart';
import 'package:flexi_quiz/presentation/provider/authprovider/provider.dart';
import 'package:flexi_quiz/presentation/provider/authprovider/reposiotry/repository.dart';
import 'package:flexi_quiz/presentation/provider/productProvider/provider.dart';
import 'package:flexi_quiz/presentation/provider/productProvider/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    talker.log('App started');
    FirebaseRemoteConfigService().initialize();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(apirepository: ProductRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthRepository()),
        ),
      ],
      child: TalkerWrapper(
        talker: talker,
        
        child: MaterialApp.router(
          theme: AppTheme.lightTheme,
          routerConfig: _router,
        ),
      ),
    );
  }
}

GoRouter _router = GoRouter(
    observers: [TalkerRouteObserver(talker)],
    initialLocation: "/",
    routes: [
      ...Globalroute.globalroute,
    ]);
