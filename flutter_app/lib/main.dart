import 'package:flutter/material.dart';

/// PawPersona App - Pet Wearable Device Companion
/// 
/// A modern Flutter application for managing pet wearable devices
/// with BLE connectivity, GPS tracking, and cloud synchronization.

void main() {
  runApp(const PawPersonaApp());
}

/// Main application widget
class PawPersonaApp extends StatelessWidget {
  const PawPersonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PawPersona',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

/// Home page displaying pet status
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PawPersona'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pets, size: 80, color: Colors.orange),
            SizedBox(height: 20),
            Text(
              'Your Pet Companion',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
