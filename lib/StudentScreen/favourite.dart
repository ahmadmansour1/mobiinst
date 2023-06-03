// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:graduationproject2/firstpage.dart';

import '../classes/Teacher.dart';
import '../classes/favaurite.dart';
import '../main.dart';
import '../services/Api_helper.dart';
import 'package:http/http.dart' as http;


class favourite extends StatefulWidget {
  const favourite({Key? key}) : super(key: key);

  @override
  State<favourite> createState() => _favouriteState();
}
List<Favourite> filteredTeachers = [];
class _favouriteState extends State<favourite> {
  List<Favourite> currentFavourite = [];

  @override
  void initState() {
    super.initState();
    print(sharedPreferences.getInt("CurrentStudent")!.toInt());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
  }
  getData(){
    RateAndFavourite.getFavourite(
        idStudent: sharedPreferences.getInt("CurrentStudent")!.toInt())
        .then((value) {
      currentFavourite = value;
      filteredTeachers = currentFavourite;
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        appBar: AppBar(title: Text('المفضلة'), backgroundColor:color),
        body: currentFavourite.isEmpty
            ? Center(
          child: Text('لا يوجد مفضلة' , style: TextStyle(fontSize: 40 , fontWeight:FontWeight.bold),),
        )
            :  Padding(
          padding: const EdgeInsets.only(top : 10),
              child: ListView.builder(
              itemCount: currentFavourite.length,
              itemBuilder: (BuildContext context, index) {

                return Container(
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


                          Text(
                            ' المادة: ${filteredTeachers[index].materials?[0].title ?? " "}', // names of teachers
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
                                    Text(
                                      'التقييم : ${filteredTeachers[index].rateAvg}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10,),
                                    TextButton(
                                        onPressed: () async {
                                          print(sharedPreferences.getInt("CurrentStudent")!.toInt());
                                          print(currentFavourite[index]);
                                          var request = http.Request('DELETE', Uri.parse('${APIHelper.baseUrl}students/${sharedPreferences.getInt("CurrentStudent")!.toInt()}/favorite?teacherId=${currentFavourite[index].id!.toInt()}'));
                                          request.body = '''''';

                                          http.StreamedResponse response = await request.send();

                                          if (response.statusCode == 200) {
                                            getData();
                                            print(await response.stream.bytesToString());
                                          }
                                          else {
                                            print(response.reasonPhrase);
                                          }// RateAndFavourite.deleteFavourite(idStudent: sharedPreferences.getInt("CurrentStudent")!.toInt(), idTeacher:currentFavourite[index].id!.toInt());


                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )),


                                ],
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                "نوع التدريس : ${ filteredTeachers[index]
                                    .teachingWays
                                    .toString()
                                    .replaceAll("[ONLINE]", "عن بعد")
                                    .replaceAll("[ONSITE]", "وجاهي")
                                    .replaceAll("[ONLINE, ONSITE]", "عن بعد , وجاهي")}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),

                            ],
                          ),


                        ],
                      ),
                    )

                );
              },
          ),
            ),
        ),
    );

  }
}
