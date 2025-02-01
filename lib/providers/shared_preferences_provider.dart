import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefEnum {
  isOnboardingSeen,
  websiteList,
}

final sharedPreferencesProvider = Provider<SharedPreferencesService>((ref) {
  return SharedPreferencesService();
});

class SharedPreferencesService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool getIsOnboardingSeen() {
    return _prefs.getBool(PrefEnum.isOnboardingSeen.name) ?? false;
  }

  void setIsOnboardingSeen(bool value) {
    _prefs.setBool(PrefEnum.isOnboardingSeen.name, value);
  }

  List<String> getWebsiteList() {
    return _prefs.getStringList(PrefEnum.websiteList.name) ?? [];
  }

  void setWebsiteList(List<String> value) {
    _prefs.setStringList(PrefEnum.websiteList.name, value);
  }
}
