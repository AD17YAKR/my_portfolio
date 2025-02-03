import 'package:flutter/material.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - _fadeAnimation.value)),
            child: Container(
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
                            color: Colors.tealAccent.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        color: Colors.blueGrey[900],
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
                                  validator: (value) => value!.isEmpty
                                      ? "Please enter your name"
                                      : null,
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
                                ElevatedButton.icon(
                                  icon: _isSending
                                      ? const CircularProgressIndicator(
                                          color: Colors.white)
                                      : const Icon(Icons.send_rounded),
                                  label: Text(_isSending
                                      ? "Sending..."
                                      : "Send Message"),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
            borderSide:
                BorderSide(color: Colors.tealAccent.withValues(alpha: 0.3)),
          ),
        ),
        validator: validator,
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSending = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isSending = false);
    }
  }
}
