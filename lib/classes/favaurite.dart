class Favourite {
  int? id;
  String? firstName;
  String? lastName;
  String? gender;
  String? username;
  String? password;
  String? status;
  String? email;
  Null? image;
  String? description;
  String? phoneNumber;
  String? city;
  List<String>? targetedStudents;
  List<String>? teachingWays;
  double? rateAvg;
  List<Materials>? materials;

  Favourite(
      {this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.username,
      this.password,
      this.status,
      this.email,
      this.image,
      this.description,
      this.phoneNumber,
      this.city,
      this.targetedStudents,
      this.teachingWays,
      this.rateAvg,
      this.materials});

  Favourite.fromJson(Map<String, dynamic> json) {
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
    targetedStudents = json['targetedStudents'].cast<String>();
    teachingWays = json['teachingWays'].cast<String>();
    rateAvg = json['rateAvg'];
    if (json['materials'] != null) {
      materials = <Materials>[];
      json['materials'].forEach((v) {
        materials!.add(new Materials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['password'] = this.password;
    data['status'] = this.status;
    data['email'] = this.email;
    data['image'] = this.image;
    data['description'] = this.description;
    data['phoneNumber'] = this.phoneNumber;
    data['city'] = this.city;
    data['targetedStudents'] = this.targetedStudents;
    data['teachingWays'] = this.teachingWays;
    data['rateAvg'] = this.rateAvg;
    if (this.materials != null) {
      data['materials'] = this.materials!.map((v) => v.toJson()).toList();
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
  dynamic pricePerCourse;
  Null? teacher;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['title'] = this.title;
    data['stages'] = this.stages;
    data['pricePerHour'] = this.pricePerHour;
    data['pricePerCourse'] = this.pricePerCourse;
    data['teacher'] = this.teacher;
    return data;
  }
}
