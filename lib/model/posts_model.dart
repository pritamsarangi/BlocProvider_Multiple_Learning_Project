class PostsModel {
  int? postId;
  int? id;
  String? email;
  String? name;
  String? body;

  PostsModel({this.postId, this.id, this.name,this.email, this.body});

  PostsModel.fromJson(Map<String, dynamic> json) {
    postId = json['userId'];
    id = json['id'];
    email = json['email'];
    name = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.postId;
    data['id'] = this.id;
    data['email'] = this.email;
    data['title'] = this.name;
    data['body'] = this.body;
    return data;
  }
}
