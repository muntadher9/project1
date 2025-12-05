import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isSmall = MediaQuery.of(context).size.width < 800;

    final List<Map<String, dynamic>> projects = [
      {
        'id': 'fashion',
        'company': 'متجر أزياء',
        'type': 'E-commerce',
        'description':
            'متجر متكامل بواجهة زجاجية وخط عربي واضح، صفحات منتج سريعة ومعدل تحويل محسّن.',
        'features': [
          'دمج بوابات دفع وشحن',
          'تتبع سلة المشتريات وتحليلات',
          'سرعة تحميل محسّنة',
          'تجربة هوفر وحركة ناعمة',
        ],
        'result': 'زيادة التحويل 18% وتخفيض زمن التحميل إلى 2.3s',
        'color': const Color(0xFF5D7FA0),
        'icon': Icons.store_rounded,
      },
      {
        'id': 'clinic',
        'company': 'منصة عيادات',
        'type': 'منصة حجز',
        'description':
            'لوحة تحكم أطباء وعيادات مع صفحات حجز ونماذج تواصل ودمج خرائط، بواجهة بسيطة وسريعة.',
        'features': [
          'حجز مواعيد فوري',
          'نماذج تواصل واتساب/بريد',
          'تصميم متجاوب للهواتف',
          'تهيئة SEO للمواقع الطبية',
        ],
        'result': '30% نمو في الحجوزات خلال أول شهر',
        'color': const Color(0xFF7FB3C8),
        'icon': Icons.medical_services_rounded,
      },
      {
        'id': 'restaurant',
        'company': 'مطعم وكافيه',
        'type': 'Landing Page',
        'description':
            'صفحة هبوط بخريطة تفاعلية وقائمة طعام مصوّرة، مع نماذج حجز واستبيان رضا العملاء.',
        'features': [
          'صور عالية الجودة وضغط محسّن',
          'نموذج حجز سريع',
          'تأثيرات حركة خفيفة',
          'معاينة فورية للقائمة',
        ],
        'result': 'زيادة الطلبات 15% وتفاعل أعلى مع قائمة الأطباق',
        'color': const Color(0xFFB7D7C5),
        'icon': Icons.restaurant_rounded,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF5D7FA0), Color(0xFF7FB3C8)],
          ).createShader(bounds),
          child: Text(
            'أعمال مختارة',
            style: TextStyle(
              fontSize: isSmall ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'نماذج من مشاريع المتاجر والعيادات وصفحات الهبوط بتصميم زجاجي سريع.',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: projects.map((project) {
            return _PortfolioCard(
              project: project,
              isDark: isDark,
              isSmall: isSmall,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _PortfolioCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isDark;
  final bool isSmall;

  const _PortfolioCard({
    required this.project,
    required this.isDark,
    required this.isSmall,
  });

  @override
  State<_PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<_PortfolioCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final String company = widget.project['company'] as String;
    final String type = widget.project['type'] as String;
    final String description = widget.project['description'] as String;
    final List<String> features =
        List<String>.from(widget.project['features'] as List);
    final Color color = widget.project['color'] as Color;
    final IconData icon = widget.project['icon'] as IconData;
    final String? result = widget.project['result'] as String?;
    final String badge = 'دراسة حالة';

    final double cardWidth = widget.isSmall ? double.infinity : 350;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _isHovered
            ? (vm.Matrix4.identity()
              ..translateByVector3(vm.Vector3(0.0, -10.0, 0.0)))
            : vm.Matrix4.identity(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: cardWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: _isHovered
                      ? color.withValues(alpha: 0.6)
                      : Colors.white.withValues(alpha: 0.2),
                  width: 2,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isDark
                      ? [
                          Colors.white.withValues(alpha: 0.05),
                          Colors.white.withValues(alpha: 0.02),
                        ]
                      : [
                          Colors.white.withValues(alpha: 0.8),
                          Colors.white.withValues(alpha: 0.6),
                        ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? color.withValues(alpha: 0.4)
                        : Colors.black.withValues(alpha: 0.1),
                    blurRadius: _isHovered ? 40 : 20,
                    offset: Offset(0, _isHovered ? 20 : 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        if (result != null) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.trending_up, size: 16),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    result,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textDirection: TextDirection.rtl,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color, color.withValues(alpha: 0.6)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: color.withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(icon, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                type,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      company,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: widget.isDark
                            ? Colors.white.withValues(alpha: 0.8)
                            : const Color(0xFF4B5563),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, color.withValues(alpha: 0.3)],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'أبرز المزايا:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...features.map((feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [color, color.withValues(alpha: 0.6)],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: widget.isDark
                                        ? Colors.white.withValues(alpha: 0.7)
                                        : const Color(0xFF6B7280),
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                        )),
                    if (result != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        'النتيجة:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        result,
                        style: const TextStyle(fontSize: 13, height: 1.4),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: widget.project['url'] == null
                            ? null
                            : () => _launchPreview(
                                  widget.project['url'] as String,
                                ),
                        icon: const Icon(Icons.visibility),
                        label: const Text('مشاهدة المعاينة'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchPreview(String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح رابط المعاينة حالياً')),
      );
    }
  }
}
