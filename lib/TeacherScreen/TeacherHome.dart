
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject2/classes/Teacher.dart';
import 'package:image_picker/image_picker.dart';
import '../firstpage.dart';
import '../main.dart';
import '../services/Api_helper.dart';
import 'package:http/http.dart' as http;

class TeacherhomeScreen extends StatefulWidget {
  int? teacherId;
  Teacher? teacher;
  TeacherhomeScreen({this.teacherId, this.teacher, Key? key}) : super(key: key);

  @override
  State<TeacherhomeScreen> createState() => _TeacherhomeScreenState();
}


TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _usernameController = TextEditingController();
TextEditingController _cityController = TextEditingController();
TextEditingController _subjectController = TextEditingController();
TextEditingController _priceperhourController = TextEditingController();
TextEditingController _pricepercourseController = TextEditingController();
TextEditingController _descrptionController = TextEditingController();

class _TeacherhomeScreenState extends State<TeacherhomeScreen> {


  static Future<void> postDescription({ required String description}) async {
    final dio = Dio();
    try {
      final response = await dio.post(
        "${APIHelper
            .baseUrl}teachers/${sharedPreferences.getInt("teacherId")!.toInt()}/description",
        queryParameters: {"description": description},
      );
      if (response.statusCode == 200) {
        print("Description posted successfully");
      } else {
        // Error
        print("Failed to post description: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
  bool _isEditing = false;
 updateData() async {
    if (_isEditing == true) {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'PUT',
          Uri.parse(
            "${APIHelper
                .baseUrl}teachers/${sharedPreferences.getInt("teacherId")!.toInt()}",
          ));
      request.body = json.encode({
        "firstName": _nameController.text,
        "lastName": widget.teacher?.lastName,
        "username": _usernameController.text,
        "password": widget.teacher?.password,
        "email": _emailController.text,
        "phoneNumber": widget.teacher?.phoneNumber,
        "city": _cityController.text,
        "targetedStudents": widget.teacher?.targetedStudents,
        "teachingWays": widget.teacher?.teachingWays,
        "materials": [
          {
            "category": "SCHOOL",
            "title": _subjectController.text,
            "stages": ["thirdClass"],
            "pricePerHour": _priceperhourController.text,
            "pricePerCourse": _pricepercourseController.text,
          }
        ]
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('ok');
        print(await response.stream.bytesToString());
        getData();
        _isEditing = false;
        setState(() {

        });
      }
      else {
        print('errr');

      }
    } else {
      setState(() {
        _isEditing = true;
      });
    }
  }


  Teacher? teacher;

  Color colorFavourite = Colors.white;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
  }

  getData() {
    TeacherServices.getTeacherdata(
            idTeacher:
                sharedPreferences.getInt('teacherId')!.toInt()) // id of teacher
        .then((value) {
      widget.teacher = value;
      _nameController.text = widget.teacher?.firstName.toString() ?? " ";
      _cityController.text = widget.teacher?.city.toString() ?? " ";
      _emailController.text = widget.teacher?.email.toString() ?? " ";
      _usernameController.text = widget.teacher?.username.toString() ?? " ";
      _subjectController.text =
          widget.teacher?.materials![0].title.toString() ?? " ";
      _priceperhourController.text =
          widget.teacher?.materials![0].pricePerHour.toString() ?? " ";
      _pricepercourseController.text =
          widget.teacher?.materials![0].pricePerCourse.toString() ?? " ";
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: color,
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'المعلومات الشخصية',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Tab(
                  child: Text(
                    'الحصص',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Tab(
                  child: Text(
                    'الجزءالعريفي',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: ListView(children: <Widget>[
                  Center(
                    child: Stack(

                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                          )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _isEditing
                      ? TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'الاسم ',
                            hintText:
                                '${widget.teacher?.firstName.toString() ?? ""}',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            _nameController.text = value;
                            // setState(() {});
                          })
                      : Center(
                          child: Text(
                            'الاسم : ${widget.teacher?.firstName.toString() ?? ""}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _isEditing
                      ? TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "اللبريد الالكتروني",
                            hintText:
                                '${widget.teacher?.email.toString() ?? ""}',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _emailController.text = value;
                            // setState(() {});
                          })
                      : Center(
                          child: Text(
                            'البريد الالكتروني : ${widget.teacher?.email.toString() ?? ""}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _isEditing
                      ? TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'اسم المستخدم',
                            hintText:
                                '${widget.teacher?.username.toString() ?? "  "}',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _usernameController.text = value;
                            //setState(() {});
                          },
                        )
                      : Center(
                          child: Text(
                            'اسم المستخدم : ${widget.teacher?.username.toString() ?? "  "}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  _isEditing
                      ? TextField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText:
                                '${widget.teacher?.city.toString() ?? "  "}',
                            labelText: 'المحافظة',
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _cityController.text = value;
                            // setState(() {
                            //
                            // });
                          })
                      : Center(
                          child: Text(
                            'المحافظة : ${widget.teacher?.city.toString() ?? "  "}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              color // Use the app's primary color for the button
                          ),
                      onPressed:  () async  {
                         updateData();
                      },
                      child: Text(
                        _isEditing == true ? 'حفظ' : 'تعديل',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView(children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: widget.teacher?.materials?.length ?? 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            _isEditing
                                ? TextField(
                                    controller: _subjectController,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'المادة',
                                      hintText:
                                          '${widget.teacher?.materials![index].title?.toString() ?? " "}',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    onChanged: (value) {
                                      setState(() {});
                                    })
                                : Center(
                                    child: Text(
                                      ' المادة : ${widget.teacher?.materials![index].title?.toString() ?? " "}',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            _isEditing
                                ? TextField(
                                    controller: _priceperhourController,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'السعر',
                                      hintText:
                                          '${widget.teacher?.materials![index].pricePerHour?.toString() ?? " "}',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    onChanged: (value) {
                                      var x = double.parse(value);
                                      _priceperhourController.text =
                                          x.toString();
                                      setState(() {});
                                    },
                                  )
                                : Center(
                                    child: Text(
                                        'السعر للساعة : ${widget.teacher?.materials![index].pricePerHour?.toString() ?? " "}',
                                        style: TextStyle(fontSize: 20)),
                                  ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            _isEditing
                                ? TextField(
                                    controller: _pricepercourseController,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: ' السعر للدورة',
                                      hintText:
                                          '${widget.teacher?.materials![index].pricePerCourse?.toString() ?? " "}',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    onChanged: (value) {
                                      var x = double.parse(value);
                                      _pricepercourseController.text =
                                          x.toString();
                                      setState(() {});
                                    },
                                  )
                                : Center(
                                    child: Text(
                                        'السعر للدورة : ${widget.teacher?.materials![index].pricePerCourse?.toString() ?? " "}',
                                        style: TextStyle(fontSize: 20)),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      color, // Use the app's primary color for the button
                                ),
                                onPressed: () {
                                  updateData();
                                },
                                child: Text(
                                    _isEditing == true ? 'حفظ' : 'تعديل',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                   const  SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _descrptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'اكتب ما يميزك',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              color,
                        ),
                        onPressed: () async {
                          postDescription(description: _descrptionController.text );
                          //await postDescription(description: _descrptionController.text);
                          },
                        child: Text('حفظ', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
