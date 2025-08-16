import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mini_ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:mini_ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';
import 'package:mini_ecommerce/features/product/presentation/providers/product_provider.dart';
import 'package:mini_ecommerce/features/product/presentation/widgets/product_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mini_ecommerce/main.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Product> products = [];
  bool isLoading = true;
  bool isError = false;
  bool noInternet = false;

  Future<void> loadProducts() async {
    setState(() {
      isLoading = true;
      isError = false;
      noInternet = false;
    });

    final connectivity = Connectivity();
    final connResult = await connectivity.checkConnectivity();

  

    try {
      final repo = ref.read(productRepoProvider);


      if (connResult != ConnectivityResult.none) {
        // Internet on
        products = await repo.getProducts();
        if (products.isEmpty) noInternet = false; // no products even online
      } else {
        // Internet off
        products = await repo.local.getCachedProducts();
        if (products.isEmpty) noInternet = true;
      }
    } catch (e) {
      final repo = ref.read(productRepoProvider);
      products = await repo.local.getCachedProducts();
      if (products.isEmpty) noInternet = true;
      isError = true;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('title')),
        actions: [
          IconButton(
            tooltip: tr('dark_mode'),
            onPressed: () {
              final current = ref.read(themeModeProvider);
              ref.read(themeModeProvider.notifier).state =
                  current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
            icon: const Icon(Icons.dark_mode),
          ),
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (loc) => context.setLocale(loc),
            itemBuilder: (context) => [
              const PopupMenuItem(value: Locale('en'), child: Text('English')),
              const PopupMenuItem(value: Locale('hi'), child: Text('हिंदी')),
            ],
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadProducts,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : noInternet
                ? const Center(child: Text("No Internet & No Cached Products"))
                : products.isEmpty
                    ? const Center(child: Text("No products available"))
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 700 ? 4 : 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.64,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, i) => ProductCard(
                          product: products[i],
                          onAdd: () =>
                              ref.read(cartProvider.notifier).add(products[i]),
                        ),
                      ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, CartPage.route),
        icon: const Icon(Icons.shopping_cart),
        label: Consumer(builder: (_, ref, __) {
          final count = ref.watch(cartCountProvider);
          return Text('${tr('cart')} ($count)');
        }),
      ),
    );
  }
}
