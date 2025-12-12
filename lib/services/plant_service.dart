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
      Plant(
        id: 5,
        name: 'Aloe Vera',
        price: 24.99,
        imageUrl: 'https://images.unsplash.com/photo-1509937528035-ad76254b0356?w=400&h=300&fit=crop',
        rating: 5,
        description: 'Popular succulent with healing properties. Spiky green leaves with medicinal gel inside. Great for skin burns and easy to care for.',
        lightNeeds: 'Bright Indirect',
        waterFrequency: 'Every 2 weeks',
        category: 'New Arrivals',
      ),
      Plant(
        id: 6,
        name: 'Boston Fern',
        price: 28.99,
        imageUrl: 'assets/images/fern.jpg',
        rating: 4,
        description: 'Lush, feathery fronds create a beautiful cascading effect. Loves humidity and indirect light. Perfect for bathrooms.',
        lightNeeds: 'Bright Indirect',
        waterFrequency: 'Twice Weekly',
        category: 'Popular',
      ),
      Plant(
        id: 7,
        name: 'Bird of Paradise',
        price: 52.99,
        imageUrl: 'https://images.unsplash.com/photo-1591958911259-bee2173bdccc?w=400&h=300&fit=crop',
        rating: 5,
        description: 'Large tropical plant with stunning orange and blue flowers. Dramatic banana-like leaves bring a tropical paradise indoors.',
        lightNeeds: 'Bright Direct',
        waterFrequency: 'Weekly',
        category: 'New Arrivals',
      ),
      Plant(
        id: 8,
        name: 'Jade Plant',
        price: 21.99,
        imageUrl: 'assets/images/Jade_plant.jpg',
        rating: 5,
        description: 'Classic succulent with thick oval leaves. Symbol of good luck and prosperity. Very easy to care for and long-lasting.',
        lightNeeds: 'Bright Direct',
        waterFrequency: 'Every 2 weeks',
        category: 'Low Maintenance',
      ),
      Plant(
        id: 9,
        name: 'English Ivy',
        price: 16.99,
        imageUrl: 'assets/images/english-ivy.jpg',
        rating: 4,
        description: 'Trailing vine with classic lobed leaves. Great for hanging baskets and topiary. Natural air purifier that removes toxins.',
        lightNeeds: 'Low to Bright',
        waterFrequency: 'Twice Weekly',
        category: 'Popular',
      ),
      Plant(
        id: 10,
        name: 'Lavender',
        price: 19.99,
        imageUrl: 'https://images.unsplash.com/photo-1499002238440-d264edd596ec?w=400&h=300&fit=crop',
        rating: 5,
        description: 'Fragrant purple flowers and silvery foliage. Aromatic herb perfect for relaxation. Can be dried for sachets and teas.',
        lightNeeds: 'Bright Direct',
        waterFrequency: 'Weekly',
        category: 'New Arrivals',
      ),
    ];
  }

  static List<Plant> getPlantsByCategory(String category) {
    if (category == 'All') return getPlants();
    return getPlants().where((plant) => plant.category == category).toList();
  }
}