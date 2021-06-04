// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

import 'package:sevgram/data/services/entities/login_response.dart';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.data,
    this.error,
    this.message,
  });

  User data;
  bool error;
  String message;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        data: json["data"] == null ? null : User.fromJson(json["data"]),
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : error,
        "message": message == null ? null : message,
      };
}
