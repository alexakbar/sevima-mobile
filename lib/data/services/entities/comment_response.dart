// To parse this JSON data, do
//
//     final commentResponse = commentResponseFromJson(jsonString);

import 'dart:convert';

import 'package:sevgram/data/services/entities/posts_response.dart';

CommentResponse commentResponseFromJson(String str) =>
    CommentResponse.fromJson(json.decode(str));

String commentResponseToJson(CommentResponse data) =>
    json.encode(data.toJson());

class CommentResponse {
  CommentResponse({
    this.data,
    this.error,
    this.message,
  });

  List<Comment> data;
  bool error;
  String message;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        data: json["data"] == null
            ? null
            : List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : error,
        "message": message == null ? null : message,
      };
}
