import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_onboarding/view/settings_screen.dart';
import '../view/detail_screen.dart';
import '../view/map_screen.dart';
import '../view/onboarding/onboarding_screen.dart';
import '../view/about_screen.dart';
import '../view/bottom_nav_screen.dart';
import '../view/startup_redirector_screen.dart';
import '../view/video_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();//hem bobil hem web 

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        // Başlangıçta yönlendirme ekranı TRUE DİKKAT ET
        AutoRoute(page: StartupRedirectorRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),

        AutoRoute(
          page: BottomNavRoute.page,
          children: [
            AutoRoute(page: MapRoute.page, path: 'map'),
            AutoRoute(page: AboutRoute.page, path: 'about'),
            AutoRoute(page: VideoRoute.page, path: 'video'),
            AutoRoute(page: SettingsRoute.page, path: 'settings'),

          ],
        ),

        AutoRoute(page: DetailRoute.page),
      ];
}
