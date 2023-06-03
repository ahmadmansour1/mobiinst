

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduationproject2/TeacherScreen/TeacherHome.dart';
import 'package:graduationproject2/firstpage.dart';
import 'package:graduationproject2/services/api_helper.dart';
import '../classes/Teacher.dart';
import '../main.dart';


class LoginTeacher extends StatefulWidget {
  @override
  _LoginTeacherState createState() => _LoginTeacherState();
}

class _LoginTeacherState extends State<LoginTeacher> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _password;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Teacher? teacher;
  bool _isPasswordVisible = false;
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Text('معلم جديد' , style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              backgroundColor: color,
            ),
            body: Container(
                child: Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16 , top: 80 ),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'سجل هنا',
                                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.black),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.login,
                                      color: Colors.black,
                                      size: 50,
                                    )
                                  ],
                                ),
                                ),

                                SizedBox(height: 90.0),
                                // Add some spacing from the top
                                TextFormField(
                                  controller: _usernameController,
                                  decoration: const InputDecoration(
                                    labelText: 'اسم المستخدم',
                                    border: OutlineInputBorder(),

                                    filled: true,
                                    prefixIcon: Icon(Icons
                                        .person), // Add an icon for the username field
                                  ),
                                  style: TextStyle(fontFamily: 'Montserrat'),
                                  // Use a custom font
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return 'ادخل اسم المستخدم';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _username = value!;
                                  },
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  decoration: InputDecoration(
                                    labelText: 'كلمة السر',
                                    border: const OutlineInputBorder(),
                                    filled: true,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(_isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ), // Add an icon for the password field
                                  ),
                                  style: TextStyle(fontFamily: 'Montserrat'),
                                  // Use a custom font
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return 'ادخل كلمة السر';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _password = value!;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'teacherreg');
                                  },
                                  child: const Text(
                                    'مستخدم جديد؟',
                                    style: TextStyle(color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 60),

                                ElevatedButton(
                                  onPressed: () {
                                    TeacherServices.loginTeacher(
                                            userName: _usernameController.text,
                                            passWord: _passwordController.text)
                                        .then((value) async {
                                      if (value == null) {
                                        print('invalid username or password');
                                      } else {
                                        await sharedPreferences.setBool(
                                            'isLoginTeacher', true);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TeacherhomeScreen(
                                                teacher: value,
                                              ),
                                            ));
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding:  EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Increase the padding
                                    minimumSize: Size(150, 50), // Increase the width and height
                                    backgroundColor: color, // Use the app's primary color for the button
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0), // Add the desired border radius
                                    ),
                                  ),

                                  child: const Text(
                                    'تسجيل',
                                    style: TextStyle(
                                        color: Colors
                                            .white , fontSize: 15, fontWeight: FontWeight.bold), // Use the app's primary text color
                                  ),
                                ),
                                const SizedBox(height: 16.0),

                              ]),
                        ))))));
  }
}
