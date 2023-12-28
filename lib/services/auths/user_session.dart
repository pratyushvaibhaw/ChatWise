import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  //keys
  static String userLoggedInKey = 'loggedin';
  static String userNameKey = 'usernamekey';
  static String userEmailKey = 'useremailkey';
  //saving the user's data
  static Future<bool> saveUserLoggedInStatus(bool isLoggedIn) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool(userLoggedInKey, isLoggedIn);
  }

  static Future<bool> saveUserName(String userName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userEmailKey, userEmail);
  }

  //retrieving the user's data
  static Future<bool?> getLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }
}
