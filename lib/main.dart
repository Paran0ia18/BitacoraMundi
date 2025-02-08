import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bitacora_mundi/screens/home_screen.dart';
import 'package:bitacora_mundi/services/hive_service.dart';
import 'package:bitacora_mundi/providers/travel_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  
  final container = ProviderContainer();
  await container.read(travelProvider.notifier).loadEntries(); // Cargar una vez
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitácoraMundi',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}