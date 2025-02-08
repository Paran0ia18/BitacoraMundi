import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:bitacora_mundi/models/travel_entry.dart';

class WorldMapWidget extends StatelessWidget {
  final List<TravelEntry> entries;

  const WorldMapWidget({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(40.0, -3.0), // Cambiado a initialCenter
        initialZoom: 2.0, // Cambiado a initialZoom
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.bitacora_mundi',
          tileProvider: CancellableNetworkTileProvider(), // Añade esto para web
        ),
        MarkerLayer(
          markers: entries.map((entry) => Marker(
            point: LatLng(entry.latitude, entry.longitude),
            width: 40, // Añade ancho y alto
            height: 40,
            child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
          )).toList(),
        ),
      ],
    );
  }
}