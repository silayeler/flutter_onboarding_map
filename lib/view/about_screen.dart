import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bilgi'),
        content: const Text(
          'Bu uygulama Flutter ile geliştirilmiş olup Türkiye\'deki önemli yerleri keşfetmenizi sağlar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kapat',style: TextStyle(color:Colors.red),),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hakkında'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '''Bu uygulama Flutter ile geliştirilmiştir.\nSürüm: 1.0.0\n\nHarita tabanlı bu mobil uygulama ile Türkiye'deki önemli yerleri keşfedebilir, detaylı bilgilere ulaşabilir ve kullanıcı dostu arayüz sayesinde kolayca gezinebilirsiniz.\n\nFlutter’ın güçlü altyapısı ve modern tasarım öğeleriyle geliştirilen bu uygulama; harita görünümü, detay sayfaları ve gezinme menüsü gibi temel özellikleriyle pratik ve etkili bir kullanıcı deneyimi sunar.''',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _showDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text('Uygulama Hakkında',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
