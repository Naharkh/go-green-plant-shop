class Plant {
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  
  Plant({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });
}

// Sample plant list
List<Plant> plants = [
  Plant(
    name: "Snake Plant", 
    price: 29.99, 
    imageUrl: "assets/snake_plant.jpg",
    description: "Low maintenance plant that purifies air"
  ),
  Plant(
    name: "Monstera", 
    price: 39.99, 
    imageUrl: "assets/monstera.jpg",
    description: "Beautiful tropical plant with unique leaf patterns"
  ),
  Plant(
    name: "Fiddle Leaf Fig", 
    price: 49.99, 
    imageUrl: "assets/fig.jpg",
    description: "Popular indoor tree with large violin-shaped leaves"
  ),
];