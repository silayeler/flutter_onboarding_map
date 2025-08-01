import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_onboarding/routes/app_router.dart';

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
            backgroundColor: Colors.red, 
            selectedItemColor: Colors.white, 
            unselectedItemColor:
                Colors.white60, 
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Harita',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
                label: 'Hakkında',
              ),
            ],
          ),
        );
      },
    );
  }
}
