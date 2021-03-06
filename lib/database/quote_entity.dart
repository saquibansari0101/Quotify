import 'package:floor/floor.dart';

@entity
class Quote{
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? quote;
  final String? author;
  final String? tags;

  Quote({this.id, this.quote, this.author, this.tags});

  @override
  String toString() {
    return 'Quote{id: $id, quote: $quote, author: $author, tags: $tags}';
  }

  @override
  int get hashCode => id.hashCode ^ quote.hashCode ^ author.hashCode ^ tags.hashCode;

}


/*
{
"_id":"3tXfdExB8jB",
"tags":[
"famous-quotes"
],
"content":"From error to error one discovers the entire truth.",
"author":"Sigmund Freud",
"authorSlug":"sigmund-freud",
"length":51,
"dateAdded":"2019-11-26",
"dateModified":"2019-11-26"
}
*/