import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_ecommerce/core/theme/app_theme.dart';
import 'package:mini_ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:mini_ecommerce/features/product/data/models/product_model.dart';
import 'package:mini_ecommerce/features/product/presentation/pages/home_page.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      child: const ProviderScope(child: MiniEcommerceApp()),
    ),
  );
}

class MiniEcommerceApp extends ConsumerWidget {
  const MiniEcommerceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'Mini E‑Commerce',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {
        '/': (_) => const HomePage(),
        CartPage.route: (_) => const CartPage(),
      },
    );
  }
}
