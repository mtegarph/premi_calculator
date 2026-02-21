import 'package:calculator_agen/features/calculator/domain/entities/premi_user_result.dart';

class PremiUserResultModel extends PremiUserResult {
  const PremiUserResultModel(
      {required super.productId,
      required super.productName,
      required super.age,
      required super.up,
      required super.occupationalClass,
      required super.paymentFrequency,
      required super.latitude,
      required super.longitude,
      required super.calculatedPremium,
      required super.timestamp});

  factory PremiUserResultModel.fromJson(Map<String, dynamic> json) =>
      PremiUserResultModel(
          productId: json["product_id"],
          productName: json["product_name"],
          age: json["age"],
          up: json["up"],
          occupationalClass: json["occupational_class"],
          paymentFrequency: json["payment_frequency"],
          calculatedPremium: json["calculated_premium"],
          timestamp: DateTime.parse(json["timestamp"]),
          latitude: json["latitude"],
          longitude: json["longitude"]);

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "age": age,
        "up": up,
        "occupational_class": occupationalClass,
        "payment_frequency": paymentFrequency,
        "calculated_premium": calculatedPremium,
        "timestamp": timestamp.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude
      };
}
