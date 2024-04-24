import 'package:flutter/material.dart';
import 'package:little_chat_app/services/auth/auth_service.dart';
import 'package:little_chat_app/components/custom_text_field.dart';
import 'package:little_chat_app/components/custum_button.dart';
import 'package:little_chat_app/core/helpers/helpers.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onPressed;
  const RegisterPage({super.key, required this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    var themeColorScheme = Theme.of(context).colorScheme;
    final formKey = GlobalKey<FormState>();

    void register() {
      // get auth service instance
      final auth = AuthService();

      // passwords match --> create user
      if (passwordController.text == confirmPasswordController.text) {
        try {
          auth.signUpWithEmailPassword(
              emailController.text, passwordController.text);
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Password dosn't Match"),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: themeColorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  verticalSpace(100),
                  // L O G O
                  Icon(
                    Icons.lock_open_rounded,
                    size: 100,
                    color: themeColorScheme.inversePrimary,
                  ),
        
                  verticalSpace(25),
                  // Welcome back massage
                  Text(
                    "Let's create an Account",
                    style: TextStyle(
                        fontSize: 16, color: themeColorScheme.inversePrimary),
                  ),
        
                  verticalSpace(25),
        
                  // email textfield
                  CustomTextField(
                    hint: "Email",
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
                    hint: "Password",
                    controllerr: passwordController,
                    textInputAction: TextInputAction.next,
                    obscuretype: true,
                    icon: Icon(
                      Icons.lock,
                      color: themeColorScheme.background,
                    ),
                    inputTextColor: themeColorScheme.background,
                    boxShadowColor: themeColorScheme.inversePrimary,
                    bgColor: themeColorScheme.inversePrimary,
                    hintStyleColors: themeColorScheme.background,
                  ),
        
                  verticalSpace(25),
        
                  // Confirm password textfield
                  CustomTextField(
                    hint: "Confirm password",
                    controllerr: confirmPasswordController,
                    textInputAction: TextInputAction.done,
                    obscuretype: true,
                    icon: Icon(
                      Icons.lock,
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
                    onPressed: register,
                    text: "Register",
                    horizontalPadding: 150,
                    color: themeColorScheme.inversePrimary,
                    textColor: themeColorScheme.background,
                    circularBorderRadius: 12,
                  ),
                  verticalSpace(25),
                  // dont have an account ? register now
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Already Have an Account ?",
                      style: TextStyle(
                          fontSize: 16, color: themeColorScheme.inversePrimary),
                    ),
                    TextButton(
                      onPressed: widget.onPressed,
                      child: Text(
                        "Login Now ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: themeColorScheme.inversePrimary,
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
    );
  }
}
