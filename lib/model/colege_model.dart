
class CollegeModel {
  String name;
  String nameAR;
  String image;
  String logo;

  CollegeModel({
    required this.name,
    required this.nameAR,
    required this.image,
    required this.logo,
});
  factory CollegeModel.fromJson(Map<String,dynamic> json)=> CollegeModel(
  name: json["name"],
  nameAR: json["nameAR"],
  image: json["image"],
  logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "name":name,
    "nameAR": nameAR,
    "image":image,
    "logo":logo,
  };
}
