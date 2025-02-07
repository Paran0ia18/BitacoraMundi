import 'package:hive_flutter/hive_flutter.dart';
import 'package:bitacora_mundi/models/travel_entry.dart';

class HiveService {
  static late Box<TravelEntry> _travelEntriesBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TravelEntryAdapter());
    _travelEntriesBox = await Hive.openBox<TravelEntry>('travel_entries');
  }

  static Box<TravelEntry> get travelEntries => _travelEntriesBox;
}