import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quit_frontend/services/loginmethods.dart';

class SignedInWidget extends StatelessWidget {
  const SignedInWidget({Key? key, this.user}) : super(key: key);
  final User? user;
  @override
  Widget build(BuildContext context) {
    String displayName = user!.displayName ?? user!.email ?? 'Giriş yaptınız.';
    String? photoUrl = user!.photoURL ?? null;
    String? providerId;
    FaIcon? icon;
    print(user!.providerData[0]);
    switch (user!.providerData[0].providerId) {
      case "facebook.com":
        providerId = 'Facebook';
        icon = FaIcon(
          FontAwesomeIcons.facebookF,
          color: Color(0xff4267B2),
        );
        break;
      case "apple.com":
        providerId = "Apple";
        icon = FaIcon(
          FontAwesomeIcons.apple,
          color: Color(0xff666666),
        );
        break;
      case "google.com":
        providerId = "Google";
        icon = FaIcon(
          FontAwesomeIcons.google,
          color: Color(0xff4285F4),
        );
        break;
      case "password":
        providerId = "Email";
        icon = FaIcon(
          FontAwesomeIcons.envelope,
          color: Color(0xff4285F4),
        );
        break;
      default:
        providerId = "";
        break;
    }
    print(user!.providerData);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (photoUrl != null)
          Container(
              margin: EdgeInsets.only(bottom: 12.0),
              width: 72,
              height: 72,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 12.0,
                    spreadRadius: -12.0,
                    color: Colors.grey[300]!)
              ]),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(photoUrl))),
        Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              displayName,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
        Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon == null ? Text('icon') : icon,
                Text(
                  '  Signed in via ' + providerId,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontStyle: FontStyle.italic),
                )
              ],
            )),
        GestureDetector(
          child: Text(
            "Logout",
            style: Theme.of(context).accentTextTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Theme.of(context).primaryColorDark),
          ),
          onTap: () {
            Provider.of<UserRepository>(context, listen: false).signOut();
          },
        )
      ],
    );
  }
}
