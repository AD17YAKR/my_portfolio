import 'package:flutter/material.dart';

class NavigationItem {
  final IconData icon;
  final String label;
  final String route; // Add this

  NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

final navigationItems = [
  NavigationItem(
    icon: Icons.home,
    label: 'Home',
    route: '/home',
  ),
  NavigationItem(
    icon: Icons.person,
    label: 'About',
    route: '/about',
  ),
  NavigationItem(
    icon: Icons.work,
    label: 'Experience',
    route: '/experience',
  ),
  NavigationItem(
    icon: Icons.code,
    label: 'Projects',
    route: '/projects',
  ),
  NavigationItem(
    icon: Icons.mail,
    label: 'Contact',
    route: '/contact',
  ),
];
