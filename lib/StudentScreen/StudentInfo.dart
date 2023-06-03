// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduationproject2/TeacherScreen/TeacherHome.dart';
import 'package:graduationproject2/firstpage.dart';

import '../classes/Student.dart';
import '../main.dart';
import '../services/Api_helper.dart';
import 'package:http/http.dart' as http;

class StudentInfo extends StatefulWidget {
  int? studentId;
  Student? student;
  StudentInfo({this.studentId, this.student, Key? key}) : super(key: key);
  @override
  State<StudentInfo> createState() => _StudentInfoState();
}
// Student ? student = Student(
//   username: student!.username,
//   firstName: student!.firstName,
//   lastName: student!.lastName,
//   email: student!.email,
// );


bool _isEditing = false;
late String password;
late String gender;

late TextEditingController _nameController = TextEditingController();
late TextEditingController _lastnameController = TextEditingController();
late TextEditingController _emailController = TextEditingController();
late TextEditingController _usernameController = TextEditingController();
late TextEditingController _passwordController = TextEditingController();
class _StudentInfoState extends State<StudentInfo> {

  void updateStudentInfo() async {
    if (_isEditing == true) {

      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('PUT', Uri.parse('http://192.168.1.41:8080/api/v1/students/${sharedPreferences.getInt(
          "CurrentStudent")!.toInt()}'));
      request.body = json.encode({
        "firstName": _nameController.text,
        "lastName":sharedPreferences.getString("lastName"),
        "username": _usernameController.text,
        "password": sharedPreferences.getString("password"),
        "email" : _emailController.text
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        getData();
        _isEditing = false;
        setState(() {
        });
        print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }


    } else {
      setState(() {
        _isEditing = true;
      });
    }
  }

  Student ? student ;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      getData();
    });
  }
 getData(){
   StudentServices.getStudentbyid(idStudent:sharedPreferences.getInt(
       "CurrentStudent")!.toInt()) // id of teacher
       .then((value) {
     student = value;
     _nameController.text = student?.firstName.toString() ?? " " ;
     _nameController.text = student?.lastName.toString() ?? " ";
     _emailController.text = student?.email.toString() ?? " ";
     _usernameController.text = student?.username.toString() ?? " ";
     setState(() {});
   });

  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

         appBar: AppBar(
      title: Center(child: Padding(
      padding: const EdgeInsets.only(left: 60),
      child: const Text('الصفحة الشخصية' , style: TextStyle(fontWeight: FontWeight.bold),),
    )),
    backgroundColor: color,
    ),
        body:
      Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 100),
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
          height:40.0,
        ),
        _isEditing
            ? TextField(
          controller: _nameController,

            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'الاسم',
              hintText: ' ${student?.firstName.toString() ?? " "} ' ,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            onChanged: (value) {
              setState(() {});
            }
            )
            : Center(
          child: Text(' الاسم: ${student?.firstName.toString() ?? " "} ', style:TextStyle(fontSize: 25,),)
        ),
        const SizedBox(
          height: 30.0,
        ),
        _isEditing
            ? TextField(
          controller: _emailController,
            decoration: InputDecoration(
              labelText: 'email',
              hintText: '${student?.email.toString() ?? " "}',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {});
            })
            : Center(
          child: Text(' البريد الالكتروني: ${student?.email.toString() ?? " "}', style:TextStyle(fontSize: 25,),),
        ),
        const SizedBox(
          height: 30.0,
        ),
        _isEditing
            ? TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'اسم المستخدم',
            hintText: '${student?.username.toString() ?? " "}',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) {
           setState(() {});
          },
        )

            : Center(
          child: Text('اسم المستخدم:  ${student?.username.toString() ?? " "} ', style:TextStyle(fontSize: 25,),),
        ),
        const SizedBox(
          height: 16.0,
        ),

        const SizedBox(
          height: 20.0,
        ),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,// Use the app's primary color for the button
            ),
            onPressed:() {
    updateStudentInfo();
    },
              child: Text(_isEditing == true ? 'حفظ' : 'تعديل', style: TextStyle(fontSize:20
              ),
              ),
            ),
        ),
      ]
      ),
    ),
    )
    );
  }
}
