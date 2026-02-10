import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'providers.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  
  const ProductDetailScreen({super.key, required this.product});
  
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  int _quantity = 1;
  
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final relatedProducts = productProvider.getRelatedProducts(widget.product.id);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.network(
                    widget.product.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.title,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Condition and Rating
                    Row(
                      children: [
                        Chip(
                          label: Text(widget.product.condition),
                          backgroundColor: widget.product.condition == 'New'
                              ? Colors.green[100]
                              : widget.product.condition == 'Used - Like New'
                                  ? Colors.blue[100]
                                  : Colors.orange[100],
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(widget.product.rating.toStringAsFixed(1)),
                            Text(' (${widget.product.reviewCount} reviews)', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Seller Info
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const CircleAvatar(child: Icon(Icons.person)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.product.sellerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Verified Seller', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12)),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text('Contact'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Description
                    Text('Description', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(widget.product.description),
                    
                    const SizedBox(height: 24),
                    
                    // Specifications
                    Text('Specifications', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: widget.product.specs.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(entry.key, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                  Text(entry.value.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    
                    // Related Products
                    if (relatedProducts.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text('Related Products', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: relatedProducts.length,
                          itemBuilder: (context, index) {
                            final product = relatedProducts[index];
                            return SizedBox(
                              width: 200,
                              child: Card(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailScreen(product: product),
                                      ),
                                    );
                                  },
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
                                            Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 24),
                    
                    // Add to Cart Section
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: _quantity > 1
                                          ? () => setState(() => _quantity--)
                                          : null,
                                    ),
                                    Container(width: 40, alignment: Alignment.center, child: Text(_quantity.toString())),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: _quantity < widget.product.stock
                                          ? () => setState(() => _quantity++)
                                          : null,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Provider.of<CartProvider>(context, listen: false)
                                          .addToCart(widget.product, quantity: _quantity);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Added ${widget.product.title} to cart'),
                                          action: SnackBarAction(
                                            label: 'View Cart',
                                            onPressed: () {
                                              // Navigate to cart
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text('Add to Cart'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () {
                                      Provider.of<CartProvider>(context, listen: false)
                                          .addToCart(widget.product, quantity: _quantity);
                                      // Navigate to checkout
                                    },
                                    child: const Text('Buy Now'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}