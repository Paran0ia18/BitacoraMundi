import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bitacora_mundi/models/travel_entry.dart';

class TravelTimeline extends StatelessWidget {
  final List<TravelEntry> entries;

  const TravelTimeline({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            leading: entry.photoPaths.isNotEmpty
                ? Image.network(entry.photoPaths.first)
                : const Icon(Icons.photo_library),
            title: Text(entry.description),
            subtitle: Text(
              DateFormat('dd MMM yyyy - HH:mm').format(entry.date),
            ),
            trailing: Text(
              '${entry.latitude.toStringAsFixed(2)}, '
              '${entry.longitude.toStringAsFixed(2)}',
            ),
          ),
        );
      },
    );
  }
}