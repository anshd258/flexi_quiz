import 'package:flexi_quiz/core/extension/buildcontext.dart';
import 'package:flexi_quiz/presentation/provider/authprovider/provider.dart';
import 'package:flexi_quiz/presentation/views/homepage/page.dart';
import 'package:flexi_quiz/presentation/views/loginpage/page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Signuppage extends StatefulWidget {
  static const signupPageRoute = "/signup";
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().isLoading;
    final user = context.watch<AuthProvider>().user;

    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(HomePage.homePageRoute);
      });
    }

    // Function to validate password

    return Scaffold(
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(hintText: "Name"),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const Gap(8),
                    TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(hintText: "Email"),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          // Basic email validation
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        }),
                    const Gap(8),
                    TextFormField(
                      controller: _password,
                      decoration: const InputDecoration(hintText: "Password"),
                      obscureText: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      }, // Add validation
                    ),
                  ],
                ),
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
                        if (_formKey.currentState!.validate()) {
                           context.read<AuthProvider>().signup(
                              name: _name.text,
                              email: _email.text,
                              password: _password.text);

                        }
                         
                        },
                  child: loading
                      ? const CircularProgressIndicator.adaptive()
                      : Text(
                          "Signup",
                          style: context.textTheme.bodyMedium
                              ?.copyWith(color: context.colorSchema.secondary),
                        ),
                ),
                const Gap(8),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    context.go(LoginPage.loginRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: context.textTheme.labelMedium,
                        children: [
                          TextSpan(
                            text: "Login",
                            style: context.textTheme.bodyMedium
                                ?.copyWith(color: context.colorSchema.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
