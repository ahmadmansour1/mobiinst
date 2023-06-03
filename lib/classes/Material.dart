class Subject  {
  String? title;
  String? category;
  double? pricePerHour;
  int? pricePerCourse;
  List<String>? stages;

  Subject(
      {this.title,
      this.category,
      this.pricePerHour,
      this.pricePerCourse,
      this.stages});

  Subject.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    category = json['category'];
    pricePerHour = json['pricePerHour'];
    pricePerCourse = json['pricePerCourse'];
    stages = json['stages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['category'] = this.category;
    data['pricePerHour'] = this.pricePerHour;
    data['pricePerCourse'] = this.pricePerCourse;
    data['stages'] = this.stages;
    return data;
  }
}