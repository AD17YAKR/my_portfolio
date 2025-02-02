import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:my_portfolio/config/config.dart';
import 'package:my_portfolio/routing/app_router.dart';
import 'package:my_portfolio/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  runApp(
    const ProviderScope(child: PortfolioApp()),
  );
}

class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(themeProvider);

    return MaterialApp.router(
      title: Config.name,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
