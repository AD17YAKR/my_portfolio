import 'package:flutter/material.dart';
import 'package:my_portfolio/config/config.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  _ContactSectionState createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              "Get in Touch",
              style: theme.textTheme.displaySmall?.copyWith(
                color: Colors.tealAccent,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.tealAccent.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                color: isDarkMode ? Colors.blueGrey[900] : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildAnimatedFormField(
                          controller: _nameController,
                          label: "Name",
                          icon: Icons.person_outline,
                          validator: (value) =>
                              value!.isEmpty ? "Please enter your name" : null,
                        ),
                        const SizedBox(height: 25),
                        _buildAnimatedFormField(
                          controller: _emailController,
                          label: "Email",
                          icon: Icons.email_outlined,
                          validator: (value) => !value!.contains("@")
                              ? "Invalid email address"
                              : null,
                        ),
                        const SizedBox(height: 25),
                        _buildAnimatedFormField(
                          controller: _messageController,
                          label: "Message",
                          icon: Icons.message_outlined,
                          maxLines: 5,
                          validator: (value) => value!.length < 10
                              ? "Message should be at least 10 characters"
                              : null,
                        ),
                        const SizedBox(height: 40),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.tealAccent
                                    .withOpacity(_isSending ? 0 : 0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            icon: _isSending
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Icon(Icons.send_rounded),
                            label: SelectableText(
                              _isSending ? "Sending..." : "Send Message",
                              style: theme.textTheme.titleMedium,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _isSending ? null : _submitForm,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            SelectableText(
              "Or connect with me via",
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 30,
              runSpacing: 20,
              children: [
                _SocialButton(
                  icon: Icons.code,
                  label: "GitHub",
                  url: Config.links['GitHub']!,
                ),
                _SocialButton(
                  icon: Icons.work,
                  label: "LinkedIn",
                  url: Config.links['LinkedIn']!,
                ),
                _SocialButton(
                  icon: Icons.assignment,
                  label: "LeetCode",
                  url: Config.links['LeetCode']!,
                ),
                _SocialButton(
                  icon: Icons.email,
                  label: "Email",
                  url: "mailto:${Config.contact.split('|').last.trim()}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.tealAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.tealAccent.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.tealAccent, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.tealAccent.withOpacity(0.3)),
          ),
        ),
        style: const TextStyle(color: Colors.white70),
        validator: validator,
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSending = true);
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      setState(() => _isSending = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const SelectableText("Message sent successfully!"),
            backgroundColor: Colors.tealAccent.withOpacity(0.9),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      }
    }
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialButton> createState() => __SocialButtonState();
}

class __SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -5 : 0),
        child: ElevatedButton.icon(
          icon: Icon(widget.icon, color: Colors.tealAccent),
          label: SelectableText(widget.label),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white70,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: Colors.tealAccent.withOpacity(0.3),
                width: 2,
              ),
            ),
            elevation: _isHovered ? 4 : 0,
            shadowColor: Colors.tealAccent.withOpacity(0.2),
          ),
          onPressed: () => _launchUrl(widget.url),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    // Implement using url_launcher package
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // }
  }
}
