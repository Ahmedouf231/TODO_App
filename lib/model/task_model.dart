class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool isDone;
  String userId;

  TaskModel(
      {required this.date,
      required this.description,
      this.isDone = false,
      required this.title,
      this.id = '' , 
      required this.userId
      });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            date: json['date'],
            description: json['description'],
            id: json['id'],
            isDone: json['isDone'] , 
            userId: json['userId']
            );

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "date": date,
      "description": description,
      "id": id,
      "isDone": isDone, 
      "userId" : userId
    };
  } 
  
}
