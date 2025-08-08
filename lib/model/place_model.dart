// lib/model/place_model.dart
class PlaceModel {
  final String? id;             
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String category;

  PlaceModel({
    this.id,                     
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.category,
  });

  PlaceModel copyWith({
    String? id,
    String? name,
    String? description,
    double? latitude,
    double? longitude,
    String? category,
  }) => PlaceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        category: category ?? this.category,
      );
}
