// To parse this JSON data, do
//
//     final PostsResponse = PostsResponseFromJson(jsonString);

import 'dart:convert';

import 'login_response.dart';

PostsResponse postsResponseFromJson(String str) =>
    PostsResponse.fromJson(json.decode(str));

String postsResponseToJson(PostsResponse data) => json.encode(data.toJson());

class PostsResponse {
  PostsResponse({
    this.data,
    this.error,
    this.message,
  });

  List<Post> data;
  bool error;
  String message;

  factory PostsResponse.fromJson(Map<String, dynamic> json) => PostsResponse(
        data: json["data"] == null
            ? null
            : List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
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

class Post {
  Post({
    this.id,
    this.image,
    this.text,
    this.isTurnOfComment,
    this.isTurnOfLike,
    this.totalLike,
    this.likers,
    this.totalComment,
    this.comment,
    this.user,
    this.isLike,
  });

  int id;
  String image;
  String text;
  int isTurnOfComment;
  int isTurnOfLike;
  int totalLike;
  List<User> likers;
  int totalComment;
  List<Comment> comment;
  User user;
  bool isLike;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] == null ? null : json["id"],
        isLike: json["is_like"] == null ? null : json["is_like"],
        image: json["image"] == null ? null : json["image"],
        text: json["text"] == null ? null : json["text"],
        isTurnOfComment: json["is_turn_of_comment"] == null
            ? null
            : json["is_turn_of_comment"],
        isTurnOfLike:
            json["is_turn_of_like"] == null ? null : json["is_turn_of_like"],
        totalLike: json["total_like"] == null ? null : json["total_like"],
        likers: json["likers"] == null
            ? null
            : List<User>.from(json["likers"].map((x) => User.fromJson(x))),
        totalComment:
            json["total_comment"] == null ? null : json["total_comment"],
        comment: json["comment"] == null
            ? null
            : List<Comment>.from(
                json["comment"].map((x) => Comment.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "is_like": isLike == null ? null : isLike,
        "image": image == null ? null : image,
        "text": text == null ? null : text,
        "is_turn_of_comment": isTurnOfComment == null ? null : isTurnOfComment,
        "is_turn_of_like": isTurnOfLike == null ? null : isTurnOfLike,
        "total_like": totalLike == null ? null : totalLike,
        "likers": likers == null
            ? null
            : List<dynamic>.from(likers.map((x) => x.toJson())),
        "total_comment": totalComment == null ? null : totalComment,
        "comment": comment == null
            ? null
            : List<dynamic>.from(comment.map((x) => x.toJson())),
        "user": user == null ? null : user.toJson(),
      };
}

class Comment {
  Comment({
    this.id,
    this.userId,
    this.postId,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int id;
  int userId;
  int postId;
  String text;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
        text: json["text"] == null ? null : json["text"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "post_id": postId == null ? null : postId,
        "text": text == null ? null : text,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "user": user == null ? null : user.toJson(),
      };
}
