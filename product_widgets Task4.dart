import 'package:flutter/material.dart';

typedef ProductTapCallback = Future<void> Function(int index);
typedef FavoritePressedCallback = void Function(int index);

class ProductsListView extends StatelessWidget {
  const ProductsListView({
    super.key,
    required this.products,
    required this.onFavoritePressed,
    required this.onProductTap,
  });

  final List<Map<String, dynamic>> products;
  final FavoritePressedCallback onFavoritePressed;
  final ProductTapCallback onProductTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductCard(
          product: product,
          isGrid: false,
          onFavoritePressed: () => onFavoritePressed(index),
          onProductTap: () => onProductTap(index),
        );
      },
    );
  }
}

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
    required this.products,
    required this.onFavoritePressed,
    required this.onProductTap,
  });

  final List<Map<String, dynamic>> products;
  final FavoritePressedCallback onFavoritePressed;
  final ProductTapCallback onProductTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.45,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductCard(
          product: product,
          isGrid: true,
          onFavoritePressed: () => onFavoritePressed(index),
          onProductTap: () => onProductTap(index),
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.isGrid,
    required this.onFavoritePressed,
    required this.onProductTap,
  });

  final Map<String, dynamic> product;
  final bool isGrid;
  final VoidCallback onFavoritePressed;
  final VoidCallback onProductTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = product['name'].toString();
    final price = (product['price'] as num).toDouble();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onProductTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: isGrid ? 70 : 76,
                height: isGrid ? 70 : 76,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  _iconFor(name),
                  size: 34,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (!isGrid) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Tap to view details',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Add to favorites',
                onPressed: onFavoritePressed,
                icon: const Icon(Icons.favorite_border_rounded),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String name) {
    switch (name.toLowerCase()) {
      case 'laptop':
        return Icons.laptop_mac_rounded;
      case 'headphones':
        return Icons.headphones_rounded;
      case 'smartphone':
        return Icons.smartphone_rounded;
      case 'smart watch':
        return Icons.watch_rounded;
      case 'camera':
        return Icons.photo_camera_rounded;
      case 'keyboard':
        return Icons.keyboard_rounded;
      default:
        return Icons.shopping_bag_outlined;
    }
  }
}
