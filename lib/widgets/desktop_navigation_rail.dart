// widgets/desktop_navigation_rail.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/config/navigation_items.dart';
import 'package:my_portfolio/providers/current_index_provider.dart';

class DesktopNavigationRail extends ConsumerWidget {
  const DesktopNavigationRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return NavigationRail(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        ref.read(currentIndexProvider.notifier).state = index;
        final selectedItem = navigationItems[index];
        // Use GoRouter to navigate
        final router = GoRouter.of(context);
        router.go(selectedItem.route);
      },
      labelType: NavigationRailLabelType.selected,
      destinations: navigationItems
          .map(
            (item) => NavigationRailDestination(
              icon: Icon(item.icon),
              label: Text(item.label),
            ),
          )
          .toList(),
    );
  }
}
