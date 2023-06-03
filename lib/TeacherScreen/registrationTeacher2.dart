// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:graduationproject2/TeacherScreen/TeacherHome.dart';
import 'package:graduationproject2/classes/Teacher.dart';
import 'package:graduationproject2/firstpage.dart';
import 'package:graduationproject2/services/api_helper.dart';

import '../classes/Material.dart';
import '../main.dart';

class Registrationteacher2 extends StatefulWidget {
  Teacher? teacher;
  Registrationteacher2({this.teacher, Key? key}) : super(key: key);

  @override
  State<Registrationteacher2> createState() => _Registrationteacher2State();
}

class _Registrationteacher2State extends State<Registrationteacher2> {
  String? _validatepricehour(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    return null;
  }

  String? _validatepricecourse(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    return null;
  }

  String? _validatesubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    return null;
  }

  String? _validatcity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your city';
    }
    return null;
  }

  String _gender = '';

  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;
  final _priceperhourController = TextEditingController();
  final _pricepercourseController = TextEditingController();
  final _cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _subject = TextEditingController();
  List<Subject>? subjects = [];
  List<String>? teachingWays = [];
  List<String>? targetedStudents = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 70.0),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: ' المحافظة',

                      border: OutlineInputBorder(),
                      filled: true,
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    validator: _validatcity,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _subject,
                    onChanged: (value) {
                      subjects = [Subject(title: value.toString())];
                    },
                    decoration: InputDecoration(
                      labelText: 'المادة',
                      border: OutlineInputBorder(),
                      filled: true,
                      prefixIcon: Icon(Icons
                          .subject),
                    ),
                    validator: _validatesubject,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _priceperhourController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: ' السعر للساعة',
                      border: OutlineInputBorder(),
                      filled: true,
                      prefixIcon: Icon(Icons.price_change),
                    ),
                    onChanged: (value) { // missunderstand
                      subjects = [
                        Subject(pricePerHour: double.parse(value.toString()))
                      ];
                    },
                    validator: _validatepricehour,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _pricepercourseController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      double.parse(value);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: ' السعر للمادة ',
                      border: OutlineInputBorder(),
                      filled: true,
                      prefixIcon: Icon(Icons
                          .price_change),
                    ),
                    validator: _validatepricecourse,
                  ),
                  SizedBox(height: 20.0),
                  FormField<bool>(
                    builder: (FormFieldState<bool> state) {
                      return Row(
                        children: [
                          const Text(
                            'طريقة التدريس:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Checkbox(
                            value: _isChecked1,
                            onChanged: (bool? newValue) {
                              setState(() {
                                if (newValue == true) {
                                  teachingWays!.addAll(["ONSITE"]);
                                } else {
                                  teachingWays!.remove("ONSITE");
                                }
                                print(teachingWays);

                                print(newValue);
                                _isChecked1 = newValue ?? true;
                                state.didChange(newValue);
                              });
                            },
                          ),
                          Text('وجاهي',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 20),
                          Checkbox(
                            value: _isChecked2,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isChecked2 = newValue ?? true;

                                if (newValue == true) {
                                  teachingWays!.addAll(["ONLINE"]);
                                } else {
                                  teachingWays!.remove("ONLINE");
                                }
                                print(teachingWays);
                                print(newValue);
                                state.didChange(newValue);
                              });
                            },
                          ),
                          Text('عن بعد',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      );
                    },
                    // validator: (value) {
                    //   if (!_isChecked1 && !_isChecked2) {
                    //     return 'Please check at least one option';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(height: 20.0),
                  FormField<bool>(
                    builder: (FormFieldState<bool> state) {
                      return Row(
                        children: [
                          const Text(
                            'الطلبة المستهدفين:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Checkbox(
                            value: _isChecked3,
                            onChanged: (bool? newValue) {
                              if (newValue == true) {
                                targetedStudents!.add("MALE");
                              } else {
                                targetedStudents!.remove("MALE");
                              }

                              print(targetedStudents);
                              _isChecked3 = newValue ?? true;
                              state.didChange(newValue);
                              setState(() {});
                            },
                          ),
                          Text('ذكر',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 20),
                          Checkbox(
                            value: _isChecked4,
                            onChanged: (bool? newValue) {
                              if (newValue == true) {
                                targetedStudents!.add("FEMALE");
                              } else {
                                targetedStudents!.remove("FEMALE");
                              }

                              _isChecked4 = newValue ?? true;
                              state.didChange(newValue);

                              print(targetedStudents);
                              setState(() {});
                            },
                          ),
                          Text('انثى',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      );
                    },
                    // validator: (value) {
                    //   if (!_isChecked3 && !_isChecked4) {
                    //     return 'Please check at least one option';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  Row(children: <Widget>[
                    Text('الجنس'),
                    Radio(

                      value: 'MALE',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!.toUpperCase();
                        });
                      },
                    ),
                    Text('ذكر'),
                    Radio(
                      value: 'FEMALE',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!.toUpperCase();
                        });
                      },
                    ),
                    Text('انثى'),
                  ]),
                   SizedBox(height: 30,),
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print(teachingWays);
                          TeacherServices.regsiterTeacher(
                            firstName: widget.teacher!.firstName,
                            lastName: widget.teacher!.firstName,
                            gender: _gender,
                            username: widget.teacher!.username,
                            password: widget.teacher!.password,
                            email: widget.teacher!.email,
                            city: _cityController.text,
                            phoneNumber: widget.teacher!.phoneNumber.toString(),
                            teachingWays: teachingWays,
                            targetedStudents: targetedStudents,
                            title: _subject.text,
                            pricePerHour: _priceperhourController.text,
                            pricePerCourse: _pricepercourseController.text,
                          ).then((value) async {
                            if (value.id != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TeacherhomeScreen(teacher: value),
                                  ));
                            } else {

                              print("Error shady");
                            }

                          });
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
