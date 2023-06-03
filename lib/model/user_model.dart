class UserModel{
  String email;
  String nameEN;
  String nameAR;
  String collegeEN;
  String collegeAR;
  String pic;
  String uid;

  UserModel({
    required this.email,
    required this.nameEN,
    required this.nameAR,
    required this.collegeEN,
    required this.collegeAR,
    required this.pic,
    required this.uid,
  });
  factory UserModel.fromJson(Map<String,dynamic> json)=> UserModel(
    email: json["email"],
    nameEN: json["nameEN"],
    nameAR: json["nameAR"],
    collegeEN: json["collegeEN"],
    collegeAR: json["collegeAR"],
    pic: json["pic"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "email":email,
    "nameEN": nameEN,
    "nameAR": nameAR,
    "collegeEN":collegeEN,
    "collegeAR":collegeAR,
    "pic":pic,
    "uid":uid,
  };
}