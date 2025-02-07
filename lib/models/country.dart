import 'package:hive/hive.dart';

part 'country.g.dart';

@HiveType(typeId: 1) // ¡Usa un typeId diferente!
class Country {
  @HiveField(0)
  final String code;
  
  @HiveField(1)
  final String name;

  Country({required this.code, required this.name});
}