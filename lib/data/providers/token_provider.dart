import 'package:flutter/material.dart';
import 'package:sevgram/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider with ChangeNotifier {
  SharedPreferences prefs;
  String token;

  void resetToken() {
    this.token = null;
  }

  void saveToken(String token) async {
    this.token = token;

    if (prefs != null) {
      prefs.setString(Constant.TOKEN, token);
      notifyListeners();
    } else {
      await SharedPreferences.getInstance().then((currentPrefs) {
        prefs = currentPrefs;
        prefs.setString(Constant.TOKEN, token);
        notifyListeners();
      });
    }
  }

  Future<String> loadToken() async {
    if (prefs != null) {
      token = prefs.getString(Constant.TOKEN);
      notifyListeners();

      return token;
    } else {
      await SharedPreferences.getInstance().then((currentPrefs) {
        prefs = currentPrefs;
        token = prefs.getString(Constant.TOKEN);
        notifyListeners();

        return token;
      });
    }

    return token;
  }
}
