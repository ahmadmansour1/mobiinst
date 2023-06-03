class Student {
 final int id;
 final String firstName;
 final String lastName;
 final String gender;
 final String username;
 final String password;
 final  String status;
 final String email;
 final String image;

  Student(
      {this.id= 0,
        this.firstName = " ",
        this.lastName = " ",
        this.gender = " ",
        this.username = " ",
        this.password = " ",
        this.status = " ",
        this.email = " ",
        this.image =  " "});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
    id : json['id'] ?? 0,
    firstName : json['firstName']?? " ",
    lastName : json['lastName']?? " ",
    gender : json['gender']?? " ",
    username : json['username']?? " ",
    password : json['password']?? " ",
    status : json['status']?? " ",
    email : json['email']?? " ",
    image : json['image']?? " ",
    );}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['username'] = username;
    data['password'] = password;
    data['status'] = status;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}