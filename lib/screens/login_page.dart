// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:login/services/api_service.dart';
import 'package:login/utils/form_helper.dart';
import 'package:login/utils/progress_hud.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  String _username = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: ProgressHUD(
            child: _formUI(context),
            opacity: 0.3,
            inAsyncCall: isApiCallProcess,
          )),
    );
  }

  Widget _formUI(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: globalFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    FormHelper.inputFieldWidget(
                      context,
                      const Icon(Icons.verified_user),
                      'username',
                      'UserName',
                      (onValidateVal) {
                        if (onValidateVal.isEmpty) {
                          return 'Username cannot be empty';
                        }
                        return null;
                      },
                      (onSavedValue) {
                        _username = onSavedValue.toString().trim();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormHelper.inputFieldWidget(
                      context,
                      const Icon(Icons.lock),
                      'password',
                      'Password',
                      (onValidateVal) {
                        if (onValidateVal.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                      (onSavedValue) {
                        _password = onSavedValue.toString().trim();
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    FormHelper.saveButton(
                      'Login',
                      () {
                        if (validateAndSave()) {
                          print('username: $_username');
                          print('username: $_password');

                          setState(() {
                            isApiCallProcess = true;
                          });

                          APIService.loginCustomer(_username, _password).then(
                            (response) {
                              setState(() {
                                isApiCallProcess = false;
                              });
                              print(response);
                              if (response) {
                                globalFormKey.currentState!.reset();
                                Navigator.of(context)
                                    .pushReplacementNamed('/home');
                              } else {
                                FormHelper.showMessage(
                                    context, "Login", 'Invalid UN/PW', 'Ok',
                                    () {
                                  Navigator.pop(context);
                                });
                              }
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    // );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
