import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getters_setters_forms_week9/main.dart';
import 'package:getters_setters_forms_week9/screens/registration_form.dart';
import 'package:getters_setters_forms_week9/screens/your_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../person.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  LogInState createState() => LogInState();
}

class LogInState extends State {
  final _formKey = GlobalKey<FormState>();
  String email1 = '';
  String password1 = '';
  late SharedPreferences _prefs;
  Person person = Person('', '', '', '', '');

  @override
  void initState() {
    super.initState();
    person.loadData();
  }

  @override
  Widget build(BuildContext context) {
    _loadAgreement();
    if (agreement == false) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Форма входа',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.teal,
        ),
        body: Container(
            padding: EdgeInsets.all(5.h),
            child: Form(
                key: _formKey,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, int index) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _inputFieldEmail(),
                            _inputFieldPassword(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _logINButton(),
                                _signUpButton(),
                              ],
                            )
                          ]);
                    }))),
      );
    } else {
      return const YourPage();
    }
  }

  Widget _inputFieldEmail() {
    return Container(
      height: 14.h,
      padding: EdgeInsets.all(2.h),
      child: TextFormField(
          initialValue: email1,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Пожалуйста введите свой E-mail';
            } else if (((!value.contains('@')) || (!value.contains('.')))) {
              return 'E-mail должен иметь вид ***@***.***';
            }
          },
          style: TextStyle(fontSize: 20.sp),
          decoration: InputDecoration(
            labelText: 'Контактный E-mail:',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (email) => setState(() => email1 = email)),
    );
  }

  Widget _inputFieldPassword() {
    return Container(
      height: 14.h,
      padding: EdgeInsets.all(2.h),
      child: TextFormField(
          obscureText: true,
          initialValue: password1,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Пожалуйста вспомните пароль';
            }
          },
          style: TextStyle(fontSize: 20.sp),
          decoration: InputDecoration(
            labelText: 'Пароль',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (password) => setState(() => password1 = password)),
    );
  }

  Widget _logINButton() {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        //side: BorderSide(color: Colors.red)
      ))),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Color color = Colors.red;
          String text = '';
          if (email1 != person.email) {
            text = 'Такого пользователя не существует';
          } else if (password1 != person.password) {
            text = 'Неверный пароль';
          } else {
            color = Colors.teal;
            text = 'Привет ${person.name}';
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const YourPage(),
                ));
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: color,
              content: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          );
        }
      },
      child: Text(
        'Log In',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
      ),
    );
  }

  Widget _signUpButton() {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        //side: BorderSide(color: Colors.red)
      ))),
      onPressed: () {
        _awaitReturnValueFromSecondScreen(context);
      },
      child: Text(
        'Sign Up',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegistrationForm(),
        ));
    setState(() {
      if (result.email != '') {
        person.loadData();
      }
    });
  }

  void _loadAgreement() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      agreement = (_prefs.getBool('agreement'))!;
    });
  }
}
