
import 'package:flutter/material.dart';
import 'package:graduationproject2/firstpage.dart';
import 'package:graduationproject2/services/api_helper.dart';

import '../main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}


class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _gender = '';
  final _confirmpasswordController = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final gender = TextEditingController();
  final password = TextEditingController();
  @override
  void dispose() {
    password.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value == null || value.isEmpty  ) {
      return 'Please enter a password';
    }
    if (value.contains(regex)) {
      return 'invalid pasword';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null; // Return null if the validation succeeds

  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateusername(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  bool _validateemail(String email) {
    if (email.isEmpty) {
      return false;
    }
    if (!email.contains('@')) {       return false;
    }
    return true;
  }

  String? _validatename(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 80),
            child: Text('طالب جديد' , style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          backgroundColor: color,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   SizedBox(height: 15.0),
                  TextFormField(
                    controller: firstname,
                    decoration: const InputDecoration(
                      labelText: 'الاسم الاول',
                      border: OutlineInputBorder(),
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: _validatename,
                    onSaved: (String? firstname) {},
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: lastname,
                    decoration: const InputDecoration(
                      labelText: 'اسم العائلة',
                      border: OutlineInputBorder(),
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: _validatename,
                    onSaved: (String? lastname) {},
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: 'البريد الالكتروني',
                      border: OutlineInputBorder(),
                      filled: true,
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (!_validateemail(value!)) {
                        return 'enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (String? email) {},
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: username,
                    decoration: const InputDecoration(
                      labelText: 'اسم المستخدم',
                      border: OutlineInputBorder(),
                      filled: true,
                      prefixIcon: Icon(Icons.person_2),
                    ),
                    validator: _validateusername,
                    onSaved: (String? username) {},

                    /*validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },

                      */
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'كلمالسر',
                          border: OutlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(Icons.lock)),
                      validator: _validatePassword,
                      onSaved: (String? password) {}
                      /*validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;


                      ,*/
                      ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _confirmpasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'تاكيد كلمة السر',
                        filled: true,
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder()),
                    validator: _validateConfirmPassword,
                  ),
                  const SizedBox(height: 30.0),

                  Row(
                    children: [
                      const Align(
                          alignment: Alignment.centerRight, child: Text('الجنس' , style: TextStyle(fontSize:20 ),)),
                      SizedBox(width: 15,),
                      Radio(
                        value: 'MALE',
                        groupValue: _gender,
                        onChanged: (String? value) {
                          _gender = value!.toUpperCase();
                          print(_gender);
                          setState(() {});
                        },
                      ),
                      Text('ذكر'),
                      Radio(
                        value: 'FEMALE',
                        groupValue: _gender,
                        onChanged: (String? value) {
                          _gender = value!.toUpperCase();
                          setState(() {});
                        },
                      ),
                      Text('انثى'),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Increase the padding
                      minimumSize: Size(150, 50), // Increase the width and height
                      backgroundColor: color, // Use the app's primary color for the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Add the desired border radius
                      ),
                    ), // Use the app's primary color for the button

                    child: const Text(
                      'تسجيل',
                      style: TextStyle(
                          color: Colors
                              .white, fontSize: 15 , fontWeight: FontWeight.bold), // Use the app's primary text color
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          _gender != "") {
                        StudentServices.registerStudent(
                          userName: username.text,
                          passWord: password.text,
                          email: email.text,
                          firstName: firstname.text,
                          gender: _gender,
                          lastName: lastname.text,
                        ).then((value) {
                          if (value == 0) {
                            print("object");
                          } else {
                            Navigator.pushNamed(context, "Home");
                          }
                        });
                      }



                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
