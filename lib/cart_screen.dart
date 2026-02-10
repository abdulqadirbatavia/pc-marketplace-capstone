import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'providers.dart';
import 'product_detail_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    
    // Check if user is logged in
    if (!authProvider.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('Please login to view your cart', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                child: const Text('Go to Login'),
              ),
            ],
          ),
        ),
      );
    }
    
    // Check if cart is empty
    if (cartProvider.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('Your cart is empty', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text(
                'Add some PC parts to get started!',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Continue Shopping'),
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear Cart'),
                  content: const Text('Are you sure you want to clear your cart?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        cartProvider.clearCart();
                        Navigator.pop(context);
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
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
                          image: NetworkImage(item.product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(item.product.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\$${item.product.price.toStringAsFixed(2)} each'),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: () => cartProvider.updateQuantity(
                                item.product.id,
                                item.quantity - 1,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            Container(
                              width: 30,
                              alignment: Alignment.center,
                              child: Text(item.quantity.toString()),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () => cartProvider.updateQuantity(
                                item.product.id,
                                item.quantity + 1,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${item.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18),
                          onPressed: () => cartProvider.removeFromCart(item.product.id),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: item.product),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Checkout Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    Text('\$${cartProvider.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    const Text('\$0.00', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax (13%)', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    Text('\$${(cartProvider.totalAmount * 0.13).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      '\$${(cartProvider.totalAmount * 1.13).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                    onPressed: () => _showCheckoutDialog(context, cartProvider),
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showCheckoutDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Checkout'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment gateway integration would be implemented here.'),
            SizedBox(height: 16),
            Text('For this demo:'),
            Text('• Enter payment details'),
            Text('• Process transaction'),
            Text('• Generate order confirmation'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // Simulate successful payment
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment successful! Order confirmed.')),
              );
              cartProvider.clearCart();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Confirm Payment'),
          ),
        ],
      ),
    );
  }
}