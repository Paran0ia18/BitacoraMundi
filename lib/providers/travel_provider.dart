import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitacora_mundi/models/travel_entry.dart';
import 'package:bitacora_mundi/services/hive_service.dart';

final travelProvider = StateNotifierProvider<TravelNotifier, List<TravelEntry>>((ref) {
  return TravelNotifier();
});

class TravelNotifier extends StateNotifier<List<TravelEntry>> {
  TravelNotifier() : super([]);

  // Cargar entradas desde Hive al iniciar
  Future<void> loadEntries() async {
    final entries = HiveService.travelEntries.values.toList();
    state = entries;
  }

  void addEntry(TravelEntry entry) {
    // Evitar duplicados
    if (state.any((e) => e.id == entry.id)) return;
    
    state = [...state, entry];
    HiveService.travelEntries.put(entry.id, entry); // Guardar con ID único
  }
}