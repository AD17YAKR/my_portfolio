import 'package:flutter/material.dart';
import 'package:my_portfolio/config/config.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _nameAnimation;
  late Animation<double> _underlineAnimation;
  late Animation<double> _contactAnimation;
  late Animation<double> _socialAnimation;
  late Animation<double> _summaryAnimation;
  late Animation<double> _scrollIndicatorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _nameAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeInOut),
      ),
    );

    _underlineAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.3, curve: Curves.easeInOut),
      ),
    );

    _contactAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.5, curve: Curves.easeInOut),
      ),
    );

    _socialAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.7, curve: Curves.easeInOut),
      ),
    );

    _summaryAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 0.9, curve: Curves.easeInOut),
      ),
    );

    _scrollIndicatorAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.9, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueGrey[900]!,
            Colors.blueGrey[800]!,
          ],
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name with fade and slide animation
                Transform.translate(
                  offset: Offset(0, 50 * (1 - _nameAnimation.value)),
                  child: Opacity(
                    opacity: _nameAnimation.value,
                    child: SelectableText(
                      Config.name,
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: Colors.tealAccent,
                        fontSize: isMobile ? 42 : 72,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                AnimatedBuilder(
                  animation: _underlineAnimation,
                  builder: (context, child) {
                    return Container(
                      width: isMobile
                          ? 120 * _underlineAnimation.value
                          : 160 * _underlineAnimation.value,
                      height: 4,
                      color: Colors.tealAccent,
                      margin: const EdgeInsets.only(bottom: 20),
                    );
                  },
                ),
                Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: [
                    _buildAnimatedContactItem(
                      Icons.phone,
                      Config.contact,
                      _contactAnimation.value,
                    ),
                    _buildAnimatedContactItem(
                      Icons.email,
                      Config.links['email'] ?? '',
                      _contactAnimation.value,
                      delay: 0.1,
                    ),
                    _buildAnimatedContactItem(
                      Icons.location_on,
                      Config.location,
                      _contactAnimation.value,
                      delay: 0.2,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Opacity(
                  opacity: _socialAnimation.value,
                  child: Transform.scale(
                    scale: 0.5 + _socialAnimation.value * 0.5,
                    child: Wrap(
                      spacing: 25,
                      children: [
                        _SocialLink(
                          icon: Icons.code,
                          label: 'GitHub',
                          url: Config.links['GitHub']!,
                        ),
                        _SocialLink(
                          icon: Icons.work,
                          label: 'LinkedIn',
                          url: Config.links['LinkedIn']!,
                        ),
                        _SocialLink(
                          icon: Icons.assessment,
                          label: 'LeetCode',
                          url: Config.links['LeetCode']!,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Summary text with fade and slide animation
                Transform.translate(
                  offset: Offset(0, 30 * (1 - _summaryAnimation.value)),
                  child: Opacity(
                    opacity: _summaryAnimation.value,
                    child: AnimatedPadding(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SelectableText(
                        Config.summary,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                          fontSize: isMobile ? 16 : 18,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Scroll indicator with pulsating animation
                Opacity(
                  opacity: _scrollIndicatorAnimation.value,
                  child: Transform.translate(
                    offset: Offset(
                      0,
                      10 * (1 - _scrollIndicatorAnimation.value),
                    ),
                    child: const Center(
                      child: Column(
                        children: [
                          Icon(Icons.expand_more,
                              color: Colors.white54, size: 35),
                          Text(
                            'Explore my journey',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimatedContactItem(
      IconData icon, String text, double animationValue,
      {double delay = 0}) {
    final effectiveValue = (animationValue - delay).clamp(0, 1) / (1 - delay);

    return Opacity(
      opacity: effectiveValue,
      child: Transform.translate(
        offset: Offset(50 * (1 - effectiveValue), 0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.tealAccent, size: 20),
              const SizedBox(width: 8),
              SelectableText(
                text,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.tealAccent.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.tealAccent),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
