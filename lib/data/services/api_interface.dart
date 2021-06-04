import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:sevgram/data/services/api_helper.dart';

class ApiInterface {
  ApiHelper apiHelper;

  ApiInterface(BuildContext context) {
    apiHelper = ApiHelper(context);
  }

  void doLogin({
    var body,
    var header,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    Function() onOffline,
  }) {
    apiHelper.post(
      route: "login",
      body: body,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doRegister({
    var body,
    var header,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    Function() onOffline,
  }) {
    apiHelper.post(
      route: "register",
      body: body,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doLikePost({
    var body,
    var header,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    Function() onOffline,
  }) {
    apiHelper.post(
      route: "post/like",
      body: body,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doUnlikePost({
    var body,
    var header,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    Function() onOffline,
  }) {
    apiHelper.post(
      route: "post/unlike",
      body: body,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doCurrentUser({
    var header,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    Function() onOffline,
  }) {
    apiHelper.get(
      route: "profile",
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doGetPosts({
    var header,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    Function() onOffline,
  }) {
    apiHelper.get(
      route: "post",
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doGetPostById({
    @required int id,
    var header,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    Function() onOffline,
  }) {
    apiHelper.get(
      route: "post/$id",
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void addPost({
    var body,
    var header,
    var files,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, StreamedResponse response) onUnhandleError,
    Function(StreamedResponse response) onFinish,
  }) {
    apiHelper.multipartPost(
      route: "post/store",
      body: body,
      files: files,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
    );
  }
}
