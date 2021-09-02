import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quit_frontend/services/loginmethods.dart';
import 'package:quit_frontend/widgets/SignedInWidget.dart';
import 'package:quit_frontend/widgets/signinWidget.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: ChangeNotifierProvider(
      create: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Center(child: CircularProgressIndicator());
            case Status.Unauthenticated:
              return SigninWidget();
            case Status.Authenticating:
              return Center(child: CircularProgressIndicator());
            case Status.Authenticated:
              return SignedInWidget(user: user.user); // user.user
            default:
              return Center(child: Text('uninitalized'));
          }
        },
      ),
    ));
  }
}
