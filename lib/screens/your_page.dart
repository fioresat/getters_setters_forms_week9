import 'package:flutter/material.dart';
import 'package:getters_setters_forms_week9/screens/registration_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../person.dart';
import 'package:getters_setters_forms_week9/screens/login.dart';

class YourPage extends StatefulWidget {
  const YourPage({Key? key}) : super(key: key);

  @override
  YourPageState createState() => YourPageState();
}

class YourPageState extends State {
  late SharedPreferences _prefs;
  Color color = Colors.teal;

  Person person = Person('','','','','');

  @override
  void initState() {
    super.initState();
    person.loadData();
    _loadAgreement();
  }


  void _loadAgreement() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      agreement = (_prefs.getBool('agreement'))!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                agreement = false;
                _saveAgreement();
                Navigator.pop(context);
              })
        ],
        title: const Text('Ваш профиль'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(padding: const EdgeInsets.all(10.0), children: [
          textInContainer('${person.name} ${person.surname}', const Icon(Icons.person)),
          textInContainer(person.email, const Icon(Icons.email)),
          textInContainer(person.phoneNumber, const Icon(Icons.phone)),
          _agreementCheckBox(),
          // Row(children: [
          //   //_saveButton(),
          //   //_changeButton(),
          // ])
        ]),
      ),
    );
  }

  Widget textInContainer(String a, Icon b)
  {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.2),
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          b,
          Text(
            a,
            textAlign: TextAlign.center,
            style:
            const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }


  Widget _agreementCheckBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: CheckboxListTile(
          value: agreement,
          activeColor: Colors.teal,
          title: const Text('Входить автоматически',
              style: TextStyle(fontSize: 20.0)),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? value) {
            setState(() => agreement = value!);
            _saveAgreement();
          }),
    );
  }

  void _saveAgreement() async {
    await _prefs.setBool('agreement', agreement);
  }


  Widget _changeButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationForm(),
            ));
      },
      child: const Text(
        'Редактировать форму',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }


}
