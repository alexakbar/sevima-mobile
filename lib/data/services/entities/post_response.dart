// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

import 'dart:convert';

import 'package:sevgram/data/services/entities/posts_response.dart';

PostResponse postResponseFromJson(String str) =>
    PostResponse.fromJson(json.decode(str));

String postResponseToJson(PostResponse data) => json.encode(data.toJson());

class PostResponse {
  PostResponse({
    this.data,
    this.error,
    this.message,
  });

  Post data;
  bool error;
  String message;

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        data: json["data"] == null ? null : Post.fromJson(json["data"]),
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : error,
        "message": message == null ? null : message,
      };
}
