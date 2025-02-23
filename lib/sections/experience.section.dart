import 'package:flutter/material.dart';
import 'package:my_portfolio/config/config.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimations = List.generate(
      Config.experiences.length,
      (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index / Config.experiences.length,
              (index + 1) / Config.experiences.length,
              curve: Curves.easeInOut),
        ),
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemCount: Config.experiences.length,
          itemBuilder: (context, index) {
            final experience = Config.experiences[index];
            return Opacity(
              opacity: _fadeAnimations[index].value,
              child: Transform.translate(
                offset: Offset(0, 50 * (1 - _fadeAnimations[index].value)),
                child: _ExperienceCard(experience: experience),
              ),
            );
          },
        );
      },
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience experience;

  const _ExperienceCard({required this.experience});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blueGrey[900]!,
                      Colors.blueGrey[800]!,
                    ],
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            experience.role,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SelectableText(
                            experience.company,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.tealAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SelectableText(
                          experience.duration,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SelectableText(
                          experience.location,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: experience.techStack
                      .map((tech) => Chip(
                            label: Text(tech),
                            backgroundColor: Colors.teal.withValues(alpha: 0.2),
                            labelStyle: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.tealAccent,
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                ...experience.achievements.map((achievement) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, right: 8),
                            child: Icon(
                              Icons.arrow_right_rounded,
                              color: Colors.tealAccent,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: SelectableText(
                              achievement,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
