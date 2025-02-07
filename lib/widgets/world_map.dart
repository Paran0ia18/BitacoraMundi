import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:bitacora_mundi/models/travel_entry.dart';

class WorldMapWidget extends StatelessWidget {
  final List<TravelEntry> entries;

  const WorldMapWidget({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: const LatLng(40.0, -3.0), // Centro inicial (Madrid)
        zoom: 2.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.bitacora_mundi',
        ),
        MarkerLayer(
          markers: entries.map((entry) => Marker(
            point: LatLng(entry.latitude, entry.longitude),
            child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
          )).toList(),
        ),
      ],
    );
  }
}