 import 'package:flutter/foundation.dart';
import '../data/mock_data.dart';
import '../model/place_model.dart';

class MapTileViewModel extends ChangeNotifier {

  // Haritadaki yerlerin listesi mock datadan alındı
  final List<PlaceModel> _places = mockPlaces;

  List<PlaceModel> get places => _places;

  // Seçilen harita teması (tile) - varsayılan osm
  String _selectedTile = 'osm';

  String get selectedTile => _selectedTile;

  // Kullanıcı tile'ı değiştirdiğinde bu fonksiyon çalışır
  void changeTile(String tile) {
    _selectedTile = tile;
    notifyListeners();
  }

  // Seçilen tile'a göre ilgili URL şablonu döner
  String getTileUrl() {
    switch (_selectedTile) {
      case 'dark':
        return 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png';
      case 'light':
        return 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png';
      case 'satellite':
        return 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}';
      case 'terrain':
        return 'https://tile.opentopomap.org/{z}/{x}/{y}.png';
      default:
        return 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'; // OpenStreetMap (default)
    }
  }

  // Kullanıcıya sunulacak tile seçenekleri
  List<String> get availableTiles => [
        'normal',
        'karanlık',
        'açık',
        'uydu',
        'dağ',
      ];
}
