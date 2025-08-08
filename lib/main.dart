import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map_onboarding/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'viewmodel/map_tile_view_model.dart';
import 'viewmodel/bottom_nav_view_model.dart';
import 'viewmodel/theme_provider.dart';
import 'viewmodel/place_view_model.dart'; // ✅ Eklendi

// Firebase paketleri
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'firebase_options.dart'; // flutterfire configure komutu ile oluşturulan dosya

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await EasyLocalization.ensureInitialized(); 

  // Firebase'i initialize et
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/lang',
      fallbackLocale: const Locale('tr'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MapTileViewModel()),
          ChangeNotifierProvider(create: (_) => BottomNavViewModel()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => PlaceViewModel()), // ✅ Eklendi
        ],
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final AppRouter router = AppRouter();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          routerConfig: router.config(),
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
        );
      },
    );
  }
}
