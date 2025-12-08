import 'package:image_picker/image_picker.dart';
import 'dart:io';
// lib/screens/manage_plants_screen.dart
import 'package:flutter/material.dart';
import '../screens/add_plant_screen.dart';

class ManagePlantsScreen extends StatefulWidget {
  const ManagePlantsScreen({super.key});

  @override
  State<ManagePlantsScreen> createState() => _ManagePlantsScreenState();
}

class _ManagePlantsScreenState extends State<ManagePlantsScreen> {
  void _editPlant(Map<String, dynamic> plant) {
    final nameController = TextEditingController(text: plant['name']);
    final priceController = TextEditingController(text: plant['price'].toString());
    final categoryController = TextEditingController(text: plant['category']);
    final stockController = TextEditingController(text: plant['stock'].toString());
    String? imagePath = plant['imagePath'];
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Edit Plant'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final picked = await picker.pickImage(source: ImageSource.gallery);
                        if (picked != null) {
                          setStateDialog(() {
                            imagePath = picked.path;
                          });
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: imagePath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(imagePath!),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.image, size: 40, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: categoryController,
                      decoration: const InputDecoration(labelText: 'Category'),
                    ),
                    TextField(
                      controller: stockController,
                      decoration: const InputDecoration(labelText: 'Stock'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      plant['name'] = nameController.text;
                      plant['price'] = double.tryParse(priceController.text) ?? plant['price'];
                      plant['category'] = categoryController.text;
                      plant['stock'] = int.tryParse(stockController.text) ?? plant['stock'];
                      plant['imagePath'] = imagePath;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Plant updated!')),
                    );
                  },
                  child: const Text('Save'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  final List<Map<String, dynamic>> plants = [
    {
      'id': 1,
      'name': 'Monstera Deliciosa',
      'price': 29.99,
      'category': 'Popular',
      'stock': 15,
    },
    {
      'id': 2,
      'name': 'Snake Plant',
      'price': 24.99,
      'category': 'Low Maintenance',
      'stock': 8,
    },
    {
      'id': 3,
      'name': 'Fiddle Leaf Fig',
      'price': 34.99,
      'category': 'Popular',
      'stock': 5,
    },
    {
      'id': 4,
      'name': 'Peace Lily',
      'price': 22.99,
      'category': 'New Arrivals',
      'stock': 12,
    },
  ];

  void _deletePlant(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Plant'),
        content: const Text('Are you sure you want to delete this plant?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                plants.removeWhere((plant) => plant['id'] == id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Plant deleted successfully')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Plants',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A4D2E),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: plants.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_florist,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No plants in catalog',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plant = plants[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: plant['imagePath'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(plant['imagePath']),
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.image, color: Colors.grey, size: 32),
                          ),
                    title: Text(
                      plant['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A4D2E),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Price: \$${plant['price']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Stock: ${plant['stock']} units',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            plant['category'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A4D2E),
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: const Row(
                            children: [
                              Icon(Icons.edit, size: 18),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                          onTap: () => _editPlant(plant),
                        ),
                        PopupMenuItem(
                          child: const Row(
                            children: [
                              Icon(Icons.delete, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          onTap: () => _deletePlant(plant['id']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlantScreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 81, 198, 128),
        icon: const Icon(Icons.add),
        label: const Text('Add Plant'),
      ),
    );
  }
}
