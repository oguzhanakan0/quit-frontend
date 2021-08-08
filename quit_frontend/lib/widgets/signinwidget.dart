import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quit_frontend/services/loginmethods.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SigninWidget extends StatefulWidget {
  SigninWidget();

  @override
  _SigninWidgetState createState() => _SigninWidgetState();
}

class _SigninWidgetState extends State<SigninWidget> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Center(
        child: Container(
            height: 250,
            child: Column(children: [
              SignInButton(
                Buttons.Google,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                text: "Google ile giriş yapın",
                onPressed: () async {
                  bool res = await user.signinWithGoogle();
                  print(res);
                },
              ),
              if (Platform.isIOS)
                SignInButton(
                  Buttons.AppleDark,
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  text: "Apple ile giriş yapın",
                  onPressed: () async {
                    bool res = await user.signInWithApple();
                    print(res);
                  },
                ),
              SignInButton(
                Buttons.FacebookNew,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                text: "Facebook ile giriş yapın",
                onPressed: () async {
                  bool res = await user.signinWithFacebook();
                  print(res);
                },
              )
            ])));
  }
}
