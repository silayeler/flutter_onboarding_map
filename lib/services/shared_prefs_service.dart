import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const _seenKey = 'hasSeenOnboarding';

  // Onboarding daha önce gösterildi mi?
  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenKey) ?? false;
  }

  // Onboarding gösterildi olarak işaretle
  Future<void> markOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenKey, true);
  }
}
