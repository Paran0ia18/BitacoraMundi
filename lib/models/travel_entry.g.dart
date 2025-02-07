// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TravelEntryAdapter extends TypeAdapter<TravelEntry> {
  @override
  final int typeId = 0;

  @override
  TravelEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TravelEntry(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      description: fields[2] as String,
      photoPaths: (fields[3] as List).cast<String>(),
      latitude: fields[4] as double,
      longitude: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TravelEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.photoPaths)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TravelEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
