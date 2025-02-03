// routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/sections/crazy.section.dart';
import 'package:my_portfolio/sections/experience.section.dart';
import 'package:my_portfolio/sections/home.section.dart';
import 'package:my_portfolio/sections/project.section.dart';
import 'package:my_portfolio/widgets/desktop_navigation_rail.dart';
import 'package:my_portfolio/sections/about.section.dart';
import 'package:my_portfolio/sections/contact.section.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) => PortfolioShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) => const MaterialPage(
              child: HomeSection(),
            ),
          ),
          GoRoute(
            path: '/home',
            name: 'landing',
            pageBuilder: (context, state) => const MaterialPage(
              child: HomeSection(),
            ),
          ),
          GoRoute(
            path: '/about',
            name: 'about',
            pageBuilder: (context, state) => const MaterialPage(
              child: AboutSection(),
            ),
          ),
          GoRoute(
            path: '/projects',
            name: 'projects',
            pageBuilder: (context, state) => const MaterialPage(
              child: ProjectsSection(),
            ),
          ),
          GoRoute(
            path: '/contact',
            name: 'contact',
            pageBuilder: (context, state) => const MaterialPage(
              child: ContactSection(),
            ),
          ), // Add this route if keeping the 'Crazy' navigation item
          GoRoute(
            path: '/crazy',
            name: 'crazy',
            pageBuilder: (context, state) => const MaterialPage(
              child: CrazySection(),
            ),
          ),
          GoRoute(
            path: '/experience',
            name: 'experience',
            pageBuilder: (context, state) => const MaterialPage(
              child: ExperienceSection(),
            ),
          ),
        ],
      ),
    ],
  );
});

class PortfolioShell extends ConsumerWidget {
  final Widget child;

  const PortfolioShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Scaffold(
      body: Row(
        children: [
          if (!isMobile) const DesktopNavigationRail(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
