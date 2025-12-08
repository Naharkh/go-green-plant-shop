import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AIRecommendationScreen extends StatefulWidget {
  const AIRecommendationScreen({super.key});

  @override
  State<AIRecommendationScreen> createState() => _AIRecommendationScreenState();
}

class _AIRecommendationScreenState extends State<AIRecommendationScreen> {

    final String _visionApiKey = 'AIzaSyB_rOnM0vBdSpDrGGCXUUbY3JEMEGPDstA';

    Future<String?> _analyzeImageWithVision(XFile image) async {
      try {
        final bytes = await image.readAsBytes();
        final base64Image = base64Encode(bytes);

        final _gemini = Gemini.instance;

        print('Sending image to Gemini for analysis...');
        
        var res = await _gemini.textAndImage(
        text: "Analyze this image and provide plant recommendations. The available plants for recommendation are: 1. Snake Plant, 2. Spider Plant, 3. Peace Lily, 4. Aloe Vera, 5. Pothos. Suggest the best matches based on the image content. Provide a short answer in a concise manner with a list of recommendations and a short description for the reasons.",
        images: [bytes],
        );


        
        return res?.output;

    
       } catch (e) {
         debugPrint('Vision API exception: $e');
         return null;
       }
    }

  bool _isLoading = false;
  XFile? _cameraImage;
  String? _recommendation;
  List<Map<String, dynamic>> _recommendedPlants = [];

  Future<void> _openCamera() async {
    // Request camera and photos permissions at runtime
    final cameraStatus = await Permission.camera.request();
    final photosStatus = await Permission.photos.request();
    if (!cameraStatus.isGranted && !photosStatus.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera or photos permission denied.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final ImagePicker picker = ImagePicker();
      XFile? image;
      try {
        image = await picker.pickImage(source: ImageSource.camera);
      } catch (e) {
        debugPrint('Camera failed: $e');
      }
      if (image == null) {
        // Fallback: try picking from gallery
        image = await picker.pickImage(source: ImageSource.gallery);
        if (image == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No image selected.'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }
      setState(() {
        _cameraImage = image;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Analyzing your photo...'),
          duration: Duration(seconds: 1),
        ),
      );
      
      final result = await _analyzeImageWithVision(image);
      if (result != null) {
        
        setState(() {
          _recommendation = result;
          _recommendedPlants = [];

        });
      } else {
        setState(() {
          _recommendation = 'Analysis failed. Please try again.';
          _recommendedPlants = [];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Camera error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addToCart(Map<String, dynamic> plant) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${plant['name']} added to cart!'),
        backgroundColor: const Color(0xFF1A4D2E),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Plant Advisor',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A4D2E),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Smart Plant Recommendation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A4D2E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Take a photo of your space and let AI recommend the perfect plants for your environment',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Camera Button
              if (_cameraImage == null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _openCamera,
                    icon: const Icon(Icons.camera_alt),
                    label: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text('Take a Photo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A4D2E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

              // Analysis Result
              if (_cameraImage != null) ...[
                const SizedBox(height: 20),
                // Image Preview
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF1A4D2E),
                      width: 2,
                    ),
                  ),
                  child: _cameraImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            // ignore: unnecessary_null_comparison
                            File(_cameraImage!.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        )
                      : const Center(child: Text('No image selected')),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _cameraImage = null;
                      _recommendation = null;
                      _recommendedPlants = [];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: const Color(0xFF1A4D2E),
                    side: const BorderSide(
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                  child: const Text('Retake Photo'),
                ),
                const SizedBox(height: 24),

                // AI Recommendation Text
                if (_recommendation != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              color: Colors.blue,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'AI Analysis',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _recommendation!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Recommended Plants
                  const Text(
                    'Recommended Plants',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A4D2E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _recommendedPlants.length,
                    itemBuilder: (context, index) {
                      final plant = _recommendedPlants[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        plant['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1A4D2E),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF4CAF50),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          'Match: ${plant['match']}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '\$${plant['price']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A4D2E),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              plant['reason'],
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _addToCart(plant),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4CAF50),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Add to Cart'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
