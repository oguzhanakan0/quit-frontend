import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:quit_frontend/services/loginmethods.dart';
import 'package:quit_frontend/services/requests.dart';
import 'package:quit_frontend/variables/urls.dart';

class PersonalInformationWidget extends StatefulWidget {
  PersonalInformationWidget({Key? key, UserRepository? userRepository})
      : super(key: key);

  @override
  PersonalInformationWidgetState createState() =>
      PersonalInformationWidgetState();
}

class PersonalInformationWidgetState extends State<PersonalInformationWidget> {
  final _formKey = GlobalKey<FormState>();
  final f = DateFormat('yyyy-MM-dd');
  DateTime? _birth_date;
  bool _checkboxVal = false;
  bool _loading = false;
  String? _username;
  String? _first_name;
  String? _last_name;

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository =
        (ModalRoute.of(context)!.settings.arguments as Map)['user'];
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text('Complete Information'),
        ),
        body: SafeArea(
          child: Column(children: [
            // StepProgressIndicator(
            //   totalSteps: 2,
            //   currentStep: 2,
            //   selectedColor: Colors.green,
            //   unselectedColor: Colors.grey.shade100,
            // ),
            Form(
                key: _formKey,
                child: Container(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ' +
                                (_username ??
                                    userRepository.dbUser!["email"]
                                        .split('@')[0]),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * .75,
                              child: Text(
                                'Please complete your information below.',
                                style: Theme.of(context).textTheme.subtitle1,
                              )),
                          SizedBox(
                            height: 12.0,
                          ),
                          CupertinoFormSection(
                              header: Text("Complete Profile"),
                              children: [
                                CupertinoFormRow(
                                    prefix: SizedBox(
                                        width: 120, child: Text("Username")),
                                    child: CupertinoTextFormFieldRow(
                                        onChanged: (value) {
                                          setState(() {
                                            _username = value;
                                          });
                                        },
                                        initialValue: userRepository
                                            .dbUser!["email"]
                                            .split('@')[0])),
                              ]),
                          CupertinoFormSection(
                              header: Text("Personal Information (Optional)"),
                              children: [
                                CupertinoFormRow(
                                    prefix: SizedBox(
                                        width: 120, child: Text("First Name")),
                                    child: CupertinoTextFormFieldRow(
                                      initialValue: userRepository
                                              .dbUser!["first_name"] ??
                                          '',
                                      placeholder: 'Oguzhan',
                                      onChanged: (value) {
                                        setState(() {
                                          _first_name = value;
                                        });
                                      },
                                    )),
                                CupertinoFormRow(
                                    prefix: SizedBox(
                                        width: 120, child: Text("Last Name")),
                                    child: CupertinoTextFormFieldRow(
                                      initialValue:
                                          userRepository.dbUser!["last_name"] ??
                                              '',
                                      placeholder: 'Akan',
                                      onChanged: (value) {
                                        setState(() {
                                          _last_name = value;
                                        });
                                      },
                                    )),
                                CupertinoFormRow(
                                    prefix: SizedBox(
                                        width: 120, child: Text("Birth Date")),
                                    child: GestureDetector(
                                        onTap: () {
                                          _showDatePicker(context);
                                        },
                                        child: AbsorbPointer(
                                          child: CupertinoTextFormFieldRow(
                                            placeholderStyle: _birth_date ==
                                                    null
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        color: Colors.grey[350])
                                                : Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                            placeholder: _birth_date == null
                                                ? 'Tap to enter'
                                                : f.format(_birth_date!),
                                          ),
                                        ))),
                                CheckboxListTile(
                                  title: Text(
                                    "I would like to receive email promotions and regular newsletter from IQuit.",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  value: _checkboxVal,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _checkboxVal = !_checkboxVal;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity
                                      .leading, //  <-- leading Checkbox
                                ),
                              ]),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "By clicking on the button below, you are accepting the Privacy Policy and User Agreement provided in IQuit's website.",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          CupertinoButton.filled(
                              child: Text("Complete Sign Up"),
                              onPressed: _loading
                                  ? () {}
                                  : () async {
                                      setState(() {
                                        _loading = true;
                                      });
                                      if (_formKey.currentState!.validate()) {
                                        print(_formKey.toString());
                                        Response res = await sendPost(
                                            url: UPDATE_USER_URL,
                                            body: jsonEncode({
                                              "uid": userRepository.user!.uid,
                                              "username": _username ??
                                                  userRepository
                                                      .dbUser!["email"]
                                                      .split('@')[0],
                                              "first_name": _first_name ??
                                                  userRepository
                                                      .dbUser!["first_name"],
                                              "last_name": _last_name ??
                                                  userRepository
                                                      .dbUser!["last_name"],
                                              "birth_date": _birth_date == null
                                                  ? null
                                                  : f.format(_birth_date!),
                                              "marketing_check": _checkboxVal,
                                            }));
                                        print("response:");
                                        print(json.decode(res.body));
                                        if (json.decode(res.body)["success"]) {
                                          userRepository.setdbUser =
                                              json.decode(res.body)["user"];
                                          print("updated successfully.");
                                          Navigator.of(context).pop();
                                        }
                                      }
                                      setState(() {
                                        _loading = false;
                                      });
                                    }),
                        ])))
          ]),
        ));
  }

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (BuildContext context) => Container(
              height: 320,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 240,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime(1990),
                        maximumYear: 2021,
                        minimumYear: 1920,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _birth_date = val;
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('Done'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ));
  }
}
