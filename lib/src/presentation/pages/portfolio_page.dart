import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../core/responsive.dart';
import '../../data/portfolio_content.dart';
import '../widgets/action_button.dart';
import '../widgets/app_background.dart';
import '../widgets/contact_section.dart';
import '../widgets/floating_nav.dart';
import '../widgets/hero_section.dart';
import '../widgets/project_card.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';
import '../widgets/skill_meter.dart';
import '../widgets/timeline_card.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({
    required this.themeMode,
    required this.onToggleTheme,
    super.key,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'Home': GlobalKey(),
    'About': GlobalKey(),
    'Skills': GlobalKey(),
    'Projects': GlobalKey(),
    'Experience': GlobalKey(),
    'Contact': GlobalKey(),
  };
  double _progress = 0;
  bool _showTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    setState(() {
      _progress = max <= 0 ? 0 : (_scrollController.offset / max).clamp(0, 1);
      _showTop = _scrollController.offset > 720;
    });
  }

  Future<void> _scrollTo(String label) async {
    final context = _sectionKeys[label]?.currentContext;
    if (context == null) return;
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 720),
      curve: Curves.easeInOutCubic,
      alignment: .05,
    );
  }

  Future<void> _scrollTop() async {
    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 720),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = Responsive.contentWidth(context);

    return Scaffold(
      body: AppBackground(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      width: width,
                      child: Column(
                        children: [
                          const SizedBox(height: 96),
                          HeroSection(
                            key: _sectionKeys['Home'],
                            onViewProjects: () => _scrollTo('Projects'),
                            onContact: () => _scrollTo('Contact'),
                          ),
                          _AboutSection(
                            key: _sectionKeys['About'],
                            controller: _scrollController,
                          ),
                          _SkillsSection(
                            key: _sectionKeys['Skills'],
                            controller: _scrollController,
                          ),
                          _ProjectsSection(
                            key: _sectionKeys['Projects'],
                            controller: _scrollController,
                          ),
                          _ExperienceSection(
                            key: _sectionKeys['Experience'],
                            controller: _scrollController,
                          ),
                          ContactSection(
                            key: _sectionKeys['Contact'],
                            controller: _scrollController,
                          ),
                          const SizedBox(height: 56),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 3,
                backgroundColor: Colors.transparent,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Positioned(
              top: 18,
              left: 20,
              right: 20,
              child: FloatingNav(
                labels: _sectionKeys.keys.toList(growable: false),
                onSelect: _scrollTo,
                isDark: widget.themeMode == ThemeMode.dark,
                onToggleTheme: widget.onToggleTheme,
              ),
            ),
            Positioned(
              right: 22,
              bottom: 22,
              child: AnimatedScale(
                scale: _showTop ? 1 : 0,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                child: FloatingActionButton.small(
                  onPressed: _scrollTop,
                  tooltip: 'Back to top',
                  child: const Icon(Icons.keyboard_arrow_up_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({required this.controller, super.key});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return RevealOnScroll(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 76),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'About',
              title: 'Engineering product experiences that feel sharp, fast, and dependable.',
            ),
            const SizedBox(height: 28),
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isMobile ? 0 : 6,
                  child: Text(
                    'I am Your Name, a senior Flutter developer with 9+ years of experience building mobile and web products for real users. My work sits at the intersection of elegant UI, reliable architecture, and practical AI integration, especially for marketplace platforms, intelligent assistants, and scalable consumer apps.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(width: isMobile ? 0 : 34, height: isMobile ? 22 : 0),
                Expanded(
                  flex: isMobile ? 0 : 5,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: const [
                      _HighlightCard(value: '9+', label: 'Years building apps'),
                      _HighlightCard(value: '35+', label: 'Production releases'),
                      _HighlightCard(value: 'AI', label: 'Product workflows'),
                      _HighlightCard(value: 'Clean', label: 'Architecture first'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 30,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({required this.controller, super.key});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 76),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Skills',
              title: 'Flutter depth, AI fluency, and architecture habits built for scale.',
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 18,
              runSpacing: 18,
              children: [
                for (final skill in skills)
                  SkillMeter(skill: skill, controller: controller),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({required this.controller, super.key});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final columns = isMobile ? 1 : (isTablet ? 2 : 2);

    return RevealOnScroll(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 76),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  child: SectionHeader(
                    eyebrow: 'Projects',
                    title: 'Premium app work with AI, marketplaces, and scalable delivery.',
                  ),
                ),
                if (!isMobile)
                  ActionButton(
                    label: 'Download Resume',
                    icon: Icons.download_rounded,
                    onPressed: () {},
                    filled: false,
                  ),
              ],
            ),
            const SizedBox(height: 30),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: isMobile ? .76 : .92,
              ),
              itemBuilder: (context, index) => ProjectCard(project: projects[index]),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({required this.controller, super.key});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 76),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Experience',
              title: 'A steady progression from mobile delivery to AI-powered product systems.',
            ),
            const SizedBox(height: 28),
            Column(
              children: [
                for (var index = 0; index < timeline.length; index++)
                  TimelineCard(
                    entry: timeline[index],
                    isLast: index == timeline.length - 1,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
