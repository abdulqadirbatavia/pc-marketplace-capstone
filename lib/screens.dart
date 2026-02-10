import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'providers.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';
import 'utils.dart';

// ==================== LOGIN SCREEN ====================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
        _emailController.text,
        _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo/Title
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.computer,
                    size: 60,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'PC Part Marketplace',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onBackground,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Buy and sell PC components',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 40),

                // Login Form
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              if (!value.contains('@')) {
                                return 'Invalid email format';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              if (value.length < 6) {
                                return 'Minimum 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: _isLoading ? null : _login,
                              child: _isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Login', style: TextStyle(fontSize: 16)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text('Create Account'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== REGISTER SCREEN ====================
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    try {
      await Provider.of<AuthProvider>(context, listen: false).register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!value.contains('@')) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value.length < 6) {
                    return 'Minimum 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                ),
                obscureText: _obscureConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isLoading ? null : _register,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Create Account'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== HOME SCREEN ====================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContentScreen(),
    const MarketplaceScreen(),
    const SellScreen(),
    const BuildPCScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    
    if (!auth.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PC Part Marketplace'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: ProductSearchDelegate(),
            ),
            tooltip: 'Search',
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
                tooltip: 'Cart',
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      cart.itemCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.store_outlined), selectedIcon: Icon(Icons.store), label: 'Marketplace'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle), label: 'Sell'),
          NavigationDestination(icon: Icon(Icons.build_outlined), selectedIcon: Icon(Icons.build), label: 'Build PC'),
          NavigationDestination(icon: Icon(Icons.person_outlined), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ==================== HOME CONTENT ====================
class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Welcome Banner
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.primaryContainer, colorScheme.secondaryContainer],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Find the best deals on PC components',
                style: TextStyle(color: colorScheme.onPrimaryContainer),
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: () {},
                child: const Text('Browse Deals'),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Categories
        Text('Categories', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: productProvider.categories.map((category) {
              final icons = {
                'All': Icons.all_inclusive,
                'CPU': Icons.memory,
                'GPU': Icons.videogame_asset,
                'RAM': Icons.settings_input_component,
                'Storage': Icons.storage,
                'Motherboard': Icons.developer_board,
                'PSU': Icons.power,
                'Case': Icons.computer,
                'Cooling': Icons.ac_unit,
                'Monitor': Icons.monitor,
                'Peripheral': Icons.keyboard,
              };
              
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: FilterChip(
                  avatar: Icon(icons[category] ?? Icons.category, size: 20),
                  label: Text(category),
                  selected: productProvider.selectedCategory == category,
                  onSelected: (_) => productProvider.filterByCategory(category),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              );
            }).toList(),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Featured Listings
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Featured Listings', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('See All')),
          ],
        ),
        const SizedBox(height: 12),
        ...productProvider.products.take(5).map((product) => _buildProductCard(context, product)).toList(),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    final colorScheme = Theme.of(context).colorScheme;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(product.category, style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(product.rating.toStringAsFixed(1)),
                        Text(' (${product.reviewCount})', style: TextStyle(color: colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorScheme.primary)),
                  const SizedBox(height: 8),
                  FilledButton.tonal(
                    onPressed: () {
                      cartProvider.addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added ${product.title} to cart')),
                      );
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== MARKETPLACE SCREEN ====================
class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search PC parts...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                  ),
                  onChanged: productProvider.searchProducts,
                ),
              ),
              const SizedBox(width: 12),
              PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list),
                onSelected: productProvider.filterByCategory,
                itemBuilder: (_) => productProvider.categories.map((cat) => PopupMenuItem(value: cat, child: Text(cat))).toList(),
              ),
            ],
          ),
        ),
        
        Expanded(
          child: productProvider.filteredProducts.isEmpty
              ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No products found'),
                ]))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: productProvider.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = productProvider.filteredProducts[index];
                    return _buildProductGridCard(context, product);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildProductGridCard(BuildContext context, Product product) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Chip(label: Text(product.category), padding: EdgeInsets.zero),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(product.rating.toStringAsFixed(1)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SELL SCREEN ====================
class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedCategory = 'CPU';
  String _selectedCondition = 'New';
  List<String> _imageUrls = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Create Listing')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Images
              Text('Product Images', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _imageUrls.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                // Simulate image upload
                                setState(() {
                                  _imageUrls.add('https://picsum.photos/300/200?random=${_imageUrls.length + 100}');
                                });
                              },
                              child: const Text('Add Photos'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageUrls.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _imageUrls.length) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _imageUrls.add('https://picsum.photos/300/200?random=${_imageUrls.length + 100}');
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add, size: 30),
                                      Text('Add More'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Stack(
                              children: [
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(_imageUrls[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => setState(() => _imageUrls.removeAt(index)),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.close, size: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              
              const SizedBox(height: 20),
              
              // Product Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Product Title', prefixIcon: Icon(Icons.title)),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              
              const SizedBox(height: 16),
              
              // Category and Condition
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(labelText: 'Category', prefixIcon: Icon(Icons.category)),
                      items: productProvider.categories.where((c) => c != 'All').map((cat) {
                        return DropdownMenuItem(value: cat, child: Text(cat));
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedCategory = value!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCondition,
                      decoration: const InputDecoration(labelText: 'Condition', prefixIcon: Icon(Icons.check_circle_outline)),
                      items: const ['New', 'Used - Like New', 'Used - Good', 'Refurbished', 'Open Box'].map((cond) {
                        return DropdownMenuItem(value: cond, child: Text(cond));
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedCondition = value!),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Price
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price (\$)', prefixIcon: Icon(Icons.attach_money)),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Invalid number';
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description', prefixIcon: Icon(Icons.description)),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Create new product
                      final newProduct = Product(
                        id: 'new_${DateTime.now().millisecondsSinceEpoch}',
                        title: _titleController.text,
                        description: _descriptionController.text,
                        price: double.parse(_priceController.text),
                        category: _selectedCategory,
                        condition: _selectedCondition,
                        sellerName: 'Current User',
                        imageUrl: _imageUrls.isNotEmpty ? _imageUrls.first : 'https://picsum.photos/300/200?random=999',
                        specs: {},
                      );
                      
                      // Add to products (in real app, save to database)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Listing created successfully!')),
                      );
                      
                      // Clear form
                      _formKey.currentState!.reset();
                      setState(() {
                        _imageUrls.clear();
                        _selectedCategory = 'CPU';
                        _selectedCondition = 'New';
                      });
                    }
                  },
                  child: const Text('Create Listing'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== BUILD PC SCREEN ====================
class BuildPCScreen extends StatefulWidget {
  const BuildPCScreen({super.key});

  @override
  State<BuildPCScreen> createState() => _BuildPCScreenState();
}

class _BuildPCScreenState extends State<BuildPCScreen> {
  final Map<String, Product?> _selectedParts = {
    'CPU': null,
    'GPU': null,
    'Motherboard': null,
    'RAM': null,
    'Storage': null,
    'PSU': null,
    'Case': null,
    'Cooling': null,
  };

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(title: const Text('PC Builder')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Compatibility Checker Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.build_circle, size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PC Part Compatibility Checker', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Select components to check compatibility', style: TextStyle(color: colorScheme.onPrimaryContainer)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          // Check compatibility
                          final issues = _checkCompatibility();
                          if (issues.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('All components are compatible! ✅')),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Compatibility Issues'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: issues.map((issue) => Text('• $issue')).toList(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text('Check Compatibility'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () => setState(() => _selectedParts.clear()),
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Component Selection
          Text('Select Components', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          ..._selectedParts.keys.map((component) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(_getComponentIcon(component)),
                title: Text(component),
                subtitle: _selectedParts[component] != null
                    ? Text(_selectedParts[component]!.title)
                    : const Text('Not selected'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_selectedParts[component] != null)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () => setState(() => _selectedParts[component] = null),
                      ),
                    FilledButton.tonal(
                      onPressed: () => _showComponentPicker(context, component, productProvider),
                      child: const Text('Select'),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          
          // Total Price
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Selected Components:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${_selectedParts.values.where((p) => p != null).length}/8'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Price:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _selectedParts.values.any((p) => p != null)
                          ? () {
                              // Add all selected parts to cart
                              final cartProvider = Provider.of<CartProvider>(context, listen: false);
                              for (final product in _selectedParts.values) {
                                if (product != null) {
                                  cartProvider.addToCart(product);
                                }
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Added ${_selectedParts.values.where((p) => p != null).length} items to cart')),
                              );
                            }
                          : null,
                      child: const Text('Add All to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getComponentIcon(String component) {
    switch (component) {
      case 'CPU': return Icons.memory;
      case 'GPU': return Icons.videogame_asset;
      case 'Motherboard': return Icons.developer_board;
      case 'RAM': return Icons.settings_input_component;
      case 'Storage': return Icons.storage;
      case 'PSU': return Icons.power;
      case 'Case': return Icons.computer;
      case 'Cooling': return Icons.ac_unit;
      default: return Icons.category;
    }
  }

  void _showComponentPicker(BuildContext context, String component, ProductProvider productProvider) {
    final filteredProducts = productProvider.products
        .where((product) => product.category == component ||
            (component == 'Cooling' && product.category == 'Cooling') ||
            (component == 'Case' && product.category == 'Case') ||
            (component == 'PSU' && product.category == 'PSU'))
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select $component', style: Theme.of(context).textTheme.titleLarge),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filteredProducts.isEmpty
                    ? const Center(child: Text('No products available'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(product.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(product.title),
                              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                              trailing: FilledButton(
                                onPressed: () {
                                  setState(() => _selectedParts[component] = product);
                                  Navigator.pop(context);
                                },
                                child: const Text('Select'),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _calculateTotalPrice() {
    return _selectedParts.values.fold(0.0, (sum, product) {
      return sum + (product?.price ?? 0);
    });
  }

  List<String> _checkCompatibility() {
    final issues = <String>[];
    
    // Check if CPU and motherboard are compatible (simplified)
    final cpu = _selectedParts['CPU'];
    final motherboard = _selectedParts['Motherboard'];
    
    if (cpu != null && motherboard != null) {
      // Simple check based on product names
      if (cpu.title.contains('AMD') && !motherboard.title.contains('AMD')) {
        issues.add('CPU and motherboard may not be compatible (AMD CPU requires AMD motherboard)');
      }
      if (cpu.title.contains('Intel') && !motherboard.title.contains('Intel')) {
        issues.add('CPU and motherboard may not be compatible (Intel CPU requires Intel motherboard)');
      }
    }
    
    // Check if PSU wattage is sufficient
    final psu = _selectedParts['PSU'];
    if (psu != null) {
      final totalPower = _calculateTotalPrice() / 10; // Simplified power calculation
      if (totalPower > 500 && psu.title.contains('450')) {
        issues.add('PSU wattage may be insufficient for selected components');
      }
    }
    
    // Check if case supports motherboard size
    final pcCase = _selectedParts['Case'];
    if (pcCase != null && motherboard != null) {
      if (motherboard.title.contains('E-ATX') && !pcCase.title.contains('E-ATX')) {
        issues.add('Case may not support E-ATX motherboard size');
      }
    }
    
    return issues;
  }
}

// ==================== PROFILE SCREEN ====================
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    final colorScheme = Theme.of(context).colorScheme;
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Profile Header
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: colorScheme.primaryContainer,
                  child: user.profileImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(user.profileImage!, fit: BoxFit.cover),
                        )
                      : Icon(Icons.person, size: 50, color: colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 16),
                Text(user.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(user.email, style: TextStyle(color: colorScheme.onSurfaceVariant)),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileScreen())),
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Menu Items
        _buildMenuItem(context, Icons.shopping_bag_outlined, 'My Orders', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => OrdersScreen()));
        }),
        _buildMenuItem(context, Icons.favorite_outline, 'Wishlist', () {}),
        _buildMenuItem(context, Icons.history, 'Purchase History', () {}),
        _buildMenuItem(context, Icons.settings_outlined, 'Settings', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
        }),
        _buildMenuItem(context, Icons.help_outline, 'Help & Support', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => HelpSupportScreen()));
        }),
        
        const SizedBox(height: 16),
        
        OutlinedButton.icon(
          onPressed: () {
            authProvider.logout();
            Navigator.pushReplacementNamed(context, '/');
          },
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// ==================== SETTINGS SCREEN ====================
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = false;
  String _currency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Appearance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    value: _darkMode,
                    onChanged: (value) => setState(() => _darkMode = value),
                  ),
                  ListTile(
                    title: const Text('Currency'),
                    subtitle: Text(_currency),
                    trailing: DropdownButton<String>(
                      value: _currency,
                      items: const ['USD', 'CAD', 'EUR', 'GBP'].map((currency) {
                        return DropdownMenuItem(value: currency, child: Text(currency));
                      }).toList(),
                      onChanged: (value) => setState(() => _currency = value!),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Notifications
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Push Notifications'),
                    value: _notifications,
                    onChanged: (value) => setState(() => _notifications = value),
                  ),
                  SwitchListTile(
                    title: const Text('Email Notifications'),
                    value: true,
                    onChanged: (value) {},
                  ),
                  SwitchListTile(
                    title: const Text('Price Drop Alerts'),
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Privacy & Security
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Privacy & Security', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ListTile(
                    title: const Text('Change Password'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Terms of Service'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Save Button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings saved')),
                );
              },
              child: const Text('Save Settings'),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== EDIT PROFILE SCREEN ====================
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  String? _profileImage;

  @override
  void initState() {
    super.initState();
    final authProvider = context.read<AuthProvider>();
    final user = authProvider.currentUser;
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _phoneController.text = user.phone ?? '';
      _addressController.text = user.address ?? '';
      _profileImage = user.profileImage;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Picture
              GestureDetector(
                onTap: () {
                  // Simulate image picker
                  setState(() {
                    _profileImage = 'https://picsum.photos/200/200?random=999';
                  });
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: _profileImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(_profileImage!, fit: BoxFit.cover),
                        )
                      : const Icon(Icons.person, size: 60),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _profileImage = 'https://picsum.photos/200/200?random=999';
                  });
                },
                child: const Text('Change Profile Picture'),
              ),
              
              const SizedBox(height: 24),
              
              // Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              
              const SizedBox(height: 16),
              
              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (!value.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Phone
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              
              const SizedBox(height: 16),
              
              // Address
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.location_on),
                ),
                maxLines: 3,
              ),
              
              const SizedBox(height: 32),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authProvider.updateProfile(
                        _nameController.text,
                        _phoneController.text.isEmpty ? null : _phoneController.text,
                        _addressController.text.isEmpty ? null : _addressController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile updated')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== ORDERS SCREEN ====================
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {'id': 'ORD-001', 'date': '2024-01-15', 'total': 299.99, 'status': 'Delivered', 'items': 1},
      {'id': 'ORD-002', 'date': '2024-01-10', 'total': 729.98, 'status': 'Processing', 'items': 2},
      {'id': 'ORD-003', 'date': '2023-12-20', 'total': 149.99, 'status': 'Delivered', 'items': 1},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: orders.isEmpty
          ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('No orders yet'),
              SizedBox(height: 8),
              Text('Start shopping to see your orders here'),
            ]))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.shopping_bag),
                    ),
                    title: Text('Order ${order['id']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${order['date']}'),
                        Text('Items: ${order['items']}'),
                        Text('Status: ${order['status']}'),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\$${order['total']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Chip(
                          label: Text(order['status'].toString()),
                          backgroundColor: order['status'] == 'Delivered'
                              ? Colors.green[100]
                              : order['status'] == 'Processing'
                                  ? Colors.blue[100]
                                  : Colors.orange[100],
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ==================== HELP & SUPPORT SCREEN ====================
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Contact Information
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Contact Us', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: const Text('support@pcmarketplace.com'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: const Text('+1 (800) 123-4567'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.schedule),
                    title: const Text('Hours'),
                    subtitle: const Text('Mon-Fri: 9AM-5PM EST'),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // FAQ
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Frequently Asked Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text('How do I create a listing?'),
                    children: [const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Go to the Sell tab and click "Create Listing". Fill in the product details, upload photos, and set your price.'),
                    )],
                  ),
                  ExpansionTile(
                    title: const Text('How does the compatibility checker work?'),
                    children: [const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('The compatibility checker analyzes selected PC components based on specifications like socket type, form factor, and power requirements to ensure they work together.'),
                    )],
                  ),
                  ExpansionTile(
                    title: const Text('What payment methods are accepted?'),
                    children: [const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('We accept credit/debit cards, PayPal, and bank transfers for secure transactions.'),
                    )],
                  ),
                  ExpansionTile(
                    title: const Text('How do I track my order?'),
                    children: [const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Once your order ships, you\'ll receive a tracking number via email. You can also view order status in your profile.'),
                    )],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Send Message
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Send us a Message', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Message sent successfully!')),
                        );
                      },
                      child: const Text('Send Message'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== PRODUCT SEARCH DELEGATE ====================
class ProductSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    productProvider.searchProducts(query);
    
    final results = query.isEmpty ? productProvider.products : productProvider.filteredProducts;
    
    if (results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No products found'),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(product.title),
            subtitle: Text('\$${product.price.toStringAsFixed(2)} • ${product.category}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
              close(context, null);
            },
          ),
        );
      },
    );
  }
}