import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/firebase_providers.dart';
import '../domain/models/app_user.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/inventory/presentation/inventory_page.dart';
import '../features/products/presentation/products_page.dart';
import '../features/reports/presentation/reports_page.dart';
import '../features/templates/presentation/templates_page.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateChangesProvider);
    final AppUser? user = authState.value;

    final navItems = [
      _NavItem('Dashboard', Icons.dashboard_outlined, const DashboardPage()),
      _NavItem('Products', Icons.inventory_2_outlined, const ProductsPage()),
      _NavItem('Stock', Icons.warehouse_outlined, const InventoryPage()),
      _NavItem('Reports', Icons.bar_chart_outlined, const ReportsPage()),
      _NavItem('Templates', Icons.auto_awesome, const TemplatesPage()),
    ];

    final showRail = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory System'),
        actions: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(user.email, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(width: 12),
                  FilledButton.tonal(
                    onPressed: () => ref.read(authRepositoryProvider).signOut(),
                    child: const Text('Sign out'),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: Row(
        children: [
          if (showRail)
            NavigationRail(
              selectedIndex: _index,
              onDestinationSelected: (i) => setState(() => _index = i),
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (final item in navItems)
                  NavigationRailDestination(
                    icon: Icon(item.icon),
                    label: Text(item.label),
                  ),
              ],
            ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: navItems[_index].page,
            ),
          ),
        ],
      ),
      bottomNavigationBar: showRail
          ? null
          : NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: (i) => setState(() => _index = i),
              destinations: [
                for (final item in navItems)
                  NavigationDestination(
                    icon: Icon(item.icon),
                    label: item.label,
                  ),
              ],
            ),
    );
  }
}

class _NavItem {
  _NavItem(this.label, this.icon, this.page);
  final String label;
  final IconData icon;
  final Widget page;
}
