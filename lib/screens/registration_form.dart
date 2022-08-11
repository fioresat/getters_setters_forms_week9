import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import '../person.dart';
import 'login.dart';
import 'package:sizer/sizer.dart';

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
          padding: EdgeInsets.all(2.h),
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
    return Container(
      height: 14.h,
      padding: EdgeInsets.all(2.h),
      child: TextFormField(
          initialValue: person.name,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Пожалуйста введите своё имя';
            }
          },
          style: TextStyle(fontSize: 20.sp),
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
    return Container(
      height: 14.h,
      padding: EdgeInsets.all(2.h),
      child: TextFormField(
          initialValue: person.surname,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Пожалуйста введите свою фамилию';
            }
          },
          style: TextStyle(fontSize: 20.sp),
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
    return Container(
      height: 14.h,
      padding: EdgeInsets.all(2.h),
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
          style: TextStyle(fontSize: 20.sp),
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
    return Container(
      height: 14.h,
      padding: EdgeInsets.all(2.h),
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
          style: TextStyle(fontSize: 20.sp),
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
    return Container(
      height: 14.h,
      padding: EdgeInsets.all(2.h),
      child: TextFormField(
          obscureText: true,
          initialValue: person.password,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Пожалуйста придумайте пароль';
            }
          },
          style: TextStyle(fontSize: 20.sp),
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
          title: Text('Я принимаю условия соглашения',
              style: TextStyle(fontSize: 20.sp)),
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
        'Сохранить',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
      ),
    );
  }
}
