class TaskModel {
  String id;
  String title;
  String desc;
  int time;
  bool isDone;
  TaskModel(
      {this.id = "",
      required this.title,
      required this.time,
      required this.desc,
      required this.isDone});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json["id"],
        title: json['title'],
        time: json['time'],
        desc: json["desc"],
        isDone: json["isDone"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "desc": desc,
      "title": title,
      "time": time,
      "isDone": isDone
    };
  }
}
