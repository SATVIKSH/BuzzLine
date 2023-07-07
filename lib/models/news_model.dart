class NewsModel {
  NewsModel(
      {this.image,
      this.author,
      this.description,
      String? date,
      this.title,
      this.url})
      : publishDate = date != null ? DateTime.parse(date) : null;
  String? image;
  String? author;
  String? title;
  String? description;
  String? url;
  DateTime? publishDate;
}
