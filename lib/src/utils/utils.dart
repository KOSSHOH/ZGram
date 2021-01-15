import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<void> saveData(
    String name,
    String password,
    String mail,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('password', password);
    prefs.setString('mail', mail);
  }

  static Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("name") != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> isLoginCheck(String name, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("name") != null) {
      if (prefs.getString("name") == name &&
          prefs.getString("password") == password)
        return true;
      else
        return false;
    } else {
      return false;
    }
  }

  static Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
