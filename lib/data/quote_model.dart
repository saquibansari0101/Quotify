
import 'dart:convert';

QuoteModel quoteModelFromJson(String str) => QuoteModel.fromJson(json.decode(str));

String quoteModelToJson(QuoteModel data) => json.encode(data.toJson());

class QuoteModel {
  QuoteModel({
    this.id,
    this.tags,
    this.content,
    this.author,
    this.authorSlug,
    this.length,
    this.dateAdded,
    this.dateModified,
  });

  String? id;
  List<String>? tags;
  String? content;
  String? author;
  String? authorSlug;
  int? length;
  DateTime? dateAdded;
  DateTime? dateModified;

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
    id: json["_id"] == null ? null : json["_id"],
    tags: json["tags"] == null ? null : List<String>.from(json["tags"].map((x) => x)),
    content: json["content"] == null ? null : json["content"],
    author: json["author"] == null ? null : json["author"],
    authorSlug: json["authorSlug"] == null ? null : json["authorSlug"],
    length: json["length"] == null ? null : json["length"],
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
    dateModified: json["dateModified"] == null ? null : DateTime.parse(json["dateModified"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
    "content": content == null ? null : content,
    "author": author == null ? null : author,
    "authorSlug": authorSlug == null ? null : authorSlug,
    "length": length == null ? null : length,
    "dateAdded": dateAdded == null ? null : "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
    "dateModified": dateModified == null ? null : "${dateModified!.year.toString().padLeft(4, '0')}-${dateModified!.month.toString().padLeft(2, '0')}-${dateModified!.day.toString().padLeft(2, '0')}",
  };
}
