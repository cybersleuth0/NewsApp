class SourceModel {
  String? id;
  String? name;

  SourceModel({required this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(id: json["id"], name: json["name"]);
  }
}

class SourceDataModel {
  String? author;
  String? content;
  String? description;
  String? publishedAt;
  SourceModel source;
  String? title;
  String? url;
  String? urlToImage;

  SourceDataModel({
    required this.author,
    required this.content,
    required this.description,
    required this.publishedAt,
    required this.source,
    required this.title,
    required this.url,
    required this.urlToImage,
  });

  factory SourceDataModel.fromJson(Map<String, dynamic> json) {
    return SourceDataModel(
      author: json["author"],
      content: json["content"],
      description: json["description"],
      publishedAt: json["publishedAt"],
      source: SourceModel.fromJson(json["source"]),
      title: json["title"],
      url: json["url"],
      urlToImage: json["urlToImage"],
    );
  }
}
