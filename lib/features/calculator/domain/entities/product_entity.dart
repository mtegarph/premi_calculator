class Product {
  String status;
  List<Datum> data;

  Product({
    required this.status,
    required this.data,
  });

  Product copyWith({
    String? status,
    List<Datum>? data,
  }) =>
      Product(
        status: status ?? this.status,
        data: data ?? this.data,
      );
}

class Datum {
  String id;
  String name;
  String category;
  String description;
  String imageUrl;
  int minEntryAge;
  int maxEntryAge;
  Setup setup;

  Datum({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.minEntryAge,
    required this.maxEntryAge,
    required this.setup,
  });

  Datum copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    int? minEntryAge,
    int? maxEntryAge,
    Setup? setup,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        minEntryAge: minEntryAge ?? this.minEntryAge,
        maxEntryAge: maxEntryAge ?? this.maxEntryAge,
        setup: setup ?? this.setup,
      );
}

class Setup {
  String currency;
  int baseRate;
  int adminFee;
  List<MortalityTable> mortalityTable;
  OccupationalClassMultiplier occupationalClassMultiplier;
  FrequencyDiscount frequencyDiscount;

  Setup({
    required this.currency,
    required this.baseRate,
    required this.adminFee,
    required this.mortalityTable,
    required this.occupationalClassMultiplier,
    required this.frequencyDiscount,
  });

  Setup copyWith({
    String? currency,
    int? baseRate,
    int? adminFee,
    List<MortalityTable>? mortalityTable,
    OccupationalClassMultiplier? occupationalClassMultiplier,
    FrequencyDiscount? frequencyDiscount,
  }) =>
      Setup(
        currency: currency ?? this.currency,
        baseRate: baseRate ?? this.baseRate,
        adminFee: adminFee ?? this.adminFee,
        mortalityTable: mortalityTable ?? this.mortalityTable,
        occupationalClassMultiplier:
            occupationalClassMultiplier ?? this.occupationalClassMultiplier,
        frequencyDiscount: frequencyDiscount ?? this.frequencyDiscount,
      );
}

class FrequencyDiscount {
  double monthly;
  double? quarterly;
  double? semiAnnually;
  double annually;

  FrequencyDiscount({
    required this.monthly,
    this.quarterly,
    this.semiAnnually,
    required this.annually,
  });

  FrequencyDiscount copyWith({
    double? monthly,
    double? quarterly,
    double? semiAnnually,
    double? annually,
  }) =>
      FrequencyDiscount(
        monthly: monthly ?? this.monthly,
        quarterly: quarterly ?? this.quarterly,
        semiAnnually: semiAnnually ?? this.semiAnnually,
        annually: annually ?? this.annually,
      );
}

class MortalityTable {
  String ageRange;
  double ratePerMille;

  MortalityTable({
    required this.ageRange,
    required this.ratePerMille,
  });

  MortalityTable copyWith({
    String? ageRange,
    double? ratePerMille,
  }) =>
      MortalityTable(
        ageRange: ageRange ?? this.ageRange,
        ratePerMille: ratePerMille ?? this.ratePerMille,
      );
}

class OccupationalClassMultiplier {
  double class1;
  double class2;
  double class3;
  double class4;

  OccupationalClassMultiplier({
    required this.class1,
    required this.class2,
    required this.class3,
    required this.class4,
  });

  OccupationalClassMultiplier copyWith({
    double? class1,
    double? class2,
    double? class3,
    double? class4,
  }) =>
      OccupationalClassMultiplier(
        class1: class1 ?? this.class1,
        class2: class2 ?? this.class2,
        class3: class3 ?? this.class3,
        class4: class4 ?? this.class4,
      );
}
