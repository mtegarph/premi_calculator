import 'package:calculator_agen/features/calculator/domain/entities/product_entity.dart';

class ProductModel extends Product {
  ProductModel({required super.status, required super.data});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => DatumModel.fromJson(x))),
      );
}

class DatumModel extends Datum {
  DatumModel(
      {required super.id,
      required super.name,
      required super.category,
      required super.description,
      required super.imageUrl,
      required super.minEntryAge,
      required super.maxEntryAge,
      required super.setup});
  @override
  String toString() {
    return "DatumModel(id: $id | name: $name | cat: $category | ages: $minEntryAge–$maxEntryAge)";
  }

  factory DatumModel.fromJson(Map<String, dynamic> json) {
    return DatumModel(
      id: json["id"],
      name: json["name"] ?? "MISSING NAME",
      category: json["category"] ?? "MISSING",
      description: json["description"] ?? "",
      imageUrl: json["image_url"] ?? json["image"] ?? "no-image",
      minEntryAge: json["min_entry_age"],
      maxEntryAge: json["max_entry_age"],
      setup: SetupModel.fromJson(json["setup"] ?? {}),
    );
  }
}

class SetupModel extends Setup {
  SetupModel(
      {required super.currency,
      required super.baseRate,
      required super.adminFee,
      required super.mortalityTable,
      required super.occupationalClassMultiplier,
      required super.frequencyDiscount});

  factory SetupModel.fromJson(Map<String, dynamic> json) => SetupModel(
        currency: json["currency"],
        baseRate: json["base_rate"],
        adminFee: json["admin_fee"],
        mortalityTable: List<MortalityTable>.from(json["mortality_table"]
            .map((x) => MortalityTableModel.fromJson(x))),
        occupationalClassMultiplier: OccupationalClassMultiplierModel.fromJson(
            json["occupational_class_multiplier"]),
        frequencyDiscount:
            FrequencyDiscountModel.fromJson(json["frequency_discount"]),
      );
}

class MortalityTableModel extends MortalityTable {
  MortalityTableModel({required super.ageRange, required super.ratePerMille});

  factory MortalityTableModel.fromJson(Map<String, dynamic> json) =>
      MortalityTableModel(
        ageRange: json["age_range"],
        ratePerMille: json["rate_per_mille"]?.toDouble(),
      );
}

class OccupationalClassMultiplierModel extends OccupationalClassMultiplier {
  OccupationalClassMultiplierModel(
      {required super.class1,
      required super.class2,
      required super.class3,
      required super.class4});
  factory OccupationalClassMultiplierModel.fromJson(
          Map<String, dynamic> json) =>
      OccupationalClassMultiplierModel(
        class1: json["class_1"],
        class2: json["class_2"],
        class3: json["class_3"],
        class4: json["class_4"],
      );
}

class FrequencyDiscountModel extends FrequencyDiscount {
  FrequencyDiscountModel(
      {required super.monthly,
      required super.annually,
      super.quarterly,
      super.semiAnnually});

  factory FrequencyDiscountModel.fromJson(Map<String, dynamic> json) =>
      FrequencyDiscountModel(
        monthly: json["monthly"],
        quarterly: json["quarterly"]?.toDouble(),
        semiAnnually: json["semi_annually"]?.toDouble(),
        annually: json["annually"]?.toDouble(),
      );
}
