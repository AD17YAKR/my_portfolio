import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/config/config.dart';

final bioExpansionProvider = StateProvider<bool>((ref) => false);
final skillsProvider = Provider<List<String>>((ref) => [
      'Flutter Development',
      'UI/UX Design',
      'Backend Integration',
      'Technical Leadership',
      'State Management (Riverpod)',
      'Clean Architecture',
    ]);

class CrazySection extends ConsumerStatefulWidget {
  const CrazySection({super.key});

  @override
  ConsumerState<CrazySection> createState() => _CrazySectionState();
}

class _CrazySectionState extends ConsumerState<CrazySection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleBio() {
    ref.read(bioExpansionProvider.notifier).state =
        !ref.read(bioExpansionProvider);
  }

  @override
  Widget build(BuildContext context) {
    final isBioExpanded = ref.watch(bioExpansionProvider);
    final skills = ref.watch(skillsProvider);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueGrey[800]!,
                Colors.blueGrey[900]!,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: isBioExpanded ? 160 : 130,
                height: isBioExpanded ? 160 : 130,
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage(Config.crazySection.profileImagePath),
                ),
              ),
              const SizedBox(height: 24),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontSize: isBioExpanded ? 20 : 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.tealAccent,
                ),
                child: GestureDetector(
                  onTap: _toggleBio,
                  child: Text(Config.name),
                ),
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 400),
                crossFadeState: isBioExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Icon(Icons.expand_more, color: Colors.white70),
                ),
                secondChild: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        Config.crazySection.expandedBio,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 16, height: 1.6),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: Config.crazySection.specialSkills.entries
                          .map((entry) {
                        return Chip(
                          label: Text(entry.key),
                          backgroundColor: entry.value.withOpacity(0.2),
                          labelStyle: TextStyle(
                              color: entry.value, fontWeight: FontWeight.w600),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: Config.crazySection.socialButtons.map((button) {
                        return IconButton(
                          icon: Icon(button.icon, color: Colors.white),
                          iconSize: 28,
                          onPressed: () => _launchUrl(button.url),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    // Implement URL launching logic
  }
}

// Additional provider for tab management (example)
enum TabItem { projects, experience, contact }

final selectedTabProvider = StateProvider<TabItem>((ref) => TabItem.projects);
