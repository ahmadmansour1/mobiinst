class Teacher {
  int? id;
  String? firstName;
  String? lastName;
  String? gender;
  String? username;
  String? password;
  String? status;
  String? email;
  String? image;
  String? description;
  String? phoneNumber;
  String? city;
  List<dynamic>? targetedStudents;
  List<dynamic>? teachingWays;
  double? rateAvg;
  List<Materials>? materials;

  Teacher(
      {this.id = 0,
      this.firstName = "",
      this.lastName = "",
      this.gender = "",
      this.username = "",
      this.password = "",
      this.status = "",
      this.email = "",
      this.image = "",
      this.description = "",
      this.phoneNumber = "",
      this.city = "",
      this.targetedStudents = const [],
      this.teachingWays = const [],
      this.rateAvg = 0.0,
      this.materials = const []});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    username = json['username'];
    password = json['password'];
    status = json['status'];
    email = json['email'];
    image = json['image'];
    description = json['description'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    targetedStudents = json['targetedStudents'];
    teachingWays = json['teachingWays'];
    rateAvg = json['rateAvg'];
    if (json['materials'] != null) {
      materials = <Materials>[];
      json['materials'].forEach((v) {
        materials!.add(Materials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['username'] = username;
    data['password'] = password;
    data['status'] = status;
    data['email'] = email;
    data['image'] = image;
    data['description'] = description;
    data['phoneNumber'] = phoneNumber;
    data['city'] = city;
    data['targetedStudents'] = targetedStudents;
    data['teachingWays'] = teachingWays;
    data['rateAvg'] = rateAvg;
    if (materials != null) {
      data['materials'] = materials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Materials {
  int? id;
  String? category;
  String? title;
  List<String>? stages;
  double? pricePerHour;
  double ? pricePerCourse;
  String? teacher;

  Materials(
      {this.id,
      this.category,
      this.title,
      this.stages,
      this.pricePerHour,
      this.pricePerCourse,
      this.teacher});

  Materials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    title = json['title'];
    stages = json['stages'].cast<String>();
    pricePerHour = json['pricePerHour'];
    pricePerCourse = json['pricePerCourse'];
    teacher = json['teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['category'] = category;
    data['title'] = title;
    data['stages'] = stages;
    data['pricePerHour'] = pricePerHour;
    data['pricePerCourse'] = pricePerCourse;
    data['teacher'] = teacher;
    return data;
  }
}
