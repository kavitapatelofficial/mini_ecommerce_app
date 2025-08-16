import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_ecommerce/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableWidget(Widget child) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      child: ProviderScope(child: child),
    );
  }

  testWidgets('MiniEcommerceApp loads HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const MiniEcommerceApp()));
    await tester.pumpAndSettle();

    // Verify that the HomePage title is rendered (from translations)
    expect(find.text('Mini E-Commerce'), findsOneWidget);

    // Verify that floating cart button exists
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
  });

  testWidgets('App supports dark and light theme toggle', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const MiniEcommerceApp()));
    await tester.pumpAndSettle();

    // Initially ThemeMode.system
    final BuildContext context = tester.element(find.byType(MaterialApp));
    final MaterialApp app = context.widget as MaterialApp;
    expect(app.themeMode, ThemeMode.system);

    // Change theme mode through provider
    final container = ProviderScope.containerOf(context);
    container.read(themeModeProvider.notifier).state = ThemeMode.dark;
    await tester.pumpAndSettle();

    final MaterialApp updatedApp = tester.widget(find.byType(MaterialApp));
    expect(updatedApp.themeMode, ThemeMode.dark);
  });
}
