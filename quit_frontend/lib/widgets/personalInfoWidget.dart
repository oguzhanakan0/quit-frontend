import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quit_frontend/services/loginmethods.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:email_validator/email_validator.dart';

class PersonalInformationWidget extends StatefulWidget {
  PersonalInformationWidget({Key? key}) : super(key: key);

  @override
  PersonalInformationWidgetState createState() =>
      PersonalInformationWidgetState();
}

class PersonalInformationWidgetState extends State<PersonalInformationWidget> {
  final _formKey = GlobalKey<FormState>();
  final f = DateFormat('M-d-yyyy');
  DateTime? _chosenDate;
  bool _checkboxVal = false;

  @override
  Widget build(BuildContext context) {
    UserRepository user =
        (ModalRoute.of(context)!.settings.arguments as Map)['user'];
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Complete Information'),
      ),
      body: SafeArea(
          child:
              // Column(children: [
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
                              'Welcome, ' + user.user!.email!.split('@')[0],
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * .75,
                                child: Text(
                                  'Please complete your information below. Although the fields are optional, we encourage you to fill in for a better experience.',
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
                                          width: 120,
                                          child: Text("First Name")),
                                      child: CupertinoTextFormFieldRow(
                                        initialValue:
                                            user.user!.displayName ?? '',
                                        placeholder: 'Oguzhan',
                                      )),
                                  CupertinoFormRow(
                                      prefix: SizedBox(
                                          width: 120, child: Text("Last Name")),
                                      child: CupertinoTextFormFieldRow(
                                        placeholder: 'Akan',
                                      )),
                                  CupertinoFormRow(
                                      prefix: SizedBox(
                                          width: 120,
                                          child: Text("Birth Date")),
                                      child: GestureDetector(
                                          onTap: () {
                                            _showDatePicker(context);
                                          },
                                          child: AbsorbPointer(
                                            child: CupertinoTextFormFieldRow(
                                              placeholderStyle: _chosenDate ==
                                                      null
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                          color:
                                                              Colors.grey[350])
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                              placeholder: _chosenDate == null
                                                  ? 'Tap to enter'
                                                  : f.format(_chosenDate!),
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
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    print('valid');
                                  }
                                }),
                          ])))),
    );
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
                            _chosenDate = val;
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
