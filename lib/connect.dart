import 'package:shared_preferences/shared_preferences.dart';

class con{
  static const url="http://192.168.129.241/event_hub/";
}
Future<String?> getLoginId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? login_id = prefs.getString('loginId');
  return login_id;
}
bool isLoggedIn = false;
