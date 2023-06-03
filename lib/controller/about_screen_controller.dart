import 'package:get/get.dart';

class AboutScreenController extends GetxController{
  String aboutText ="Hello, We are a group of students from the King Abdullah II College of Information Technology from the Department of Computer Science. We have developed this news application for the University of Jordan, as it will target all categories of students, doctors and workers. We hope that this application will be of interest.";
List<Map<String, dynamic>> teamMembers =[
  {
      "name": "Musa Abu Jazouh",
      "nameAR": "موسى أبو جازوه",
      "pic": "assets/images/musa.jfif",
    },
  {
      "name": "Ahmad alabbadi",
    "nameAR": "احمد العبادي",
    "pic": "assets/images/ahmad.jfif",
    },
  {
      "name": "Rayan Asad",
    "nameAR": "ريان أسعد",
    "pic": "assets/images/rayan.jfif",
    },
  {
      "name": "Ela Quniebi",
    "nameAR": "ايلا القنيبي",
    "pic": "assets/images/ela.jfif",
    },

  ];
}