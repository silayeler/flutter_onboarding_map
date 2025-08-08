import 'package:flutter/foundation.dart';
import '../model/place_model.dart';
import '../services/firestore_service.dart';

class PlaceViewModel extends ChangeNotifier {
  final _service = FirestoreService.instance;

  /// Canlı veri akışı (UI -> StreamBuilder)
  Stream<List<PlaceModel>> streamPlaces() {
    return _service.streamPlaces();
  }

  /// Yeni kayıt ekleme
  Future<void> addPlace({
    required String name,
    required String description,
    required double latitude,
    required double longitude,
    required String category,
  }) async {
    await _service.addPlace(
      name: name,
      description: description,
      latitude: latitude,
      longitude: longitude,
      category: category,
    );
    notifyListeners();
  }

  /// Kayıt silme
  Future<void> deletePlace(String docId) async {
    await _service.deletePlace(docId);
    notifyListeners();
  }
}
