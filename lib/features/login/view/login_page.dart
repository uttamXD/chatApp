import 'package:chat_app/common/services/authentication/auth_service.dart';
import 'package:chat_app/common/constants/ui_helpers.dart';
import 'package:chat_app/common/widgets/k_button.dart';
import 'package:chat_app/common/widgets/k_textformfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //Email and password controller
  final TextEditingController _eMailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  //tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  //login method
  void login(context) async {
    //auth service
    final authService = AuthService();
    //try login
    try {
      await authService.signInWithEmailPassword(
          _eMailController.text, _pwController.text);
    }
    //catch error
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 90),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Image.asset(
                'asset/logo/chat.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              // Icon(Icons.message,
              //     size: 60, color: Theme.of(context).colorScheme.primary),
              elHeightSpan,
              //welcome back message
              Text(
                "Welcome back, you've been missed!",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              lHeightSpan,
              //email textfield
              KTextFormField(
                  hintText: 'Email',
                  obscureText: false,
                  controller: _eMailController),
              sHeightSpan,
              //password testfield
              KTextFormField(
                hintText: 'Password',
                obscureText: true,
                controller: _pwController,
              ),
              elHeightSpan,
              //login button
              KButton(
                text: 'Login',
                onTap: () => login(context),
              ),
              elHeightSpan,
              //register now
              InkWell(
                onTap: onTap,
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Register now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
