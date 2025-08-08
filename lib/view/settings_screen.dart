import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import '../routes/app_router.dart';
import '../viewmodel/bottom_nav_view_model.dart';
import '../viewmodel/theme_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isTurkish = true;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    //burada dili sharedla kontol ediyor
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('locale') ?? 'tr';
    setState(() {
      isTurkish = langCode == 'tr';
    });
  }

  Future<void> _changeLanguage(bool turkishSelected) async {
    final prefs = await SharedPreferences.getInstance();
    final newLocale = turkishSelected ? const Locale('tr') : const Locale('en');
    
    await context.setLocale(newLocale);
    await prefs.setString('locale', newLocale.languageCode);
    setState(() {
      isTurkish = turkishSelected;
    });

    final tabProvider = context.read<BottomNavViewModel>();
    Future.delayed(const Duration(milliseconds: 200), () {
      context.router.replace(const BottomNavRoute());
      tabProvider.setIndex(3); // 3 = settings
    });
  await FirebaseAnalytics.instance.logEvent(
    name: 'language_changed',
    parameters: {
      'new_locale': newLocale.languageCode,
    },
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('language'.tr()),
            subtitle: Text(isTurkish ? 'turkish'.tr() : 'english'.tr()),
            value: isTurkish,
            onChanged: (value) => _changeLanguage(value),
          ),
          SwitchListTile(
            title: Text('theme_mode'.tr()),
            subtitle: Text(
                context.watch<ThemeProvider>().themeMode == ThemeMode.dark
                    ? 'Dark'
                    : 'Light'),
            value: context.watch<ThemeProvider>().themeMode == ThemeMode.dark,
            onChanged: (value) {
              context.read<ThemeProvider>().toggleTheme(value);
            },
          ),
        ],
      ),
    );
  }
}
