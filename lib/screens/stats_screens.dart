import 'package:bitacora_mundi/models/travel_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitacora_mundi/providers/travel_provider.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(travelProvider);
    final countries = _getUniqueCountries(entries);

    return Scaffold(
      appBar: AppBar(title: const Text("Estadísticas")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _StatCard(
            icon: Icons.flag,
            title: "Países Visitados",
            value: countries.length.toString(),
          ),
          _StatCard(
            icon: Icons.photo_library,
            title: "Fotos Totales",
            value: entries.fold(0, (sum, entry) => sum + entry.photoPaths.length).toString(),
          ),
          _StatCard(
            icon: Icons.calendar_today,
            title: "Días Viajando",
            value: _calculateTravelDays(entries).toString(),
          ),
        ],
      ),
    );
  }

  Set<String> _getUniqueCountries(List<TravelEntry> entries) {
    // Implementación temporal (mejoraremos con geocoding)
    return entries.map((e) => "Pendiente").toSet();
  }

  int _calculateTravelDays(List<TravelEntry> entries) {
    if (entries.isEmpty) return 0;
    final dates = entries.map((e) => e.date).toList();
    dates.sort();
    return dates.last.difference(dates.first).inDays;
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue),
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(value, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}