import 'package:shared_preferences/shared_preferences.dart';

class Person {
  String name = '';
  String surname = '';
  String email = '';
  String password = '';
  String phoneNumber = '';
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
