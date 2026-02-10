// Product Model
class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String condition;
  final String sellerName;
  final String imageUrl;
  final Map<String, dynamic> specs;
  final int stock;
  final double rating;
  final int reviewCount;
  
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.condition,
    required this.sellerName,
    required this.imageUrl,
    required this.specs,
    this.stock = 1,
    this.rating = 4.5,
    this.reviewCount = 0,
  });
  
  // Generate sample products
  static List<Product> getSampleProducts() {
    return [
      Product(
        id: '1',
        title: 'AMD Ryzen 7 5800X',
        description: '8-core, 16-thread processor, 3.8GHz base, 4.7GHz boost',
        price: 299.99,
        category: 'CPU',
        condition: 'New',
        sellerName: 'TechStore Inc.',
        imageUrl: 'https://picsum.photos/300/200?random=1',
        specs: {
          'Cores': '8',
          'Threads': '16',
          'Socket': 'AM4',
          'TDP': '105W',
          'Cache': '32MB',
        },
        rating: 4.8,
        reviewCount: 124,
      ),
      Product(
        id: '2',
        title: 'NVIDIA GeForce RTX 4070',
        description: '12GB GDDR6X, DLSS 3, Ray Tracing',
        price: 599.99,
        category: 'GPU',
        condition: 'New',
        sellerName: 'Gaming Hardware',
        imageUrl: 'https://picsum.photos/300/200?random=2',
        specs: {
          'Memory': '12GB GDDR6X',
          'Bus Width': '192-bit',
          'CUDA Cores': '5888',
          'Boost Clock': '2475 MHz',
        },
        rating: 4.7,
        reviewCount: 89,
      ),
      Product(
        id: '3',
        title: '32GB DDR4 3600MHz RAM',
        description: '2x16GB Kit, CL18, RGB Lighting',
        price: 89.99,
        category: 'RAM',
        condition: 'New',
        sellerName: 'Memory Masters',
        imageUrl: 'https://picsum.photos/300/200?random=3',
        specs: {
          'Capacity': '32GB (2x16GB)',
          'Speed': '3600MHz',
          'Timing': 'CL18',
          'Type': 'DDR4',
        },
        rating: 4.6,
        reviewCount: 56,
      ),
      Product(
        id: '4',
        title: 'Samsung 1TB NVMe SSD',
        description: 'PCIe 4.0, 7000MB/s read, 5300MB/s write',
        price: 129.99,
        category: 'Storage',
        condition: 'New',
        sellerName: 'Storage Solutions',
        imageUrl: 'https://picsum.photos/300/200?random=4',
        specs: {
          'Capacity': '1TB',
          'Interface': 'PCIe 4.0',
          'Read Speed': '7000 MB/s',
          'Write Speed': '5300 MB/s',
        },
        rating: 4.9,
        reviewCount: 203,
      ),
      Product(
        id: '5',
        title: 'ASUS ROG B550-F Gaming',
        description: 'AMD AM4, WiFi 6, 2.5Gb LAN',
        price: 179.99,
        category: 'Motherboard',
        condition: 'New',
        sellerName: 'ASUS Store',
        imageUrl: 'https://picsum.photos/300/200?random=5',
        specs: {
          'Socket': 'AM4',
          'Chipset': 'B550',
          'Form Factor': 'ATX',
          'Memory Slots': '4',
        },
        rating: 4.5,
        reviewCount: 78,
      ),
      Product(
        id: '6',
        title: 'Corsair RM850x PSU',
        description: '850W 80 Plus Gold, Fully Modular',
        price: 149.99,
        category: 'PSU',
        condition: 'New',
        sellerName: 'Power Supplies R Us',
        imageUrl: 'https://picsum.photos/300/200?random=6',
        specs: {
          'Wattage': '850W',
          'Efficiency': '80 Plus Gold',
          'Modular': 'Full',
          'Warranty': '10 years',
        },
        rating: 4.8,
        reviewCount: 142,
      ),
      Product(
        id: '7',
        title: 'NZXT H510 Elite Case',
        description: 'Mid Tower, Tempered Glass, RGB',
        price: 149.99,
        category: 'Case',
        condition: 'New',
        sellerName: 'Case Mods',
        imageUrl: 'https://picsum.photos/300/200?random=7',
        specs: {
          'Type': 'Mid Tower',
          'Motherboard': 'ATX',
          'Expansion Slots': '7',
          'Drive Bays': '2+3',
        },
        rating: 4.4,
        reviewCount: 91,
      ),
      Product(
        id: '8',
        title: 'Noctua NH-D15 Cooler',
        description: 'Dual Tower, 6 Heat Pipes, 140mm Fans',
        price: 99.99,
        category: 'Cooling',
        condition: 'New',
        sellerName: 'Cooling Solutions',
        imageUrl: 'https://picsum.photos/300/200?random=8',
        specs: {
          'Type': 'Air Cooler',
          'Compatibility': 'Intel/AMD',
          'Heat Pipes': '6',
          'Fans': '2x 140mm',
        },
        rating: 4.9,
        reviewCount: 256,
      ),
      Product(
        id: '9',
        title: 'Intel Core i7-13700K',
        description: '16-core (8P+8E), 5.4GHz boost, LGA1700',
        price: 399.99,
        category: 'CPU',
        condition: 'New',
        sellerName: 'TechStore Inc.',
        imageUrl: 'https://picsum.photos/300/200?random=9',
        specs: {
          'Cores': '16 (8P+8E)',
          'Threads': '24',
          'Socket': 'LGA1700',
          'TDP': '125W',
        },
        rating: 4.7,
        reviewCount: 89,
      ),
      Product(
        id: '10',
        title: 'AMD Radeon RX 7800 XT',
        description: '16GB GDDR6, 256-bit, Ray Accelerators',
        price: 499.99,
        category: 'GPU',
        condition: 'New',
        sellerName: 'Gaming Hardware',
        imageUrl: 'https://picsum.photos/300/200?random=10',
        specs: {
          'Memory': '16GB GDDR6',
          'Bus Width': '256-bit',
          'Stream Processors': '3840',
          'Boost Clock': '2430 MHz',
        },
        rating: 4.5,
        reviewCount: 56,
      ),
      Product(
        id: '11',
        title: '64GB DDR5 6000MHz RAM',
        description: '2x32GB Kit, CL30, EXPO Certified',
        price: 199.99,
        category: 'RAM',
        condition: 'New',
        sellerName: 'Memory Masters',
        imageUrl: 'https://picsum.photos/300/200?random=11',
        specs: {
          'Capacity': '64GB (2x32GB)',
          'Speed': '6000MHz',
          'Timing': 'CL30',
          'Type': 'DDR5',
        },
        rating: 4.8,
        reviewCount: 42,
      ),
      Product(
        id: '12',
        title: 'Western Digital 2TB NVMe',
        description: 'PCIe 4.0, 7300MB/s read, 6900MB/s write',
        price: 149.99,
        category: 'Storage',
        condition: 'Used - Good',
        sellerName: 'Storage Solutions',
        imageUrl: 'https://picsum.photos/300/200?random=12',
        specs: {
          'Capacity': '2TB',
          'Interface': 'PCIe 4.0',
          'Read Speed': '7300 MB/s',
          'Write Speed': '6900 MB/s',
        },
        rating: 4.4,
        reviewCount: 23,
      ),
      Product(
        id: '13',
        title: 'Gigabyte X670 AORUS Elite',
        description: 'AMD AM5, PCIe 5.0, WiFi 6E',
        price: 299.99,
        category: 'Motherboard',
        condition: 'New',
        sellerName: 'ASUS Store',
        imageUrl: 'https://picsum.photos/300/200?random=13',
        specs: {
          'Socket': 'AM5',
          'Chipset': 'X670',
          'Form Factor': 'ATX',
          'Memory Slots': '4',
        },
        rating: 4.6,
        reviewCount: 34,
      ),
      Product(
        id: '14',
        title: 'Seasonic 1000W PSU',
        description: '80 Plus Gold, Full Modular, Silent',
        price: 199.99,
        category: 'PSU',
        condition: 'New',
        sellerName: 'Power Supplies R Us',
        imageUrl: 'https://picsum.photos/300/200?random=14',
        specs: {
          'Wattage': '1000W',
          'Efficiency': '80 Plus Gold',
          'Modular': 'Full',
          'Warranty': '10 years',
        },
        rating: 4.9,
        reviewCount: 178,
      ),
      Product(
        id: '15',
        title: 'Lian Li O11 Dynamic EVO',
        description: 'Dual Chamber, E-ATX, 8+ Drive Bays',
        price: 169.99,
        category: 'Case',
        condition: 'New',
        sellerName: 'Case Mods',
        imageUrl: 'https://picsum.photos/300/200?random=15',
        specs: {
          'Type': 'Mid Tower',
          'Motherboard': 'E-ATX',
          'Expansion Slots': '8',
          'Drive Bays': '4+2',
        },
        rating: 4.7,
        reviewCount: 203,
      ),
      Product(
        id: '16',
        title: 'Arctic Liquid Freezer II 360',
        description: '360mm AIO, 3x P12 Fans, PWM Pump',
        price: 119.99,
        category: 'Cooling',
        condition: 'New',
        sellerName: 'Cooling Solutions',
        imageUrl: 'https://picsum.photos/300/200?random=16',
        specs: {
          'Type': 'AIO Liquid',
          'Radiator': '360mm',
          'Fans': '3x 120mm',
          'Compatibility': 'Intel/AMD',
        },
        rating: 4.8,
        reviewCount: 167,
      ),
      Product(
        id: '17',
        title: 'Dell 27" 1440p Monitor',
        description: '165Hz, 1ms, G-Sync, IPS Panel',
        price: 349.99,
        category: 'Monitor',
        condition: 'Refurbished',
        sellerName: 'Monitor Depot',
        imageUrl: 'https://picsum.photos/300/200?random=17',
        specs: {
          'Size': '27"',
          'Resolution': '2560x1440',
          'Refresh Rate': '165Hz',
          'Panel': 'IPS',
        },
        rating: 4.6,
        reviewCount: 134,
      ),
      Product(
        id: '18',
        title: 'Logitech G Pro X Keyboard',
        description: 'Mechanical, GX Blue Switches, RGB',
        price: 129.99,
        category: 'Peripheral',
        condition: 'Used - Like New',
        sellerName: 'Gaming Gear',
        imageUrl: 'https://picsum.photos/300/200?random=18',
        specs: {
          'Type': 'Mechanical',
          'Switches': 'GX Blue',
          'Backlight': 'RGB',
          'Layout': 'TKL',
        },
        rating: 4.3,
        reviewCount: 67,
      ),
      Product(
        id: '19',
        title: 'Razer Viper V2 Pro Mouse',
        description: 'Wireless, 59g, 30000 DPI, 80hr Battery',
        price: 149.99,
        category: 'Peripheral',
        condition: 'New',
        sellerName: 'Gaming Gear',
        imageUrl: 'https://picsum.photos/300/200?random=19',
        specs: {
          'Type': 'Wireless',
          'Sensor': 'Focus Pro 30K',
          'DPI': '30000',
          'Weight': '59g',
        },
        rating: 4.6,
        reviewCount: 92,
      ),
      Product(
        id: '20',
        title: 'LG 34" Ultrawide Monitor',
        description: '3440x1440, 160Hz, Curved, HDR400',
        price: 699.99,
        category: 'Monitor',
        condition: 'Open Box',
        sellerName: 'Monitor Depot',
        imageUrl: 'https://picsum.photos/300/200?random=20',
        specs: {
          'Size': '34"',
          'Resolution': '3440x1440',
          'Refresh Rate': '160Hz',
          'Curvature': '1900R',
        },
        rating: 4.7,
        reviewCount: 156,
      ),
    ];
  }
}

// Cart Item Model
class CartItem {
  final Product product;
  int quantity;
  
  CartItem({
    required this.product,
    this.quantity = 1,
  });
  
  double get totalPrice => product.price * quantity;
}

// User Model
class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? profileImage;
  final DateTime joinedDate;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.profileImage,
    required this.joinedDate,
  });
}