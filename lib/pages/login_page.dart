import 'package:flutter/material.dart';
import 'package:little_chat_app/services/auth/auth_service.dart';
import 'package:little_chat_app/components/custom_text_field.dart';
import 'package:little_chat_app/components/custum_button.dart';
import 'package:little_chat_app/core/helpers/helpers.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(BuildContext context) async {
    final auth = AuthService();
    try {
      await auth.signInWithEmailPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeColorScheme = Theme.of(context).colorScheme;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: themeColorScheme.background,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/11.jpg"), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    verticalSpace(50),
                    // Welcome back massage
                    const Text(
                      "Little Chat App",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),

                    verticalSpace(350),

                    // email textfield
                    CustomTextField(
                      width: MediaQuery.of(context).size.width,
                      hint: "Enter your email",
                      textInputAction: TextInputAction.next,
                      controllerr: emailController,
                      icon: Icon(
                        Icons.email,
                        color: themeColorScheme.background,
                      ),
                      inputTextColor: themeColorScheme.background,
                      bgColor: themeColorScheme.inversePrimary,
                      boxShadowColor: themeColorScheme.inversePrimary,
                      hintStyleColors: themeColorScheme.background,
                    ),

                    verticalSpace(25),

                    // password textfield
                    CustomTextField(
                      width: MediaQuery.of(context).size.width,
                      hint: "Enter your password",
                      controllerr: passwordController,
                      textInputAction: TextInputAction.done,
                      obscuretype: true,
                      icon: Icon(
                        Icons.password,
                        color: themeColorScheme.background,
                      ),
                      inputTextColor: themeColorScheme.background,
                      boxShadowColor: themeColorScheme.inversePrimary,
                      bgColor: themeColorScheme.inversePrimary,
                      hintStyleColors: themeColorScheme.background,
                    ),
                    verticalSpace(35),
                    // sign in button
                    MyButton(
                      onPressed: () => login(context),
                      text: "Sign in",
                      horizontalPadding: 158,
                      color: themeColorScheme.inversePrimary.withOpacity(0.4),
                      textColor: themeColorScheme.background,
                      circularBorderRadius: 12,
                    ),
                    verticalSpace(25),
                    // dont have an account ? register now
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(
                        "Don't Have an Account ?",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: widget.onPressed,
                        child: const Text(
                          "Register Now ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
