import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitacora_mundi/models/travel_entry.dart';
import 'package:bitacora_mundi/services/hive_service.dart';

final travelProvider = StateNotifierProvider<TravelNotifier, List<TravelEntry>>((ref) {
  return TravelNotifier();
});

class TravelNotifier extends StateNotifier<List<TravelEntry>> {
  TravelNotifier() : super([]);

  Future<void> loadEntries() async {
    final entries = HiveService.travelEntries.values.toList();
    state = entries; // Reemplaza el estado completo (no añade)
  }

  void addEntry(TravelEntry entry) {
    if (state.any((e) => e.id == entry.id)) return; // Verifica duplicados
    
    state = [...state, entry];
    HiveService.travelEntries.put(entry.id, entry); // Guarda con ID único
  }

  // Método para limpiar duplicados (usar una vez)
  void clearDuplicates() {
    final uniqueEntries = state.fold<Map<String, TravelEntry>>(
      {},
      (map, entry) => map..putIfAbsent(entry.id, () => entry),
    ).values.toList();

    state = uniqueEntries;
    HiveService.travelEntries.clear();
    HiveService.travelEntries.addAll(uniqueEntries);
  }
}