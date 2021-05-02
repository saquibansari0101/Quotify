// To parse this JSON data, do
//
//     final quoteModel = quoteModelFromMap(jsonString);

import 'dart:convert';

List<QuoteModel> quoteModelFromMap(String str) => List<QuoteModel>.from(json.decode(str).map((x) => QuoteModel.fromMap(x)));

String quoteModelToMap(List<QuoteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class QuoteModel {
  QuoteModel({
    this.q,
    this.a,
    this.h,
  });

  String q;
  String a;
  String h;

  factory QuoteModel.fromMap(Map<String, dynamic> json) => QuoteModel(
    q: json["q"] == null ? null : json["q"],
    a: json["a"] == null ? null : json["a"],
    h: json["h"] == null ? null : json["h"],
  );

  Map<String, dynamic> toMap() => {
    "q": q == null ? null : q,
    "a": a == null ? null : a,
    "h": h == null ? null : h,
  };
}