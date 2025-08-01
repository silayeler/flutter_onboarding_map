import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/map_tile_view_model.dart';
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapTileViewModel(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter().config(),
      ),
    );
  }
}
