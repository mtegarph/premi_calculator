import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class PremiUserResult extends Equatable {
  final String productId;
  final String productName;
  final int age;
  final double up;
  final String occupationalClass;
  final String paymentFrequency;
  final double calculatedPremium;
  final DateTime timestamp;
  final double longitude;
  final double latitude;

  const PremiUserResult(
      {required this.productId,
      required this.productName,
      required this.age,
      required this.up,
      required this.occupationalClass,
      required this.paymentFrequency,
      required this.calculatedPremium,
      required this.timestamp,
      required this.longitude,
      required this.latitude});

  PremiUserResult copyWith(
          {String? productId,
          String? productName,
          int? age,
          double? up,
          String? occupationalClass,
          String? paymentFrequency,
          double? calculatedPremium,
          DateTime? timestamp,
          double? longitude,
          double? latitude}) =>
      PremiUserResult(
          productId: productId ?? this.productId,
          productName: productName ?? this.productName,
          age: age ?? this.age,
          up: up ?? this.up,
          occupationalClass: occupationalClass ?? this.occupationalClass,
          paymentFrequency: paymentFrequency ?? this.paymentFrequency,
          calculatedPremium: calculatedPremium ?? this.calculatedPremium,
          timestamp: timestamp ?? this.timestamp,
          latitude: latitude ?? this.latitude,
          longitude: longitude ?? this.longitude);

  @override
  List<Object?> get props => [
        productId,
        productName,
        age,
        up,
        occupationalClass,
        latitude,
        longitude,
        paymentFrequency,
        calculatedPremium,
        timestamp
      ];
}
