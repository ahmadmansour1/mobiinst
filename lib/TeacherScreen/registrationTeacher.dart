// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:graduationproject2/TeacherScreen/registrationTeacher2.dart';
import 'package:graduationproject2/classes/Teacher.dart';
import 'package:graduationproject2/firstpage.dart';
import 'package:graduationproject2/services/api_helper.dart';
import '../classes/Student.dart';

class RegistrationTeacher extends StatefulWidget {
  @override
  _RegistrationTeacherState createState() => _RegistrationTeacherState();
}

class _RegistrationTeacherState extends State<RegistrationTeacher> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _phonenumberController = TextEditingController();

  Teacher? teacher;

  @override
  void dispose() {
    _passwordController.dispose();
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
    if (value != _passwordController.text) {
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
    if (!email.contains('@')) {
      return false;
    }
    return true;
  }

  String? _validatename(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validatephone(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter your phonenumber';
    }
    if (value!.length < 10) {
      return 'الرقم غير صحيح';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(right: 80),
              child: Text('معلم جديد' , style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            backgroundColor: color,
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'الاسم',
                      filled: true,
                      prefixIcon: Icon(Icons
                          .person),
                      border: OutlineInputBorder(),
                    ),
                    validator: _validatename,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'الاسم التاني',
                      filled: true,
                      prefixIcon: Icon(Icons
                          .person),
                      border: OutlineInputBorder(),
                    ),
                    validator: _validatename,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'البريد الالكتروني',
                      filled: true,
                      prefixIcon: Icon(Icons
                          .email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (!_validateemail(value!)) {
                        return 'enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'اسم المستخدم',
                      border: OutlineInputBorder(),
                      filled: true,
                      prefixIcon: Icon(Icons
                          .person),
                    ),
                    validator: _validateusername,
                    // onSaved: (value) {
                    //   _username = value!;
                    // },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _phonenumberController,
                    decoration: InputDecoration(
                      labelText: 'رقم الهاتف',
                      filled: true,
                      prefixIcon: Icon(Icons
                          .phone),
                      border: OutlineInputBorder(),
                    ),
                    validator: _validatephone,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'كلمة السر',
                      filled: true,
                      prefixIcon: Icon(Icons
                          .lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _confirmpasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'تاكيد كلمة السر',
                        filled: true,
                        prefixIcon: Icon(Icons
                            .lock),
                        border: OutlineInputBorder()),
                    validator: _validateConfirmPassword,
                  ),
                  const SizedBox(height: 30.0),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Increase the padding
                      minimumSize: Size(150, 50), // Increase the width and height
                      backgroundColor: color, // Use the app's primary color for the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Add the desired border radius
                      ),
                    ),
                    child:  Text(
                      'تسجيل',
                      style: TextStyle(
                          color: Colors
                              .white, fontSize: 15 , fontWeight: FontWeight.bold), // Use the app's primary text color
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registrationteacher2(
                                  teacher: Teacher(
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      email: _emailController.text,
                                      username: _usernameController.text,
                                      phoneNumber: _phonenumberController.text,
                                      password: _passwordController.text)),
                            ));
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
