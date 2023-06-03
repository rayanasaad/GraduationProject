class NewsDataModel{
  String title;
   String titleAR;
  String content;
   String contentAR;
  String urlImage;
  String collegeName;
  int id;
  String audioFileEN;
  String audioFileAR;

  NewsDataModel({
  required this.title,
   required this.titleAR,
  required this.content,
  required this.contentAR,
  required this.urlImage,
   required this.collegeName,
   required this.id,
    required this.audioFileEN,
    required this.audioFileAR,
  });

  factory NewsDataModel.fromJson(Map<String,dynamic> json)=> NewsDataModel(
    title: json["title"],
    titleAR:  json["titleAR"],
    content:  json["content"],
    contentAR:  json["contentAR"],
    urlImage: json["urlImage"],
    collegeName:  json["collegeName"],
    id:  json["id"],
    audioFileEN:  json["audioFileEN"],
    audioFileAR:  json["audioFileAR"],
  );

  Map<String, dynamic> toJson() => {
    "title":title,
    "titleAR": titleAR,
    "content":content,
    "contentAR":contentAR,
    "urlImage":urlImage,
    "collegeName":collegeName,
    "id":id,
    "audioFileEN":audioFileEN,
    "audioFileAR":audioFileAR,
  };
}





