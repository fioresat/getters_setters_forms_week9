import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getters_setters_forms_week9/screens/login.dart';
import 'package:getters_setters_forms_week9/screens/registration_form.dart';
import 'package:getters_setters_forms_week9/person.dart';
import 'package:getters_setters_forms_week9/screens/your_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

bool agreement = false;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: const Color(0xFFFFCC80),
        ),
        home: const LogIn(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LogIn(),
          '/registration': (context) => const RegistrationForm(),
          '/yourpage': (context) => const YourPage(),
        },
      );
    });
  }
}
