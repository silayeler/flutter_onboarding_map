import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/place_model.dart';

class FirestoreService {
  FirestoreService._(); //1
  static final instance = FirestoreService._(); //2
  //SINGLETON tasarim deseni 1,2
  final _db = FirebaseFirestore.instance; // firebase firestorun ana veritabanı bağlantısını tutuyo
  static const _col = 'places'; // firestordaki '...' kısmındaki ceri koleksiyonun adını sabit olarak tanımlıyor

  /// Canlı liste
  Stream<List<PlaceModel>> streamPlaces() { //VERİ OKUMA KISMI
  return _db.collection(_col)
    .snapshots()
    .map((qs) => qs.docs.map((doc) {
      final m = doc.data() as Map<String, dynamic>;
      final geo = m['location'] as GeoPoint?;
      return PlaceModel(// Yukarıdan gelen verileri placemodel nesnesine cevirme kısmı 
        name: (m['name'] ?? '') as String,
        description: (m['description'] ?? '') as String,
        latitude: geo?.latitude ?? 0,
        longitude: geo?.longitude ?? 0,
        category: (m['category'] ?? '') as String,
      );
    }).toList());
}


 
  Future<void> addPlace({
    required String name,
    required String description,
    required double latitude,
    required double longitude,
    required String category,
  }) async {
    await _db.collection(_col).add({
      'name': name,
      'description': description,
      'location': GeoPoint(latitude, longitude),
      'category': category,
    });
  }


  Future<void> deletePlace(String docId) {
    return _db.collection(_col).doc(docId).delete();
  }
}
