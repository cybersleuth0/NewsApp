class SourceModel {
  String? id;
  String? name;

  SourceModel({required this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(id: json["id"], name: json["name"]);
  }
}

class ArticleModel {
  String? author;
  String? content;
  String? description;
  String? publishedAt;
  SourceModel source;
  String? title;
  String? url;
  String? urlToImage;

  ArticleModel({
    required this.author,
    required this.content,
    required this.description,
    required this.publishedAt,
    required this.source,
    required this.title,
    required this.url,
    required this.urlToImage,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
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

class NewsDataModel {
  String? status;
  int? totalResults;
  List<ArticleModel> articles;

  NewsDataModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsDataModel.fromJson(Map<String, dynamic> json){
    List<ArticleModel> articles = [];
    for(Map<String,dynamic> eachnews in json["articles"]){
      articles.add(ArticleModel.fromJson(eachnews));
    }

    return NewsDataModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: articles
    );
  }
}