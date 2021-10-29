
class UserData{
  int? id;
  String? first_name;
  String? last_name;
  String? username;
  String? last_seen_time;
  String? avatar;
  String? status;
  int? messages;

  UserData(
    {
      this.id, this.first_name, this.last_name, this.username,
  this.last_seen_time, this.avatar, this.status, this.messages
  });

    UserData.fromJson(Map<String,dynamic> json)
    {
      id = json['id'];
      first_name = json['first_name'];
      last_name = json['last_name'];
      username = json['username'];
      last_seen_time = json['last_seen_time'];
      avatar = json['avatar'];
      status = json['status'];
      messages = json['messages'];

    }
}