class Ad {
  String id = DateTime.now().toString();
  String title = '';
  String content = '';
  String imgURL = '';
  Ad({required this.title, required this.content, required this.imgURL});

  Ad.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    imgURL = json['imgURL'];
  }
  toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['title'] = title;
    json['content'] = content;
    json['imgURL'] = imgURL;
    return json;
  }
}
