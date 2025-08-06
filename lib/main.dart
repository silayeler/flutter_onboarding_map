import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map_onboarding/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'viewmodel/map_tile_view_model.dart';
import 'viewmodel/bottom_nav_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); /* asenkron servisleir baslatmadan önce gerekli */
  await EasyLocalization.ensureInitialized();/* lang klasörünü okmak icin */

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/lang',
      fallbackLocale: const Locale('tr'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MapTileViewModel()),
          ChangeNotifierProvider(create: (_) => BottomNavViewModel()), 
        ],
        child:  MainApp(), 
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
 MainApp({super.key});
  final AppRouter router = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router.config(),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
);
}
}