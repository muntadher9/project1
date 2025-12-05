import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyLandingPage extends StatefulWidget {
  const CompanyLandingPage({super.key});

  @override
  State<CompanyLandingPage> createState() => _CompanyLandingPageState();
}

class _CompanyLandingPageState extends State<CompanyLandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  static const Color _primary = Color(0xFF0F62FE);
  static const Color _accent = Color(0xFF14B8A6);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<void> _launchWhatsApp() async {
    final uri = Uri.parse(
        'https://wa.me/9647729081541?text=%D8%A3%D8%B1%D9%8A%D8%AF%20%D8%AA%D9%88%D8%A7%D8%B5%D9%84%D8%A7%D9%8B%20%D8%AD%D9%88%D9%84%20%D8%AE%D8%AF%D9%85%D8%A7%D8%AA%20%D8%A7%D9%84%D8%A8%D8%B1%D9%85%D8%AC%D8%A9%20%D9%88%D8%A7%D9%84%D8%A3%D9%85%D9%86%20%D8%A7%D9%84%D8%B3%D9%8A%D8%A8%D8%B1%D8%A7%D9%86%D9%8A');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchMail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'hello@shieldtech.dev',
      queryParameters: const {
        'subject': 'طلب تعاون',
        'body': 'مرحبا، أود معرفة المزيد عن خدماتكم.',
      },
    );
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 900;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FB),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0C172C), Color(0xFF111E35)],
              ),
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTopBar(isWide),
                  _buildHero(isWide),
                  const SizedBox(height: 24),
                  _buildStatsRow(isWide),
                  const SizedBox(height: 32),
                  _buildSectionContainer(
                    key: _servicesKey,
                    title: 'خدماتنا الأساسية',
                    subtitle:
                        'حلول متكاملة: برمجيات مخصصة، مواقع ذات تجربة مستخدم محسّنة، وحماية سيبرانية استباقية.',
                    child: _buildServicesGrid(isWide),
                  ),
                  _buildSectionContainer(
                    title: 'الأمن السيبراني كميزة تنافسية',
                    subtitle:
                        'من اختبارات الاختراق إلى بناء سياسات وإجراءات أمنية؛ نهتم بالحماية منذ التصميم.',
                    child: _buildSecurityHighlight(isWide),
                  ),
                  _buildSectionContainer(
                    title: 'كيف نعمل؟',
                    subtitle:
                        'عملية واضحة تقلل المخاطر وتسرّع الوصول للإطلاق الأولي والنمو.',
                    child: _buildProcessSteps(isWide),
                  ),
                  _buildContactSection(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(bool isWide) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 40 : 20, vertical: 20),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _accent.withValues(alpha: 0.7)),
                ),
                child: const Icon(Icons.shield_moon, color: _accent),
              ),
              const SizedBox(width: 10),
              const Text(
                'ShieldTech',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (isWide)
            Row(
              children: [
                TextButton(
                  onPressed: () => _scrollTo(_servicesKey),
                  style: TextButton.styleFrom(foregroundColor: Colors.white70),
                  child: const Text('الخدمات'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => _scrollTo(_contactKey),
                  style: TextButton.styleFrom(foregroundColor: Colors.white70),
                  child: const Text('تواصل معنا'),
                ),
                const SizedBox(width: 16),
              ],
            ),
          FilledButton.icon(
            onPressed: _launchWhatsApp,
            icon: const Icon(Icons.bolt_rounded),
            label: const Text('استشارة سريعة'),
            style: FilledButton.styleFrom(
              backgroundColor: _accent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(bool isWide) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 48 : 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(isWide ? 32 : 20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: const Text(
                    'شركة تطوير برمجيات، مواقع، وأمن سيبراني',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'نبني منتجات رقمية آمنة، عصرية، وقابلة للتوسع.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isWide ? 42 : 30,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'فريق يجمع بين هندسة البرمجيات، تصميم تجربة المستخدم، واختبارات الاختراق. نعمل كفريق منتج متكامل يرافقك من الفكرة، إلى الإطلاق، ثم التحسين المستمر.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: isWide ? 18 : 16,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: _launchWhatsApp,
                      icon: const Icon(Icons.chat_rounded),
                      label: const Text('ابدأ محادثة واتساب'),
                      style: FilledButton.styleFrom(
                        backgroundColor: _accent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _scrollTo(_servicesKey),
                      icon: const Icon(Icons.layers_rounded, color: Colors.white),
                      label: const Text(
                        'استعرض الخدمات',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => Navigator.of(context).pushNamed('/app'),
                      icon: const Icon(Icons.dashboard_customize,
                          color: Colors.white70),
                      label: const Text(
                        'دخول لوحة التحكم',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(bool isWide) {
    final items = const [
      _StatItem(
        title: '4 - 6 أسابيع',
        caption: 'للإطلاق الأولي MVP بسرعة دون التضحية بالجودة',
      ),
      _StatItem(
        title: 'أمن مدمج',
        caption: 'اختبارات اختراق، مراجعة كود، وسياسات حوكمة أمنية',
      ),
      _StatItem(
        title: 'منتج + خدمات',
        caption: 'نموذج عمل مرن: مشروع، باقات دعم، أو فريق مدمج معك',
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 48 : 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 1000 ? 3 : 1;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: constraints.maxWidth > 1000 ? 3.2 : 2.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) => _StatCard(item: items[i]),
          );
        },
      ),
    );
  }

  Widget _buildSectionContainer({
    Key? key,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF4B5563),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  Widget _buildServicesGrid(bool isWide) {
    final services = const [
      _Service(
        icon: Icons.devices_other_outlined,
        title: 'برمجيات مخصصة',
        description:
            'تطبيقات ويب وموبايل بهندسة قابلة للتوسع، تكاملات API، ولوحات تحكم تفاعلية.',
        chips: ['Flutter/React', 'Node/Go', 'CI/CD', 'مراقبة'],
      ),
      _Service(
        icon: Icons.language_rounded,
        title: 'مواقع وهوية رقمية',
        description:
            'مواقع تعريفية وتجارية بتجربة مستخدم مدروسة، سرعة عالية، وتحسين محركات البحث.',
        chips: ['UI/UX', 'SEO', 'Hosting مُدار', 'تحليلات'],
      ),
      _Service(
        icon: Icons.shield_rounded,
        title: 'أمن سيبراني',
        description:
            'اختبارات اختراق، إعداد سياسات وإجراءات أمنية، واستجابة للحوادث.',
        chips: ['Pentest', 'Policies', 'Monitoring', 'IR Playbooks'],
      ),
      _Service(
        icon: Icons.handshake_rounded,
        title: 'استشارات وتدريب',
        description:
            'بناء خارطة طريق تقنية، اختيار التقنيات، وتدريب الفرق على أفضل الممارسات.',
        chips: ['Architecture', 'Code Review', 'Workshops'],
      ),
    ];

    final crossAxisCount = isWide ? 2 : 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isWide ? 2.6 : 1.8,
      ),
      itemBuilder: (_, index) => _ServiceCard(service: services[index]),
    );
  }

  Widget _buildSecurityHighlight(bool isWide) {
    final tiles = const [
      _Highlight(
        title: 'اختبارات الاختراق',
        body: 'هجمات تحاكي الواقع على الويب والموبايل والبنية التحتية.',
      ),
      _Highlight(
        title: 'أمن من التصميم',
        body:
            'مراجعة متطلبات الأمان في الهندسة، الهوية والصلاحيات، والبيانات.',
      ),
      _Highlight(
        title: 'أتمتة الفحوصات',
        body: 'SAST/DAST في خط النشر، تنبيهات مبكرة، ومراقبة مستمرة.',
      ),
      _Highlight(
        title: 'حوكمة وامتثال',
        body:
            'سياسات، إجراءات، وتهيئة ليتماشى العمل مع أطر مثل ISO 27001 وNIST.',
      ),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        for (final tile in tiles)
          SizedBox(
            width: isWide ? 280 : double.infinity,
            child: _GlassTile(title: tile.title, body: tile.body),
          ),
      ],
    );
  }

  Widget _buildProcessSteps(bool isWide) {
    final steps = const [
      _Highlight(
        title: 'استكشاف سريع',
        body: 'جلسة لفهم الأهداف، أصحاب المصلحة، والتحديات التقنية.',
      ),
      _Highlight(
        title: 'تصميم وتحليل',
        body: 'نماذج أولية وتجربة مستخدم، توثيق المتطلبات وقصص المستخدم.',
      ),
      _Highlight(
        title: 'تطوير متكرر',
        body: 'إطلاقات جزئية كل 2-3 أسابيع مع مراجعات أمنية واختبارات.',
      ),
      _Highlight(
        title: 'تسليم وتشغيل',
        body: 'أتمتة نشر، مراقبة، وتدريب الفريق أو إدارة التشغيل بالكامل.',
      ),
    ];

    return Column(
      children: [
        for (int i = 0; i < steps.length; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FBFF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE5EDFA)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: _primary.withValues(alpha: 0.12),
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: _primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        steps[i].title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        steps[i].body,
                        style: const TextStyle(
                          color: Color(0xFF4B5563),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Container(
      key: _contactKey,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F62FE), Color(0xFF14B8A6)],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'فلنبدأ في بناء شيء مميز',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'أرسل لنا فكرة المشروع أو التحدي الأمني الذي تواجهه، وسنعود بخطة عمل واضحة وتكلفة تقديرية.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: _launchWhatsApp,
                icon: const Icon(Icons.chat_bubble_rounded, color: Colors.black),
                label: const Text('تواصل واتساب'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _launchMail,
                icon: const Icon(Icons.mail_outline, color: Colors.white),
                label: const Text(
                  'hello@shieldtech.dev',
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Service {
  const _Service({
    required this.icon,
    required this.title,
    required this.description,
    required this.chips,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<String> chips;
}

class _Highlight {
  const _Highlight({required this.title, required this.body});
  final String title;
  final String body;
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service});

  final _Service service;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EDFA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _CompanyLandingPageState._primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(service.icon,
                    color: _CompanyLandingPageState._primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  service.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            service.description,
            style: const TextStyle(
              color: Color(0xFF4B5563),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final chip in service.chips)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5EDFA)),
                  ),
                  child: Text(
                    chip,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem {
  const _StatItem({required this.title, required this.caption});
  final String title;
  final String caption;
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.item});

  final _StatItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.caption,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassTile extends StatelessWidget {
  const _GlassTile({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
