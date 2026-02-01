enum PartCategory {
  cpu,
  gpu,
  ram,
  motherboard,
  storage,
  psu,
  case,
  cooling,
  other
}

enum Condition {
  newSealed,
  likeNew,
  usedGood,
  usedFair,
  forParts
}

class PCPart {
  final String id;
  final String title;
  final String description;
  final PartCategory category;
  final double price;
  final Condition condition;
  final String sellerId;
  final String sellerName;
  final DateTime postedDate;
  final List<String> imageUrls;
  
  // Compatibility fields
  final String? socketType; // CPU/Motherboard
  final String? ramType; // DDR4, DDR5
  final String? formFactor; // ATX, mATX, ITX
  final int? wattage; // PSU
  final int? memorySize; // RAM, Storage
  final String? memoryType; // SSD, HDD, NVMe
  final String? chipset; // Motherboard

  PCPart({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.condition,
    required this.sellerId,
    required this.sellerName,
    required this.postedDate,
    required this.imageUrls,
    this.socketType,
    this.ramType,
    this.formFactor,
    this.wattage,
    this.memorySize,
    this.memoryType,
    this.chipset,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category.name,
      'price': price,
      'condition': condition.name,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'postedDate': postedDate.toIso8601String(),
      'imageUrls': imageUrls,
      'socketType': socketType,
      'ramType': ramType,
      'formFactor': formFactor,
      'wattage': wattage,
      'memorySize': memorySize,
      'memoryType': memoryType,
      'chipset': chipset,
    };
  }

  static PCPart fromMap(Map<String, dynamic> map) {
    return PCPart(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: PartCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => PartCategory.other,
      ),
      price: map['price'].toDouble(),
      condition: Condition.values.firstWhere(
        (e) => e.name == map['condition'],
        orElse: () => Condition.usedGood,
      ),
      sellerId: map['sellerId'],
      sellerName: map['sellerName'],
      postedDate: DateTime.parse(map['postedDate']),
      imageUrls: List<String>.from(map['imageUrls']),
      socketType: map['socketType'],
      ramType: map['ramType'],
      formFactor: map['formFactor'],
      wattage: map['wattage'],
      memorySize: map['memorySize'],
      memoryType: map['memoryType'],
      chipset: map['chipset'],
    );
  }

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  
  String get conditionText {
    switch (condition) {
      case Condition.newSealed:
        return 'New (Sealed)';
      case Condition.likeNew:
        return 'Like New';
      case Condition.usedGood:
        return 'Used - Good';
      case Condition.usedFair:
        return 'Used - Fair';
      case Condition.forParts:
        return 'For Parts';
    }
  }
}