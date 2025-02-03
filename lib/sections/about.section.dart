import 'package:flutter/material.dart';
import 'package:my_portfolio/config/config.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _titleAnimation;
  late Animation<double> _profileAnimation;
  late Animation<double> _contentAnimation;
  late Animation<double> _educationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _titleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeInOut),
      ),
    );

    _profileAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.4, curve: Curves.easeInOut),
      ),
    );

    _contentAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    _educationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeInOut),
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
      padding: const EdgeInsets.symmetric(vertical: 60),
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 20 : 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Animation
                Transform.translate(
                  offset: Offset(0, 50 * (1 - _titleAnimation.value)),
                  child: Opacity(
                    opacity: _titleAnimation.value,
                    child: SelectableText(
                      "About Me",
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: Colors.tealAccent,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image Animation
                    Opacity(
                      opacity: _profileAnimation.value,
                      child: Transform.scale(
                        scale: 0.8 + 0.2 * _profileAnimation.value,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.only(right: isMobile ? 0 : 40),
                            child: CircleAvatar(
                              radius: isMobile ? 80 : 120,
                              backgroundColor:
                                  Colors.tealAccent.withValues(alpha: 0.1),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/profile.jpeg',
                                  width: isMobile ? 150 : 220,
                                  height: isMobile ? 150 : 220,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40, height: 40),

                    // Content Animation
                    Expanded(
                      child: Opacity(
                        opacity: _contentAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - _contentAnimation.value)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                Config.aboutMe,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white70,
                                  height: 1.6,
                                  fontSize: isMobile ? 16 : 18,
                                ),
                              ),
                              const SizedBox(height: 40),
                              ...Config.skills.entries.map((entry) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SelectableText(
                                        entry.key,
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                          color: Colors.tealAccent,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 12,
                                        children: entry.value.map((skill) {
                                          return AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.tealAccent
                                                  .withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Colors.tealAccent
                                                    .withValues(alpha: 0.3),
                                              ),
                                            ),
                                            child: SelectableText(
                                              skill,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: Colors.tealAccent,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Education Card Animation
                Opacity(
                  opacity: _educationAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - _educationAnimation.value)),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.tealAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.tealAccent.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.school_rounded,
                              color: Colors.tealAccent, size: 40),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  Config.education.degree,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: Colors.tealAccent,
                                  ),
                                ),
                                SelectableText(
                                  "${Config.education.institution} (GPA: ${Config.education.gpa})",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                                SelectableText(
                                  Config.education.duration,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
