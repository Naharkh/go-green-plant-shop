import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Add this to pubspec.yaml
import '../models/plant.dart';

class ARViewPage extends StatefulWidget {
  final Plant plant;
  
  const ARViewPage({super.key, required this.plant});

  @override
  _ARViewPageState createState() => _ARViewPageState();
}

class _ARViewPageState extends State<ARViewPage> with WidgetsBindingObserver {
  CameraController? _cameraController;
  bool _isCameraReady = false;
  bool _plantPlaced = false;
  double _plantSize = 100.0;
  Offset _plantPosition = Offset.zero;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }
  
  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      
      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );
      
      await _cameraController!.initialize();
      
      if (mounted) {
        setState(() {
          _isCameraReady = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR View: ${widget.plant.name}'),
        backgroundColor: Colors.green[800],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_plantPlaced)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _plantPlaced = false;
                });
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          // Camera Preview
          if (_isCameraReady && _cameraController != null)
            CameraPreview(_cameraController!)
          else
            Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading camera...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          
          // Instructions Overlay
          if (!_plantPlaced)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Tap anywhere to place the plant',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Move your phone to find a flat surface',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          
          // Plant Visualization
          if (_plantPlaced)
            Positioned(
              left: _plantPosition.dx - _plantSize / 2,
              top: _plantPosition.dy - _plantSize / 2,
              child: GestureDetector(
                onScaleUpdate: (details) {
                  setState(() {
                    _plantSize = (100 * details.scale).clamp(50.0, 300.0);
                  });
                },
                child: Container(
                  width: _plantSize,
                  height: _plantSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.6),
                    border: Border.all(
                      color: Colors.green[800]!,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.eco,
                          size: _plantSize * 0.5,
                          color: Colors.white,
                        ),
                        Text(
                          widget.plant.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _plantSize * 0.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          
          // Plant Info Card
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.eco,
                        size: 40,
                        color: Colors.green[600],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.plant.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.plant.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${widget.plant.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_plantPlaced) {
            // Show a dialog to simulate surface detection
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Place Plant'),
                content: Text('Tap on the screen where you want to place ${widget.plant.name}'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _plantPlaced = true;
                        _plantPosition = Offset(
                          MediaQuery.of(context).size.width / 2,
                          MediaQuery.of(context).size.height / 2,
                        );
                      });
                    },
                    child: Text('Place Here'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            );
          }
        },
        backgroundColor: _plantPlaced ? Colors.blue : Colors.green,
        child: Icon(
          _plantPlaced ? Icons.check : Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}