// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_user_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoggedUserDataAdapter extends TypeAdapter<LoggedUserData> {
  @override
  final int typeId = 0;

  @override
  LoggedUserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoggedUserData(
      fields[0] as int,
      fields[7] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[8] as String,
      fields[9] as String,
      fields[12] as String,
      fields[10] as String,
      fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LoggedUserData obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.profilePictureUrl)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.token)
      ..writeByte(6)
      ..write(obj.refreshToken)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.firstName)
      ..writeByte(9)
      ..write(obj.lastName)
      ..writeByte(10)
      ..write(obj.instagramUrl)
      ..writeByte(11)
      ..write(obj.facebookUrl)
      ..writeByte(12)
      ..write(obj.twitterUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedUserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LoginTypeAdapter extends TypeAdapter<LoginType> {
  @override
  final int typeId = 1;

  @override
  LoginType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LoginType.facebook;
      case 1:
        return LoginType.google;
      case 2:
        return LoginType.normal;
      default:
        return LoginType.facebook;
    }
  }

  @override
  void write(BinaryWriter writer, LoginType obj) {
    switch (obj) {
      case LoginType.facebook:
        writer.writeByte(0);
        break;
      case LoginType.google:
        writer.writeByte(1);
        break;
      case LoginType.normal:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
