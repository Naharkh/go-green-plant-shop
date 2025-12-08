// lib/models/plant_model.dart
class Plant {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final String description;
  final String lightNeeds;
  final String waterFrequency;
  final String category;

  Plant({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.lightNeeds,
    required this.waterFrequency,
    required this.category,
  });
}