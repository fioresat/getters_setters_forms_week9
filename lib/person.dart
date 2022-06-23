import 'package:shared_preferences/shared_preferences.dart';

class Person {
  String name = 'Mary';
  String surname = 'Thompson';
  String email = 'mary@emai.ru';
  String password = '123';
  String phoneNumber = '123456789';
  late SharedPreferences _prefs;

  Person(this.name, this.surname, this.email, this.phoneNumber, this.password);

  Future loadData() async {
    _prefs = await SharedPreferences.getInstance();

    name = (_prefs.getString('name') ?? '');
    surname = (_prefs.getString('surname') ?? '');
    email = (_prefs.getString('email') ?? '');
    phoneNumber = (_prefs.getString('phoneNumber') ?? '');
    password = (_prefs.getString('password') ?? '');
  }

  Future saveData() async {
    await _prefs.setString('name', name);
    await _prefs.setString('surname', surname);
    await _prefs.setString('email', email);
    await _prefs.setString('phoneNumber', phoneNumber);
    await _prefs.setString('password', password);
  }



}
