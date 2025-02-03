import 'package:flutter/material.dart';
import 'package:my_portfolio/config/config.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
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
      Config.projects.length,
      (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index / Config.projects.length,
              (index + 1) / Config.projects.length,
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
                child: SelectableText(
                  "Featured Projects",
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: Colors.tealAccent,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 1 : 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                        childAspectRatio: isMobile ? 0.9 : 1.2,
                      ),
                      itemCount: Config.projects.length,
                      itemBuilder: (context, index) {
                        final project = Config.projects[index];
                        return Opacity(
                          opacity: _fadeAnimations[index].value,
                          child: Transform.translate(
                            offset: Offset(
                                0, 50 * (1 - _fadeAnimations[index].value)),
                            child: _ProjectCard(project: project),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => __ProjectCardState();
}

class __ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -10 : 0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.tealAccent.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          color: isDarkMode ? Colors.blueGrey[900] : Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _showProjectDetails(context),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Image
                  // Expanded(
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(15),
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //           image: AssetImage(widget.project.imagePath),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),

                  // Project Title
                  SelectableText(
                    widget.project.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.tealAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Tech Stack Chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.project.techStack
                        .map((tech) => Chip(
                              label: Text(tech),
                              backgroundColor:
                                  Colors.teal.withValues(alpha: 0.2),
                              labelStyle: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.tealAccent,
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 15),

                  // Project Description
                  SelectableText(
                    widget.project.description,
                    maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // View Project Button
                  if (widget.project.link != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.launch_rounded,
                            color: Colors.tealAccent),
                        onPressed: () => _launchUrl(widget.project.link!),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showProjectDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.blueGrey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    widget.project.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.tealAccent,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Project Image
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(15),
              //   child: Image.asset(widget.project.imagePath),
              // ),
              const SizedBox(height: 25),

              // Achievements
              ...widget.project.achievements.map((achievement) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6, right: 12),
                          child: Icon(
                            Icons.star_rounded,
                            color: Colors.tealAccent,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: SelectableText(
                            achievement,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 25),

              // Tech Stack
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.project.techStack
                    .map((tech) => Chip(
                          label: Text(tech),
                          backgroundColor: Colors.teal.withValues(alpha: 0.2),
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.tealAccent),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 25),

              // Project Link
              if (widget.project.link != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.launch_rounded),
                    label: const Text("View Project"),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () => _launchUrl(widget.project.link!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) {
    // Implement URL launching logic
    // Example using url_launcher:
    // launchUrl(Uri.parse(url));
  }
}
