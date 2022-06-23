import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import '../person.dart';
import 'login.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State {
  final _formKey = GlobalKey<FormState>();
  bool _agreement = false;

  Person person = Person('', '', '', '', '');

  @override
  void initState() {
    super.initState();
    person.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Форма регистрации',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
              key: _formKey,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, int index) {
                    return Column(children: [
                      _inputFieldName(),
                      _inputFieldSurname(),
                      _inputFieldEmail(),
                      _inputFieldPhoneNumber(),
                      _inputFieldPassword(),
                      _agreementCheckBox(),
                      _finalButton(),
                    ]);
                  }))),
    );
  }

  Widget _inputFieldName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          initialValue: person.name,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Пожалуйста введите своё имя';
            }
          },
          style: const TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            labelText: 'Имя',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (name) => setState(() => person.name = name)),
    );
  }

  Widget _inputFieldSurname() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          initialValue: person.surname,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Пожалуйста введите свою фамилию';
            }
          },
          style: const TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            labelText: 'Фамилия',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (surname) => setState(() => person.surname = surname)),
    );
  }

  Widget _inputFieldPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: person.phoneNumber,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Пожалуйста введите свой номер телефона';
            }
          },
          style: const TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            labelText: 'Номер телефона',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (phoneNumber) =>
              setState(() => person.phoneNumber = phoneNumber)),
    );
  }

  Widget _inputFieldEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          initialValue: person.email,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Пожалуйста введите свой E-mail';
            } else if (((!value.contains('@')) || (!value.contains('.')))) {
              return 'E-mail должен иметь вид ***@***.***';
            }
          },
          style: const TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            labelText: 'Контактный E-mail:',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (email) => setState(() => person.email = email)),
    );
  }

  Widget _inputFieldPassword() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          obscureText: true,
          initialValue: person.password,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Пожалуйста придумайте пароль';
            }
          },
          style: const TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            labelText: 'Пароль',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (password) => setState(() => person.password = password)),
    );
  }

  Widget _agreementCheckBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: CheckboxListTile(
          value: _agreement,
          activeColor: Colors.teal,
          title: const Text('Я принимаю условия соглашения',
              style: TextStyle(fontSize: 20.0)),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? value) => setState(() => _agreement = value!)),
    );
  }

  Widget _finalButton() {
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
          String text;
          if (_agreement == false) {
            text = 'Необходимо принять условия соглашения';
          } else {
            text = 'Форма успешно заполнена';
            color = Colors.teal;
            person.saveData();
            Future.delayed(
                const Duration(seconds: 2),
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogIn(),
                    )));
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: color,
              content: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          );
        }
      },
      child: const Text(
        'Сохранить',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
