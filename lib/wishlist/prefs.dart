import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static void saveIdUser(String id_user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('id_user', id_user);
  }

  static Future<String> getIdUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('id_user');
  }
}