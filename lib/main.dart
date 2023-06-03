// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduationproject2/StudentScreen/StudentInfo.dart';
import 'package:graduationproject2/TeacherScreen/TeacherHome.dart';
import 'package:graduationproject2/classes/Teacher.dart';
import 'package:graduationproject2/firstpage.dart';
import 'package:graduationproject2/StudentScreen/favourite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'StudentScreen/home_page.dart';
import 'StudentScreen/Registration.dart';
import 'StudentScreen/login.dart';
import 'TeacherScreen/Teacherlogin.dart';
import 'TeacherScreen/registrationTeacher.dart';
import 'TeacherScreen/registrationTeacher2.dart';

late final SharedPreferences sharedPreferences;


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();


  sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("isLoginTeacher", false);
   sharedPreferences.setBool("isLoginStudent", false);
  if (sharedPreferences.getBool('isLoginStudent') == null) {
    sharedPreferences.setBool("isLoginStudent", false);
  } else {}

  if (sharedPreferences.getBool('isLoginTeacher') == null) {
    sharedPreferences.setBool("isLoginTeacher", false);
  } else {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: sharedPreferences.getBool('isLoginStudent') == true
          ? HomeScreen()
          : sharedPreferences.getBool('isLoginTeacher') == true
              ? TeacherhomeScreen()
      : Firstpge(),
      routes: {
        'register': (context) => RegistrationScreen(),
        'Home': (context) => HomeScreen(),
        'loginST': (context) => Login(),
        'loginTea': (context) => LoginTeacher(),
        "homeTeacher": (context) => TeacherhomeScreen(),
        'teacherreg': (context) => RegistrationTeacher(),
        'teacherreg2': (context) => Registrationteacher2(),
        'favourite': (context) => favourite(),
        'profileinfo': (context) => StudentInfo(),
      },
    );
  }
}
