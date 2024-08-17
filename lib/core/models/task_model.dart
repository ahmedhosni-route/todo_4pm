class TaskModel {
  String id;
  String title;
  String desc;
  int date;
  String time;
  bool isDone;
  TaskModel(
      {this.id = "",
      required this.title,
      required this.date,
      required this.desc,
      required this.time,
      required this.isDone});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json["id"],
        title: json['title'],
        date: json['date'],
        desc: json["desc"],
        time: json["time"],
        isDone: json["isDone"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "desc": desc,
      "title": title,
      "time": time,
      "date": date,
      "isDone": isDone
    };
  }
}
