import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../routes/app_router.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController
      _pageController; //pageview bilesinini kontrol etmek icin
// late degiskenin sonradan, ama sadece bir kez atanacağını belirtir
  final List<String> lottieAnimations = [
    'assets/explore.json',
    'assets/locatin.json',
    'assets/man.json',
  ];

  final List<String> texts = [
    'İşaretli konumları keşfet, detayları öğren!',
    'Harita üzerinde gez, mekanları bul!',
    'Gezi rotana yeni yerler ekleyerek sen de keşfetmeye başla!',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            final currentPage = _pageController.page?.round() ?? 0;
            if (currentPage < lottieAnimations.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              children: [
                PageView.builder(
                  /* !!Her onboarding sayfası için bir ekran olusturuyor*/
                  controller: _pageController,
                  itemCount: lottieAnimations.length,
                  physics: const BouncingScrollPhysics(), // alternatif kaydrımalar var
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          lottieAnimations[index],
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          texts[index],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        if (index == lottieAnimations.length - 1)
                          ElevatedButton(
                            onPressed: () {
                              context.replaceRoute(const MapRoute());
                            },
                            child: const Text(
                              'Hadi Başlayalım',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                //ATLA BUTON
                Positioned(
                  top: 0,
                  right: 0,
                  child: TextButton(
                    onPressed: () {
                      context.replaceRoute(
                          const MapRoute()); // maproute gec ve oldugun sayfayı stackten sil komutu
                    },
                    child: const Text(
                      'Atla',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
