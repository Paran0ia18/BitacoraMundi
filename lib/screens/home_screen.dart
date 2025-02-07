import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitacora_mundi/widgets/world_map.dart';
import 'package:bitacora_mundi/widgets/travel_timeline.dart';
import 'package:bitacora_mundi/providers/travel_provider.dart';
import 'package:bitacora_mundi/screens/add_entry_screen.dart';
import 'package:bitacora_mundi/models/travel_entry.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(travelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BitácoraMundi 🌍'),
        actions: [
          IconButton(
            icon: const Icon(Icons.storage),
            onPressed: () => _showStatsDialog(context, entries),
          ),
        ],
      ),
      body: entries.isEmpty
          ? const Center(child: Text("¡Añade tu primera entrada de viaje!"))
          : Column(
              children: [
                Expanded(
                  child: WorldMapWidget(entries: entries),
                ),
                const Divider(height: 1),
                Expanded(
                  child: TravelTimeline(entries: entries),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEntryScreen()),
        ),
        child: const Icon(Icons.add_location_alt),
      ),
    );
  }

  void _showStatsDialog(BuildContext context, List<TravelEntry> entries) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Estadísticas"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Entradas totales: ${entries.length}"),
            Text("Países visitados: ${_getUniqueCountries(entries).length}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  Set<String> _getUniqueCountries(List<TravelEntry> entries) {
    // Implementación temporal (mejorar con geocoding)
    return entries.map((e) => "Pendiente").toSet();
  }
}