/*
MINI PRODUCT CATALOG
Active navigation: go_router (Navigator version examples are commented out below).

PART 1 — LIFECYCLE ANSWERS
a) On a page's first opening: initState(), didChangeDependencies(), then build()
   (build() can run more than once).
b) Pressing a heart calls setState(), so build() runs again. initState() and
   dispose() do not run just because the counter changed.
c) When leaving a page, deactivate() runs. If the page is permanently removed,
   dispose() runs too. When returning, a new page instance may run
   initState(), didChangeDependencies(), and build() again. A page retained by
   the router may instead be reused.
d) Resizing the browser changes MediaQuery's size. ProductsPage depends on
   MediaQuery.sizeOf(context), so didChangeDependencies() runs again and build()
   updates the displayed width and switches between ListView (< 600 px) and
   GridView (>= 600 px).

PART 4 — SHORT ANSWERS
1) context.go replaces the current navigation location/stack with the destination.
   Example: Login -> Products uses context.goNamed('products', ...).
   context.push adds a page on top of the current stack and returns a Future.
   Example: Products -> Details uses context.push<String>(...).
2) Login -> Products uses go because Login should not remain as a page to return
   to with the back button. Products -> Details uses push so Details appears
   above Products and can return an "added to cart" result.
3) A path parameter is part of the route path, e.g. /details/Laptop/1200
   (name= Laptop, price=1200). A query parameter follows '?' in the URL,
   e.g. /products?user=Guest (user=Guest).

PART 2 — pushNamed arguments research:
Navigator.pushNamed(context, '/products', arguments: {'username': 'Guest'});
The route reads the value using
ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>.
Flutter docs: https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'product_widgets.dart';

void main() {
  runApp(const MiniProductCatalogApp());
}

final List<Map<String, dynamic>> demoProducts = [
  {'name': 'Laptop', 'price': 1200, 'description': 'A reliable laptop for study and work.'},
  {'name': 'Headphones', 'price': 85, 'description': 'Comfortable headphones with clear sound.'},
  {'name': 'Smartphone', 'price': 750, 'description': 'A modern phone for everyday use.'},
  {'name': 'Smart Watch', 'price': 160, 'description': 'Track your activity and stay connected.'},
  {'name': 'Camera', 'price': 540, 'description': 'Capture your favorite moments.'},
  {'name': 'Keyboard', 'price': 65, 'description': 'A compact keyboard for your setup.'},
];

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) {
        final username = state.uri.queryParameters['user'] ?? 'Guest';
        return ProductsPage(username: username);
      },
    ),
    GoRoute(
      path: '/details/:name/:price',
      name: 'details',
      builder: (context, state) {
        final name = state.pathParameters['name'] ?? 'Product';
        final price = double.tryParse(state.pathParameters['price'] ?? '') ?? 0;
        return DetailsPage(name: name, price: price);
      },
    ),
  ],
);

class MiniProductCatalogApp extends StatelessWidget {
  const MiniProductCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mini Product Catalog',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3867D6)),
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
        cardTheme: const CardThemeData(
          elevation: 1,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('LoginPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('LoginPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('LoginPage: build');
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Icon(
                        Icons.storefront_rounded,
                        size: 42,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Mini Product Catalog',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Discover useful products in one place.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          // Navigator version (Part 2), kept for reference:
                          // Navigator.pushNamed(
                          //   context,
                          //   '/products',
                          //   arguments: {'username': 'Guest'},
                          // );

                          // go_router version (active):
                          context.goNamed(
                            'products',
                            queryParameters: {'user': 'Guest'},
                          );
                        },
                        icon: const Icon(Icons.login_rounded),
                        label: const Text('Login as Guest'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    debugPrint('LoginPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint('LoginPage: dispose');
    super.dispose();
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.username});

  final String username;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int _favorites = 0;
  double _screenWidth = 0;
  String? _cartMessage;

  @override
  void initState() {
    super.initState();
    debugPrint('ProductsPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.sizeOf(context);
    _screenWidth = size.width;
    debugPrint(
      'ProductsPage: didChangeDependencies -> width: ${size.width}, height: ${size.height}',
    );
  }

  Future<void> _openProduct(int index) async {
    final product = demoProducts[index];
    final result = await context.push<String>(
      appRouter.namedLocation(
        'details',
        pathParameters: {
          'name': product['name'].toString(),
          'price': product['price'].toString(),
        },
      ),
    );

    if (!mounted) return;
    if (result != null) {
      setState(() {
        _cartMessage = result;
      });
    }

    // Navigator version (Part 2), kept for reference:
    // final result = await Navigator.push<String>(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => DetailsPage(
    //       name: product['name'].toString(),
    //       price: (product['price'] as num).toDouble(),
    //     ),
    //   ),
    // );
    // if (!mounted) return;
    // if (result != null) setState(() => _cartMessage = result);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('ProductsPage: build');
    final isWide = _screenWidth >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    'Favorites: $_favorites',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${widget.username}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Screen width: ${_screenWidth.toStringAsFixed(1)} px',
                  key: const ValueKey('screen-width'),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.blueGrey,
                      ),
                ),
                if (_cartMessage != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _cartMessage!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                Expanded(
                  child: isWide
                      ? ProductsGridView(
                          products: demoProducts,
                          onFavoritePressed: (index) {
                            setState(() => _favorites++);
                          },
                          onProductTap: _openProduct,
                        )
                      : ProductsListView(
                          products: demoProducts,
                          onFavoritePressed: (index) {
                            setState(() => _favorites++);
                          },
                          onProductTap: _openProduct,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    debugPrint('ProductsPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint('ProductsPage: dispose');
    super.dispose();
  }
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.name,
    required this.price,
  });

  final String name;
  final double price;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('DetailsPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('DetailsPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('DetailsPage: build');
    final product = demoProducts.firstWhere(
      (item) => item['name'] == widget.name,
      orElse: () => {'name': widget.name, 'price': widget.price, 'description': 'Product details.'},
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.inventory_2_outlined,
                        size: 76,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${widget.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(product['description']?.toString() ?? 'Product details.'),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          // Navigator version (Part 2), kept for reference:
                          // Navigator.pop(context, '${widget.name} added to cart');

                          // go_router version (active):
                          context.pop('${widget.name} added to cart');
                        },
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: const Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    debugPrint('DetailsPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint('DetailsPage: dispose');
    super.dispose();
  }
}

/*
PART 2 — Navigator-only setup (kept commented out as requested)
To run Part 2 separately, replace MaterialApp.router with MaterialApp and
use these routes. The active app above intentionally uses go_router.

MaterialApp(
  routes: {
    '/': (_) => const LoginPage(),
    '/products': (context) {
      final args = ModalRoute.of(context)!.settings.arguments
          as Map<String, dynamic>?;
      return ProductsPage(username: args?['username'] as String? ?? 'Guest');
    },
  },
);

For Login -> Products:
Navigator.pushNamed(
  context,
  '/products',
  arguments: {'username': 'Guest'},
);

For Products -> Details:
final result = await Navigator.push<String>(
  context,
  MaterialPageRoute(
    builder: (_) => DetailsPage(name: productName, price: productPrice),
  ),
);
if (!mounted) return;
if (result != null) setState(() => _cartMessage = result);

For Details -> Products:
Navigator.pop(context, '${widget.name} added to cart');
*/
