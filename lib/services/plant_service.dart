// lib/services/plant_service.dart
import '../models/plant_model.dart';

class PlantService {
  static List<Plant> getPlants() {
    return [
      Plant(
        id: 1,
        name: 'Monstera Deliciosa',
        price: 34.99,
        imageUrl: 'https://images.unsplash.com/photo-1655188565217-014d76f9b670?w=400&h=300&fit=crop',
        rating: 5,
        description: 'This stunning Monstera, also known as the Swiss Cheese Plant, features large split leaves and is perfect for adding a tropical touch to your space.',
        lightNeeds: 'Bright Indirect',
        waterFrequency: 'Weekly',
        category: 'Popular',
      ),
      Plant(
        id: 2,
        name: 'Succulent Mix',
        price: 19.99,
        imageUrl: 'https://images.unsplash.com/photo-1550207477-85f418dc3448?w=400&h=300&fit=crop',
        rating: 4,
        description: 'A beautiful collection of assorted succulents. Low maintenance and drought tolerant, perfect for beginners.',
        lightNeeds: 'Direct Sun',
        waterFrequency: 'Every 2 weeks',
        category: 'Low Maintenance',
      ),
      Plant(
        id: 3,
        name: 'Snake Plant',
        price: 29.99,
        imageUrl: 'https://images.unsplash.com/photo-1668426231244-1827c29ef8e1?w=400&h=300&fit=crop',
        rating: 5,
        description: 'The Snake Plant is one of the most popular houseplants due to its hardy nature. Excellent air purifier that thrives on neglect.',
        lightNeeds: 'Low to Bright',
        waterFrequency: 'Every 2-3 weeks',
        category: 'Low Maintenance',
      ),
      Plant(
        id: 4,
        name: 'Fiddle Leaf Fig',
        price: 44.99,
        imageUrl: 'https://images.unsplash.com/photo-1545239705-1564e58b9e4a?w=400&h=300&fit=crop',
        rating: 4,
        description: 'The Fiddle Leaf Fig is a trendy statement plant with large, violin-shaped leaves. Makes a dramatic focal point in any room.',
        lightNeeds: 'Bright Indirect',
        waterFrequency: 'Weekly',
        category: 'Popular',
      ),
    ];
  }

  static List<Plant> getPlantsByCategory(String category) {
    if (category == 'All') return getPlants();
    return getPlants().where((plant) => plant.category == category).toList();
  }
}