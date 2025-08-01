## 📱 Uygulama Hakkında

Bu Flutter projesi, harita tabanlı bir mobil uygulamanın onboarding ekranlarıyla nasıl entegre edileceğini gösteren öğretici bir örnektir. Uygulama MVVM mimarisi ile yapılandırılmış olup, `AutoRoute` kullanılarak modern ve yönetilebilir bir sayfa yönlendirme sistemi uygulanmıştır.

### 🔍 Özellikler
- ✅ **3 sayfalı onboarding** deneyimi
- 🗺️ **Harita gösterimi** (Flutter Map, Google Maps değildir)
- 📍 **Marker** (konum) gösterimi
- ℹ️ Marker'lara tıklayınca **bilgi penceresi (popup/snippet)**
- 👀 Temiz dosya yapısı ve **MVVM mimarisi**
- 🔁 `AutoRoute` ile güçlü **sayfa yönlendirme**

---

## 🧭 Sayfa Yapısı ve Geçişler

- **Onboarding Ekranı (`OnboardingScreen`)**  
  Uygulama açıldığında kullanıcıyı karşılar. Kullanıcı tamamladığında harita ekranına yönlendirilir.

- **Harita Ekranı (`MapScreen`)**  
  Türkiye'den örnek konumlar `PlaceModel` listesi ile gösterilir.

- **Detay Ekranı (`DetailScreen`)**  
  Her bir marker’a tıklandığında, detay sayfasına geçilir.

---

## 🔧 Kullanılan Teknolojiler ve Paketler

| Teknoloji        | Açıklama                                |
|------------------|------------------------------------------|
| Flutter          | Mobil uygulama geliştirme framework'ü   |
| AutoRoute        | Sayfa yönlendirme ve routing yönetimi   |
| Provider         | MVVM yapısı için state management       |
| flutter_map      | Açık kaynak harita gösterimi            |
| Lottie           | Onboarding ekranı için animasyonlar     |

---## 📁 Dosya Yapısı
lib/
│
├── model/ # Veri model sınıfı (PlaceModel)
├── view/ # Tüm sayfalar (map, onboarding, detail)
├── viewmodel/ # ViewModel katmanı (MapTileViewModel)
├── routes/ # AutoRoute yapılandırması (app_router.dart)
├── data/ # Mock veri listesi (mock_data.dart)
└── main.dart # Uygulama giriş noktası


## 🚀 Kurulum ve Çalıştırma

```bash
git clone https://github.com/kullanici/flutter_onboarding_map.git
cd flutter_onboarding_map
flutter pub get
flutter run
