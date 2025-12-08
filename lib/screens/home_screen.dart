// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/plant_card.dart';
import '../services/plant_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Popular';
  final List<String> _categories = [
    'Popular',
    'New Arrivals',
    'Low Maintenance',
  ];

  @override
  Widget build(BuildContext context) {
    final plants = PlantService.getPlantsByCategory(_selectedCategory);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verdant View',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A4D2E),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF1A4D2E),
              child: const Icon(
                Icons.local_florist,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
               
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search plants...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Categories
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: _selectedCategory == category,
                        selectedColor: const Color(0xFF1A4D2E),
                        labelStyle: TextStyle(
                          color: _selectedCategory == category
                              ? Colors.white
                              : const Color.fromARGB(255, 146, 146, 146),
                          fontWeight: FontWeight.w500,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Plants Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: plants.length,
                itemBuilder: (context, index) {
                  return PlantCard(plant: plants[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}