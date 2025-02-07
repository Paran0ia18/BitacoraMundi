import 'package:hive/hive.dart';

part 'travel_entry.g.dart'; // Archivo generado por Hive

@HiveType(typeId: 0) // ID único para este modelo
class TravelEntry {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<String> photoPaths; // Rutas de las fotos en el dispositivo

  @HiveField(4)
  final double latitude;

  @HiveField(5)
  final double longitude;

  TravelEntry({
    required this.id,
    required this.date,
    required this.description,
    required this.photoPaths,
    required this.latitude,
    required this.longitude,
  });
}