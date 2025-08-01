import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hakkında'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(
            '''Bu uygulama Flutter ile geliştirilmiştir.
Sürüm: 1.0.0

Harita tabanlı bu mobil uygulama ile Türkiye'deki önemli yerleri keşfedebilir, detaylı bilgilere ulaşabilir ve kullanıcı dostu arayüz sayesinde kolayca gezinebilirsiniz.

Flutter’ın güçlü altyapısı ve modern tasarım öğeleriyle geliştirilen bu uygulama; harita görünümü, detay sayfaları ve gezinme menüsü gibi temel özellikleriyle pratik ve etkili bir kullanıcı deneyimi sunar.''',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: Colors.red,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
