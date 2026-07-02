import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/responsive.dart';
import 'action_button.dart';
import 'reveal_on_scroll.dart';
import 'section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    required this.controller,
    super.key,
  });

  final ScrollController controller;

  Future<void> _copy(BuildContext context, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $value'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return RevealOnScroll(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 76),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 22 : 34),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).dividerColor),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: .10),
                blurRadius: 42,
                offset: const Offset(0, 24),
              ),
            ],
          ),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 5,
                child: SectionHeader(
                  eyebrow: 'Contact',
                  title: 'Let us build a polished Flutter product that is ready for real users.',
                ),
              ),
              SizedBox(width: isMobile ? 0 : 34, height: isMobile ? 28 : 0),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ContactRow(
                      icon: Icons.mail_rounded,
                      label: 'Email',
                      value: 'your.name@example.com',
                      onTap: () => _copy(context, 'your.name@example.com'),
                    ),
                    _ContactRow(
                      icon: Icons.business_rounded,
                      label: 'LinkedIn',
                      value: 'linkedin.com/in/your-name-flutter',
                      onTap: () => _copy(context, 'https://linkedin.com/in/your-name-flutter'),
                    ),
                    _ContactRow(
                      icon: Icons.code_rounded,
                      label: 'GitHub',
                      value: 'github.com/your-name',
                      onTap: () => _copy(context, 'https://github.com/your-name'),
                    ),
                    const SizedBox(height: 20),
                    ActionButton(
                      label: 'Contact Your Name',
                      icon: Icons.send_rounded,
                      onPressed: () => _copy(context, 'your.name@example.com'),
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
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: Theme.of(context).textTheme.labelLarge),
                    Text(value, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              const Icon(Icons.copy_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
