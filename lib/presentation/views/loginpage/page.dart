import 'dart:async';

import 'package:flexi_quiz/core/extension/buildcontext.dart';
import 'package:flexi_quiz/presentation/provider/authprovider/provider.dart';

import 'package:flexi_quiz/presentation/views/Signuppage/page.dart';
import 'package:flexi_quiz/presentation/views/homepage/page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const loginRoute = "/";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool canPop = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late StreamSubscription _stream;
  @override
  void initState() {
    _stream = context.read<AuthProvider>().streamAuth.listen(
      (event) {
        if (event != null) {
          context.go(HomePage.homePageRoute);
        }
      },
    );
    if (mounted) {
      context.read<AuthProvider>().addListener(
        () {
          final user = context.read<AuthProvider>().user;

          if (user != null) {
            user.fold(
              (l) {
                context.showErrorDialog('Unable to login');
              },
              (r) {
                context.go(HomePage.homePageRoute);
              },
            );
          }
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().isLoading;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        await _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 24,
          title: Text(
            "e-shop",
            style: context.textTheme.titleMedium
                ?.copyWith(color: context.colorSchema.primary),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _email,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const Gap(8),
                    TextField(
                      controller: _password,
                      decoration: const InputDecoration(hintText: "password"),
                      obscureText: true,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: loading
                          ? null
                          : () {
                              context.read<AuthProvider>().login(
                                  email: _email.text, password: _password.text);
                            },
                      child: loading
                          ? const CircularProgressIndicator.adaptive()
                          : Text(
                              "Login",
                              style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorSchema.secondary),
                            )),
                  const Gap(8),
                  InkWell(
                    borderRadius: BorderRadius.circular(6),
                    radius: 15,
                    onTap: () {
                      context.push(Signuppage.signupPageRoute);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                          text: TextSpan(
                              text: "New here? ",
                              style: context.textTheme.labelMedium,
                              children: [
                            TextSpan(
                                text: "Signup",
                                style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colorSchema.primary))
                          ])),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Future> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit App?'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }
}
