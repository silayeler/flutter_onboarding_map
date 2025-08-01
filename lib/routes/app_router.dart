import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../view/detail_screen.dart';
import '../view/map_screen.dart';
import '../view/onboarding/onboarding_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route') // screeni routela degistir gibi düsün, yani onboarding screen yerine onboarding route
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();// adapte gibi,platforma en uygun gecis animasyonunu seciyo

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: OnboardingRoute.page, initial: true),/*initialture olan 1 autorote olabilir bu da ilk baslatılacak olan page */
        AutoRoute(page: MapRoute.page),
        AutoRoute(page: DetailRoute.page),
      ];
}