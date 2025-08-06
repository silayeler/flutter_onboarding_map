import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_route/annotations.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text('settings'.tr()),
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
        ],
      ),
    );
  }
}
