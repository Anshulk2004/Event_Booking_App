import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // Storage Keys
  static const String userIdKey = "USER_ID_KEY";
  static const String userNameKey = "USER_NAME_KEY";
  static const String userEmailKey = "USER_EMAIL_KEY";
  static const String userImageKey = "USER_IMAGE_KEY";
  static const String isLoggedInKey = "IS_LOGGED_IN_KEY";
  static const String userTokenKey = "USER_TOKEN_KEY";
  static String isAdminKey = "ISADMINKEY";
  
  // Save Methods
  static Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  static Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  static Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  static Future<bool> saveUserImage(String getUserImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImageKey, getUserImage);
  }

  static Future<bool> saveUserToken(String getUserToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userTokenKey, getUserToken);
  }

  static Future<bool> saveIsAdmin(bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isAdminKey, isAdmin);
  }

  static Future<bool> saveIsLoggedIn(bool getIsLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isLoggedInKey, getIsLoggedIn);
  }

  // Get Methods
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  static Future<String?> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImageKey);
  }

  static Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTokenKey);
  }

  static Future<bool?> getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey);
  }

   static Future<bool> getIsAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isAdminKey) ?? false;
  }

  // Clear Methods
  static Future<bool> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdKey);
    await prefs.remove(userNameKey);
    await prefs.remove(userEmailKey);
    await prefs.remove(userImageKey);
    await prefs.remove(userTokenKey);
    return prefs.remove(isLoggedInKey);
  }
}