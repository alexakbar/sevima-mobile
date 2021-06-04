// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.data,
    this.error,
    this.message,
    this.token,
  });

  User data;
  bool error;
  String message;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        data: json["data"] == null ? null : User.fromJson(json["data"]),
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "token": token == null ? null : token,
      };
}

class User {
  User({
    this.id,
    this.fullname,
    this.username,
    this.email,
    this.phone,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String fullname;
  String username;
  String email;
  dynamic phone;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "fullname": fullname == null ? null : fullname,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "phone": phone,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
