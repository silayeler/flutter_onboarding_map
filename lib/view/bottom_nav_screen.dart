import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_onboarding/routes/app_router.dart';
import 'package:easy_localization/easy_localization.dart'; // ✅ eklendi

@RoutePage()
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List<PageRouteInfo> _routes = [
    const MapRoute(),
    const AboutRoute(),
    const VideoRoute(),
    const SettingsRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: _routes,
      builder: (context, child) {
        final tab = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tab.activeIndex,
            onTap: tab.setActiveIndex,
            backgroundColor: Colors.redAccent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.map),
                label: 'map'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.info_outline),
                label: 'about'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.video_library),
                label: 'video'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: 'settings'.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
