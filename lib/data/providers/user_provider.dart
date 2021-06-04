import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sevgram/data/providers/token_provider.dart';
import 'package:sevgram/data/services/api_interface.dart';
import 'package:sevgram/data/services/entities/login_response.dart';
import 'package:sevgram/data/services/entities/user_response.dart';
import 'package:sevgram/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User user;
  SharedPreferences prefs;
  ApiInterface apiInterface;

  Future<void> loadNetworkUser(
    BuildContext context, {
    bool reset = true,
    VoidCallback onFinish,
  }) async {
    Map<String, String> headers = Map();
    headers["Authorization"] = "Bearer " + context.read<TokenProvider>().token;

    if (apiInterface == null) apiInterface = ApiInterface(context);
    apiInterface.doCurrentUser(
      header: headers,
      onFinish: (response) {
        UserResponse userReponse =
            UserResponse.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          user = userReponse.data;
          saveLocalUser(user);
          notifyListeners();
          if (reset) {
            if (onFinish != null) onFinish();
          }
        }
      },
    );

    return user;
  }

  void saveLocalUser(User user) async {
    this.user = user;

    if (prefs != null) {
      prefs.setString(Constant.USER, jsonEncode(user.toJson()));
      notifyListeners();
    } else {
      await SharedPreferences.getInstance().then((currentPrefs) {
        prefs = currentPrefs;
        prefs.setString(Constant.USER, jsonEncode(user.toJson()));
        notifyListeners();
      });
    }
  }

  void logoutUser() {
    user = null;
    prefs.clear();
    notifyListeners();
  }

  Future<User> loadLocalUser() async {
    if (prefs != null) {
      String jsonUser = prefs.getString(Constant.USER);
      if (jsonUser != null) {
        user = User.fromJson(jsonDecode(jsonUser));
        notifyListeners();

        return user;
      } else {
        return null;
      }
    } else {
      await SharedPreferences.getInstance().then((currentPrefs) {
        prefs = currentPrefs;
        String jsonUser = prefs.getString(Constant.USER);

        if (jsonUser != null) {
          user = User.fromJson(jsonDecode(jsonUser));
          notifyListeners();

          return user;
        } else {
          return null;
        }
      });
    }

    return user;
  }
}
