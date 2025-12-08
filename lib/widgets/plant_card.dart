// lib/widgets/plant_card.dart
import 'package:flutter/material.dart';
import '../models/plant_model.dart';
import '../screens/product_detail_screen.dart';
import '../services/cart_service.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(plant: plant),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plant Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.network(
                    plant.imageUrl,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFFFFD700),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            plant.rating.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Plant Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A4D2E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$${plant.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    height: 12,
                    child: Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < plant.rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: const Color(0xFFFFD700),
                          size: 10,
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        CartService().addItem(plant);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${plant.name} added to cart!'),
                            duration: const Duration(seconds: 1),
                            backgroundColor: const Color(0xFF1A4D2E),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart, size: 14),
                      label: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 11),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}