import 'dart:convert';

import 'package:sevgram/components/dialog/custom_alert_dialog.dart';
import 'package:sevgram/data/services/api_service.dart';
import 'package:sevgram/utils/application.dart';
import 'package:sevgram/utils/constant.dart';
import 'package:sevgram/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ApiHelper {
  BuildContext context;

  ApiHelper(this.context);

  void showError(String message) {
    if (Application.isInDebugMode) {
      showDialog(
        context: context,
        builder: (dialogContext) => Container(
          child: WebView(
              initialUrl: "https://google.com/",
              onWebViewCreated: (WebViewController webViewController) {
                var _webController = webViewController;
                final String contentBase64 =
                    base64Encode(const Utf8Encoder().convert(message));
                _webController.loadUrl('data:text/html;base64,$contentBase64');
              }),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (dialogContext) => CustomAlertDialog(
          title: "Terjadi Kesalahan",
          message: message,
          buttonText: "OK",
          onConfirm: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  void externalGet({
    String route,
    var header,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    VoidCallback onOffline,
  }) async {
    if (Application.isInDebugMode) print(route);
    if (onOffline == null) {
      onOffline = () {
        if (Application.isInDebugMode) print("offline");
      };
    }

    Tools.check().then((intenet) async {
      if (intenet != null && intenet) {
        Response response = await ApiService.client
            .get(
              Uri.parse(route),
              headers: header,
            )
            .timeout(
              Duration(milliseconds: Constant.timeout),
              onTimeout: onRequestTimeOut,
            );

        try {
          if (Application.isInDebugMode) print(response.body);
          onFinish(response);
        } catch (e) {
          if (onUnhandleError != null) {
            onUnhandleError(e, response);
          } else {
            showError(response.body);
          }
        }
      } else {
        onOffline();
      }
    });
  }

  void get({
    String route,
    var header,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    VoidCallback onOffline,
  }) async {
    if (Application.isInDebugMode) print(route);
    if (onOffline == null) {
      onOffline = () {
        if (Application.isInDebugMode) print("offline");
      };
    }
    Tools.check().then((intenet) async {
      if (intenet != null && intenet) {
        Response response = await ApiService.client
            .get(
              Uri.parse(ApiService.baseUrl + route),
              headers: header,
            )
            .timeout(
              Duration(milliseconds: Constant.timeout),
              onTimeout: onRequestTimeOut,
            );

        try {
          if (Application.isInDebugMode) print(response.body);
          onFinish(response);
        } catch (e) {
          if (onUnhandleError != null) {
            onUnhandleError(e, response);
          } else {
            showError(response.body);
          }
        }
      } else {
        onOffline();
      }
    });
  }

  void post({
    String route,
    var header,
    var body,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    VoidCallback onOffline,
  }) async {
    if (Application.isInDebugMode) print(route);
    if (onOffline == null) {
      onOffline = () {
        if (Application.isInDebugMode) print("offline");
      };
    }

    Tools.check().then((intenet) async {
      if (intenet != null && intenet) {
        Response response = await ApiService.client
            .post(
              Uri.parse(ApiService.baseUrl + route),
              body: body,
              headers: header,
            )
            .timeout(
              Duration(milliseconds: Constant.timeout),
              onTimeout: onRequestTimeOut,
            );

        try {
          if (Application.isInDebugMode) print(response.body);
          onFinish(response);
        } catch (e) {
          if (onUnhandleError != null) {
            onUnhandleError(e, response);
          } else {
            showError(response.body);
          }
        }
      } else {
        onOffline();
      }
    });
  }

  void put({
    String route,
    var header,
    var body,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    VoidCallback onOffline,
  }) async {
    if (Application.isInDebugMode) print(route);
    if (onOffline == null) {
      onOffline = () {
        if (Application.isInDebugMode) print("offline");
      };
    }

    Tools.check().then((intenet) async {
      if (intenet != null && intenet) {
        Response response = await ApiService.client
            .put(
              Uri.parse(ApiService.baseUrl + route),
              body: body,
              headers: header,
            )
            .timeout(
              Duration(milliseconds: Constant.timeout),
              onTimeout: onRequestTimeOut,
            );

        try {
          if (Application.isInDebugMode) print(response.body);
          onFinish(response);
        } catch (e) {
          if (onUnhandleError != null) {
            onUnhandleError(e, response);
          } else {
            showError(response.body);
          }
        }
      } else {
        onOffline();
      }
    });
  }

  void delete({
    String route,
    var header,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, Response response) onUnhandleError,
    Function(Response response) onFinish,
    VoidCallback onOffline,
  }) async {
    if (Application.isInDebugMode) print(route);
    if (onOffline == null) {
      onOffline = () {
        if (Application.isInDebugMode) print("offline");
      };
    }

    Tools.check().then((intenet) async {
      if (intenet != null && intenet) {
        Response response = await ApiService.client
            .delete(
              Uri.parse(ApiService.baseUrl + route),
              headers: header,
            )
            .timeout(
              Duration(milliseconds: Constant.timeout),
              onTimeout: onRequestTimeOut,
            );

        try {
          if (Application.isInDebugMode) print(response.body);
          onFinish(response);
        } catch (e) {
          if (onUnhandleError != null) {
            onUnhandleError(e, response);
          } else {
            showError(response.body);
          }
        }
      } else {
        onOffline();
      }
    });
  }

  void multipartPost({
    String route,
    var header,
    var body,
    var files,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, StreamedResponse response) onUnhandleError,
    Function(StreamedResponse response) onFinish,
    VoidCallback onOffline,
  }) async {
    if (Application.isInDebugMode) print(route);
    if (onOffline == null) {
      onOffline = () {
        if (Application.isInDebugMode) print("offline");
      };
    }

    Tools.check().then((intenet) async {
      if (intenet != null && intenet) {
        var request = MultipartRequest(
          "POST",
          Uri.parse(ApiService.baseUrl + route),
        );

        for (String key in header.keys) {
          request.headers[key] = header[key];
        }

        for (String key in body.keys) {
          request.fields[key] = body[key];
        }

        for (String key in files.keys) {
          var pic = await MultipartFile.fromPath(key, files[key]);
          request.files.add(pic);
        }

        StreamedResponse response = await request.send().timeout(
              Duration(milliseconds: Constant.timeout),
              onTimeout: onRequestTimeOut,
            );

        try {
          onFinish(response);
        } catch (e) {
          if (onUnhandleError != null) {
            onUnhandleError(e, response);
          } else {
            var responseData = await response.stream.toBytes();
            var responseString = String.fromCharCodes(responseData);
            showError(responseString);
          }
          onUnhandleError(e, response);
        }
      } else {
        onOffline();
      }
    });
  }

  void multipartPut({
    String route,
    var header,
    var body,
    var files,
    VoidCallback onRequestTimeOut,
    Function(dynamic error, StreamedResponse response) onUnhandleError,
    Function(StreamedResponse response) onFinish,
    VoidCallback onOffline,
  }) async {
    if (onOffline == null) {
      onOffline = () {
        if (Application.isInDebugMode) print("offline");
      };
    }

    Tools.check().then((intenet) async {
      if (intenet != null && intenet) {
        var request = MultipartRequest(
          "PUT",
          Uri.parse(ApiService.baseUrl + route),
        );

        for (String key in header.keys) {
          request.headers[key] = header[key];
        }

        for (String key in body.keys) {
          request.fields[key] = body[key];
        }

        for (String key in files.keys) {
          var pic = await MultipartFile.fromPath(key, files[key]);
          request.files.add(pic);
        }

        StreamedResponse response = await request.send().timeout(
              Duration(milliseconds: Constant.timeout),
              onTimeout: onRequestTimeOut,
            );

        try {
          onFinish(response);
        } catch (e) {
          if (onUnhandleError != null) {
            onUnhandleError(e, response);
          } else {
            var responseData = await response.stream.toBytes();
            var responseString = String.fromCharCodes(responseData);
            showError(responseString);
          }
        }
      } else {
        onOffline();
      }
    });
  }
}
