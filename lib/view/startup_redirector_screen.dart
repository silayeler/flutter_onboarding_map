import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../services/shared_prefs_service.dart';
import '../routes/app_router.dart';

@RoutePage()
class StartupRedirectorScreen extends StatefulWidget {
  const StartupRedirectorScreen({super.key});

  @override
  State<StartupRedirectorScreen> createState() => _StartupRedirectorScreenState();
}

class _StartupRedirectorScreenState extends State<StartupRedirectorScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final prefs = SharedPrefsService();
    final seen = await prefs.hasSeenOnboarding();

    if (seen) {
      context.replaceRoute(const BottomNavRoute());
    } else {
      context.replaceRoute(const OnboardingRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
