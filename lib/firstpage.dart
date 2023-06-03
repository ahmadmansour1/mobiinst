import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'classes/Student.dart';

const Color color = Color(0xFF177245);


class Firstpge extends StatefulWidget {
  const Firstpge({Key? key}) : super(key: key);

  @override
  State<Firstpge> createState() => _FirstpgeState();
}

class _FirstpgeState extends State<Firstpge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 60 , right: 60 , top: 90 , bottom: 100),
        child: Container(
          height: double.infinity,
          width: double.infinity,

          // width: double.infinity, height: double.infinity,

          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 320,
                child: Center(
                  child: Image.asset(
                    'assets/mobiinstructor-log.png',
                    fit: BoxFit.cover,
                    width: 310,
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
                width: 200,
                child: Center(
                  child: Text(
                    'اهلا بك في تطبيق mobiInstructor',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: color,
                        ),
                        height: 70,
                        width: 300,
                        child: TextButton(
                          onPressed: () async {
                             Navigator.pushNamed(context, 'loginST');
                            //   final response = await Dio().get("http://192.168.1.41:8080/api/v1/students");
                            //
                            //   print(List<Student>.from(
                            //       response.data["content"].map((e) => Student.fromJson(e))));
                             },

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text(
                                'طالب',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                FontAwesomeIcons.graduationCap,
                                color: Colors.white,
                                size: 25.0,
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: color,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, 'loginTea');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  <Widget>[
                            Text(
                              'معلم',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(FontAwesomeIcons.chalkboardTeacher, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
