import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bitacora_mundi/models/travel_entry.dart';
import 'package:bitacora_mundi/providers/travel_provider.dart';
import 'package:bitacora_mundi/services/hive_service.dart';

class AddEntryScreen extends ConsumerStatefulWidget {
  const AddEntryScreen({super.key});

  @override
  ConsumerState<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends ConsumerState<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  List<File> _photos = [];
  Position? _currentPosition;
  bool _isLoadingLocation = false;

  Future<void> _getLocation() async {
    setState(() => _isLoadingLocation = true);
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al obtener la ubicación")),
      );
    }
    setState(() => _isLoadingLocation = false);
  }

  Future<void> _pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _photos.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  Future<void> _saveEntry() async {
    if (!_formKey.currentState!.validate()) return;
    if (_currentPosition == null) {
      await _getLocation();
      if (_currentPosition == null) return;
    }

    final newEntry = TravelEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      date: DateTime.now(),
      description: _descriptionController.text,
      photoPaths: _photos.map((file) => file.path).toList(),
      latitude: _currentPosition!.latitude,
      longitude: _currentPosition!.longitude,
    );

    // Guardar en Hive y actualizar estado
    await HiveService.travelEntries.add(newEntry);
    ref.read(travelProvider.notifier).addEntry(newEntry);
    
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nueva Entrada")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Descripción del lugar",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor escribe una descripción";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.location_on),
                label: _isLoadingLocation
                    ? const CircularProgressIndicator()
                    : const Text("Obtener Ubicación Actual"),
                onPressed: _getLocation,
              ),
              Text(
                _currentPosition == null
                    ? "Ubicación no detectada"
                    : "Coordenadas: ${_currentPosition!.latitude.toStringAsFixed(4)}, "
                        "${_currentPosition!.longitude.toStringAsFixed(4)}",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.photo_library),
                label: const Text("Añadir Fotos"),
                onPressed: _pickImages,
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: _photos.length,
                itemBuilder: (context, index) => Image.file(
                  _photos[index],
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveEntry,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Guardar Entrada"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}