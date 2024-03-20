import 'package:chat_app/common/services/authentication/auth_service.dart';
import 'package:chat_app/common/constants/ui_helpers.dart';
import 'package:chat_app/common/widgets/k_button.dart';
import 'package:chat_app/common/widgets/k_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  //Email, password and confirm password controller
  final TextEditingController _eMailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  RegisterPage({super.key});

  //register method
  void register(BuildContext context) {
    //get auth service
    final auth = AuthService();

    if (_pwController.text == _confirmPwController.text) {
      try {
        auth.signUpWithEmailPassword(
          _eMailController.text,
          _pwController.text,
        );
        Get.toNamed('/home');
      } catch (e) {
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
    //if password don' match show error
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            "Password does not match",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(Icons.message,
                    size: 60, color: Theme.of(context).colorScheme.primary),
                elHeightSpan,
                //welcome back message
                Text(
                  "Welcome back, you've been missed!",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                lHeightSpan,
                //email textfield
                KTextFormField(
                    hintText: 'Email',
                    obscureText: false,
                    controller: _eMailController),
                sHeightSpan,
                //password textfield
                KTextFormField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: _pwController,
                ),
                sHeightSpan,
                //confirm password textfield
                KTextFormField(
                  hintText: 'Confirm password',
                  obscureText: true,
                  controller: _confirmPwController,
                ),
                elHeightSpan,
                //login button
                KButton(
                  text: 'Register',
                  onTap: () => register(context),
                ),
                elHeightSpan,
                //register now
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      "/login",
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      children: <TextSpan>[
                        TextSpan(
                          text: "login",
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
        ],
      ),
    );
  }
}
