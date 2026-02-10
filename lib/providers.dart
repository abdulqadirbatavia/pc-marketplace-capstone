import 'package:flutter/material.dart';
import 'models.dart';

// Cart Provider
class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];
  List<CartItem> get items => _items;
  
  void addToCart(Product product, {int quantity = 1}) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex != -1) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }
  
  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }
  
  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  
  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
  
  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }
}

// Auth Provider
class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = User(
      id: 'user1',
      name: 'John Doe',
      email: email,
      phone: '+1 (555) 123-4567',
      address: '123 Tech Street, Toronto, ON',
      joinedDate: DateTime.now(),
    );
    _isLoggedIn = true;
    notifyListeners();
  }
  
  Future<void> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = User(
      id: 'user${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      joinedDate: DateTime.now(),
    );
    _isLoggedIn = true;
    notifyListeners();
  }
  
  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }
  
  void updateProfile(String name, String? phone, String? address) {
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        name: name,
        email: _currentUser!.email,
        phone: phone,
        address: address,
        profileImage: _currentUser!.profileImage,
        joinedDate: _currentUser!.joinedDate,
      );
      notifyListeners();
    }
  }
}

// Product Provider
class ProductProvider extends ChangeNotifier {
  List<Product> _products = Product.getSampleProducts();
  List<Product> _filteredProducts = Product.getSampleProducts();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  
  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  String get selectedCategory => _selectedCategory;  // ADD THIS GETTER
  
  void searchProducts(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }
  
  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }
  
  void _applyFilters() {
    _filteredProducts = _products.where((product) {
      final matchesSearch = _searchQuery.isEmpty ||
          product.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesCategory = _selectedCategory == 'All' ||
          product.category == _selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }
  
  List<String> get categories {
    final allCategories = _products.map((p) => p.category).toSet().toList();
    return ['All', ...allCategories];
  }
  
  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
  
  List<Product> getRelatedProducts(String currentProductId, {int limit = 4}) {
    final currentProduct = getProductById(currentProductId);
    if (currentProduct == null) return [];
    
    return _products
        .where((p) => p.category == currentProduct.category && p.id != currentProductId)
        .take(limit)
        .toList();
  }
}