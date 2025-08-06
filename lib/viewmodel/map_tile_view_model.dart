import 'package:flutter/foundation.dart';
import '../data/mock_data.dart';
import '../model/place_model.dart';

class MapTileViewModel extends ChangeNotifier {
  // Haritadaki yerlerin listesi mock datadan alındı
  final List<PlaceModel> _places = mockPlaces;
  List<PlaceModel> get places => _places;

  // Türkçe görünen ad => İngilizce sistem adı
 final Map<String, String> _tileMap = {
  'normal': 'osm',
  'dark': 'dark',
  'light': 'light',
  'satellite': 'satellite',
  'terrain': 'terrain',
};


  // Kullanıcıya sunulacak görünen tile adları
  List<String> get availableTiles => _tileMap.keys.toList();

  // Seçilen sistem ad (örn: 'osm', 'dark')
  String _selectedTile = 'osm';
  String get selectedTile => _selectedTile;

  // Kullanıcının seçtiği görünen tile adına göre sistem adını ayarla
  void changeTile(String label) {
    _selectedTile = _tileMap[label]!;
    notifyListeners();
  }

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
        return 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'; // OpenStreetMap
    }
  }

  // UI'da işaretli tile’ı bulmak için sistem adını label'a çevirme (isteğe bağlı)
  String getSelectedLabel() {
    return _tileMap.entries
        .firstWhere((entry) => entry.value == _selectedTile)
        .key;
  }
}
