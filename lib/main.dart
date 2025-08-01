import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'viewmodel/map_tile_view_model.dart';
import 'routes/app_router.dart';
import 'services/shared_prefs_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = SharedPrefsService();
  final hasSeenOnboarding = await prefs.hasSeenOnboarding();

  final appRouter = AppRouter();

  if (hasSeenOnboarding) {
    appRouter.replaceAll([const MapRoute()]);
  }

  runApp(MainApp(appRouter: appRouter));
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;
  const MainApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapTileViewModel(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
