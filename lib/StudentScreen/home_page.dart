import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduationproject2/classes/Teacher.dart';
import 'package:graduationproject2/classes/favaurite.dart';
import 'package:graduationproject2/firstpage.dart';
import 'package:graduationproject2/main.dart';
import 'package:graduationproject2/services/Api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
bool isFavourite = false;
class _HomeScreenState extends State<HomeScreen> {

  TextEditingController  _reviewController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _secondNameController = TextEditingController();
  TextEditingController _priceHourController = TextEditingController();
  TextEditingController _priceCourseController = TextEditingController();
  TextEditingController _lecTitleController = TextEditingController();

  double rating = 0.0;
  String review = "";
  List<Teacher> teachers = [];
  List<Teacher> filteredTeachers = [];
  List<Favourite> currentFavourite = [];
  List<bool> listOfNewItems = [];
  bool isFavorite = false;

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      TeacherServices.fetchTeachers().then((value) {
        teachers = value;
        filteredTeachers = teachers;
        setState(() {});
      });
      RateAndFavourite.getFavourite(
              idStudent: sharedPreferences.getInt("CurrentStudent")!.toInt())
          .then((value) {
        currentFavourite = value;
        setState(() {});
      });

    });
  }
  String filterFirstName = '';
  String filterLastName = '';
  String filterCity = '';
  String lecFilter = "";
  double priceHourfilter  = 0;
  double priceCoursefilter = 0  ;

void filterData() {
  filteredTeachers = [];
  for (var tech in teachers) {
    if (lecFilter == tech.materials![0].title ||
        filterFirstName == tech.firstName
        || filterCity == tech.city ||
        priceHourfilter == tech.materials![0].pricePerHour
        || priceHourfilter == tech.materials![0].pricePerCourse) {

      setState(() {
        filteredTeachers.add(tech);
      });
    }
  }
}
void resetData(){
  setState(() {
    _formKey.currentState!.reset();
    filterFirstName = "";
    filterLastName =  "";
    filterCity =  "";
    lecFilter =  "";
    priceCoursefilter = 0;
    priceHourfilter = 0;
    filteredTeachers = teachers;
  });

}

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Padding(
            padding: const EdgeInsets.only( right: 40),
            child: Row(
              children: [
                Text('الصفحة الرئيسة' ,  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold
                ) ), SizedBox(width:60),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        builder: (context) => Column(
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding:  EdgeInsets.all(25),

                                child: Form(
                                  key : _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _firstNameController,
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                                hintText: 'الاسم الاول',

                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width:6,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _secondNameController,
                                              onChanged: (value) {

                                              },
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                                hintText: 'الاسم التاني',
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 25),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _priceHourController,
                                              keyboardType: TextInputType.number,
                                              onChanged: ( value) {
                                                setState(() {
                                                });
                                              },
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                                hintText: 'السعر للساعة', //السعر
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _priceCourseController,
                                              keyboardType: TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                                hintText: 'السعر للدورة', //السعر
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 25),
                                      TextFormField(
                                        controller: _lecTitleController,
                                        onChanged: (value) {},
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                          hintText: 'المادة',
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                        ),
                                      ),
                                      SizedBox(height: 25),
                                      TextFormField(
                                        controller: _cityController,
                                        onChanged: (value) {
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                          hintText: 'المدينة',
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                        ),
                                      ),
                                      SizedBox(height: 25),
                                      Container(
                                        padding: EdgeInsets.only(top: 20.0),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  filterFirstName = _firstNameController.text;
                                                  filterLastName = _secondNameController.text;
                                                  filterCity = _cityController.text;
                                                  lecFilter = _lecTitleController.text;
                                                  if (_priceCourseController.text.isEmpty) {
                                                    priceCoursefilter = 0.0;
                                                  } else {
                                                    priceCoursefilter = double.parse(_priceCourseController.text);
                                                  }
                                                  if (_priceHourController.text.isEmpty) {
                                                    priceHourfilter = 0.0;
                                                  } else {
                                                    priceHourfilter = double.parse(_priceHourController.text);
                                                  }
                                                });
                                                filterData();
                                                Navigator.pop(context); // close bottom sheet
                                              },
                                              child: Text('تاكيد'),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Increase the padding
                                                minimumSize: Size(150, 50), // Increase the width and height
                                                backgroundColor: color, // Use the app's primary color for the button
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0), // Add the desired border radius
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16.0),
                                            ElevatedButton(
                                              onPressed: () {
                                                resetData();



                                                Navigator.pop(context); // close bottom sheet
                                              },
                                              child: Text('reset'),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Increase the padding
                                                minimumSize: Size(150, 50), // Increase the width and height
                                                backgroundColor: Colors.teal, // Use the app's primary color for the button
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0), // Add the desired border radius
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.search)),
              ],
            ),
          )),
          backgroundColor: color,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top : 10),
                child: ListView.builder(
                  itemCount: filteredTeachers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      //constraints: const BoxConstraints(maxWidth: 400),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8.0),
                      height: 300,

                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 8.0),
                              Text(
                                ' الاسم :${filteredTeachers[index].firstName} ${filteredTeachers[index].lastName} ', // names of teachers
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              // const SizedBox(height: 5.0),

                              Text(
                                ' المادة: ${filteredTeachers[index].materials?[0].title ?? ""}', // names of teachers
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Divider(color: Colors.black, height: 10, thickness: 1,),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 90.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          ' السعر للدورة:${filteredTeachers[index].materials?[0].pricePerCourse ?? " "}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' السعر للساعة:${filteredTeachers[index].materials?[0].pricePerHour ?? " "}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),

                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 90,),
                                  Column(
                                    children: [
                                      Text(
                                        ' الرقم : ${filteredTeachers[index].phoneNumber ?? " "}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height:8 ,),
                                      Text(
                                        ' المدينة :${filteredTeachers[index].city}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10,),
                                      TextButton(
                                        onPressed: () => showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>

                                                Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: AlertDialog(
                                                    title: const Text('تقييم'),
                                                    content: Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      height: MediaQuery.of(context).size.height*.12,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            controller: _reviewController,
                                                            onChanged: (value){
                                                              setState(() {

                                                              });
                                                            },
                                                            decoration: const  InputDecoration(
                                                              labelText: 'تقييم',
                                                              border: const OutlineInputBorder(),
                                                              filled: true,



                                                            ),
                                                            style: TextStyle(fontFamily: 'Montserrat'),
                                                            // Use a custom font
                                                          ),
                                                          const Text(
                                                              'قيم هنا'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      RatingBar.builder(
                                                          initialRating: 0,
                                                          minRating: 0.5,
                                                          direction:
                                                          Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 4.0),
                                                          itemSize: 25.0,
                                                          itemBuilder: (context,
                                                              index) =>
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate: (value) {
                                                            rating = value;
                                                            setState(() {});
                                                            print(rating);
                                                          }),
                                                      TextButton(
                                                        onPressed: () async {
                                                          var headers = {
                                                            'Content-Type': 'application/json'
                                                          };
                                                          var request = http.Request('POST', Uri.parse('http://192.168.1.41:8080/api/v1/evaluations'));
                                                          request.body = json.encode({
                                                            "rate": rating.toInt(),
                                                            "review": _reviewController.text,
                                                            "teacherId": filteredTeachers[index].id,
                                                            "studentId": sharedPreferences.getInt("CurrentStudent")!.toInt(),
                                                          });
                                                          request.headers.addAll(headers);

                                                          http.StreamedResponse response = await request.send();
                                                          print(response);

                                                          if (response.statusCode == 200) {
                                                            Navigator.pop(
                                                                context, 'OK'); print("success");
                                                            print(await response.stream.bytesToString());
                                                          }
                                                          else {
                                                            print(response.reasonPhrase);
                                                          }

                                                        }, child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                        child: Text(
                                          filteredTeachers[index].rateAvg != null
                                              ? 'التقييم : ${filteredTeachers[index].rateAvg}'
                                              : 'التقييم',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          var currentIndexItem = currentFavourite
                                              .where((e) => filteredTeachers[index].id == e.id);


                                          if (currentIndexItem.isEmpty) {

                                            RateAndFavourite.postFavourite(
                                                idStudent: sharedPreferences
                                                    .getInt("CurrentStudent")!
                                                    .toInt(),
                                                idTeacher: filteredTeachers[index].id!);

                                          } else {

                                            print(sharedPreferences.getInt("CurrentStudent")!.toInt());
                                            var request = http.Request('DELETE', Uri.parse('http://192.168.1.195:8080/api/v1/${sharedPreferences.getInt("CurrentStudent")!.toInt()}/favorite?teacherId=${filteredTeachers[index].id!.toInt()}'));
                                            request.body = '''''';

                                            http.StreamedResponse response = await request.send();

                                            if (response.statusCode == 200) {
                                              print(await response.stream.bytesToString());
                                            }
                                            else {
                                              print(response.reasonPhrase );
                                            }// RateAndFavourite.deleteFavourite(idStudent: sharedPreferences.getInt("CurrentStudent")!.toInt(), idTeacher:currentFavourite[index].id!.toInt());
                                          }
                                        },
                                        icon:
                                        Icon(Icons.favorite,  color: currentFavourite
                                            .any((e) => filteredTeachers[index].id == e.id)
                                            ? Colors.red
                                            : Colors.grey ),
                                      ),

                                    ],),
                                ],),
                              Row(
                                children: [
                                  Text(
                                    "نوع التدريس : ${ filteredTeachers[index]
                                        .teachingWays
                                        .toString()
                                        .replaceAll("[ONLINE]", "عن بعد")
                                        .replaceAll("[ONSITE]", "وجاهي")
                                        .replaceAll("[ONSITE, ONLINE]", "عن بعد , وجاهي")
                                        .replaceAll("[ONLINE, ONSITE]", "عن بعد , وجاهي")

                                    }",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),],),],),),),)

                    ;},),
              ),),],),
        drawer: Drawer(
          child: Container(
            color: color, // Set the desired color here
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 70.0,
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(Icons.home, color: Colors.white,),
                      SizedBox(width: 10,),
                      Text(
                        'الصفحة الرئيسية',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'Home');
                    // Navigate to home screen
                  },
                ),
                Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: const  Row(
                    children: [
                      Icon(Icons.info , color: Colors.white, ),
                      SizedBox(width: 10,),
                      Text(
                        'معلومات الحساب',
                        style: TextStyle(
                          fontSize: 20.0, // Increase the text size here
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set the desired text color here
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'profileinfo');
                  },
                ),
                Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.white,),
                      SizedBox(width: 10,),
                      Text(
                        'المفضلة',
                        style: TextStyle(
                          fontSize: 20.0, // Increase the text size here
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set the desired text color here
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'favourite');
                  },
                ),
                Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                const SizedBox(height: 250),
                ListTile(
                  leading: Icon(Icons.exit_to_app , color: Colors.white,),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20.0, // Increase the text size here
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set the desired text color here
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'loginST');
                  },
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}

