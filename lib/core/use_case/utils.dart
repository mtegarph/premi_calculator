import 'dart:convert';
import 'dart:typed_data';

export 'dart:convert';

/// Format time into HH:mm:ss
String formattedTime(int? timeInSeconds) {
  if (timeInSeconds == null) return '-';

  final buffer = StringBuffer();

  final hours = timeInSeconds ~/ (60 * 60);
  buffer.write('$hours'.padLeft(2, '0'));
  buffer.write(':');

  final minutes = (timeInSeconds ~/ 60) - (hours * 60);
  buffer.write('$minutes'.padLeft(2, '0'));
  buffer.write(':');

  final seconds = timeInSeconds - (minutes * 60) - (hours * 60 * 60);
  buffer.write('${seconds <= 0 ? 0 : seconds}'.padLeft(2, '0'));
  return buffer.toString();
}

/// Convert dynamic data to specific type in [T].
/// If not it will return null.
///
/// To convert numeric value, please consider
/// using [intDeserializer] or [doubleDeserializer]
T? convertType<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

/// [convertType] but for [List] type.
///
/// Dart doesn't know type inside generic type <T> of [List]
/// unless it defined before compile.
///
/// Don't put generic type inside generic type,
/// like `convertListType<List<String>>`.
List<T> convertListType<T>(dynamic value) {
  if (value is! List) {
    return <T>[];
  }

  final realValue = value.whereType<T>().toList();
  return realValue;
}

/// [convertType] but for [Map] type.
///
/// Dart doesn't know type inside generic type <K, V> of [Map]
/// unless it defined before compile.
///
/// Don't put generic type inside generic type,
/// like `convertMapType<String, List<String>>`.
Map<K, V> convertMapType<K, V>(dynamic value) {
  if (value is! Map) {
    return <K, V>{};
  }

  final realValue = <K, V>{};
  for (final entry in value.entries) {
    final key = entry.key;
    final value = entry.value;
    if (key is K && value is V) {
      realValue[key] = value;
    }
  }

  return realValue;
}

bool? boolDeserializer(Object? value) {
  if (value == null) return null;
  if (value is int) {
    return value == 1;
  }
  return switch (value.toString().toLowerCase()) {
    == '1' || == 'true' => true,
    _ => false,
  };
}

String boolSerializer(bool value) => value ? '1' : '0';

String stringSerializer(dynamic value) => '$value';

int? intDeserializer(Object? value) {
  return value is int
      ? value
      : value is num
          ? value.toInt()
          : int.tryParse('$value');
}

double? doubleDeserializer(Object? value) {
  return value is double
      ? value
      : value is num
          ? value.toDouble()
          : double.tryParse('$value');
}

String? toDateString(DateTime? dateTime) {
  return dateTime?.toIso8601String().substring(0, 10);
}

String ensureErrorMessage([String? message]) {
  return message ?? 'unknown error';
}

extension StringUtil on String {
  String toUpperFirstChar() {
    if (length >= 2) {
      return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    } else if (length > 0) {
      return this[0].toUpperCase();
    }

    return this;
  }

  String toUpperFirstCharEachWord() {
    return split(' ').map((e) => e.toUpperFirstChar()).join(' ');
  }

  String toAbbreviation() {
    return split(' ').map((e) => e[0]).join().toUpperCase();
  }

  String removeWordBeforeComma() {
    final int commaIndex = indexOf(', ');

    if (commaIndex == -1) {
      return this;
    }

    return substring(commaIndex+1).trim();
  }

  String removeDuplicate() {
    return split(',').map((e) => e.trim()).toList().toSet().join(', ');
  }

  /// Same as [utf8.encode]
  ///
  /// Throws [FormatException] if [this] is not encodeable
  List<int> toUtf8Bytes() {
    return utf8.encode(this);
  }

  /// Same as [base64.decode]
  ///
  /// Throws [FormatException] if [this] is not decodeable
  Uint8List toBase64Bytes() {
    return base64.decode(this);
  }

  /// Throws [FormatException] if [this] is not decodeable
  String toUtf8FromBase64String() {
    return toBase64Bytes().toUtf8String();
  }

  /// Throws [FormatException] if [this] is not encodeable
  String toBase64FromUtf8String() {
    return toUtf8Bytes().toBase64String();
  }

  /// Same as [json.decode] but it's really a json map
  ///
  /// Throws [FormatException] if [this] is not decodeable
  /// Throws [TypeError] if result type is not correct
  T decodeJson<T>() {
    return json.decode(this);
  }

  /// Throws [FormatException] if [this] is not encodeable
  String toHexString() {
    return toUtf8Bytes().toHexString();
  }
}

extension BytesUtil on List<int> {
  /// Throws [FormatException] if [this] is not decodeable
  String toUtf8String() {
    return utf8.decode(this);
  }

  /// Throws [FormatException] if [this] is not encodeable
  String toBase64String() {
    return base64.encode(this);
  }

  String toHexString() {
    return map((e) => e.toRadixString(16)).join().toUpperCase();
  }
}
