import 'package:flutter/material.dart';

import '../widgets/hover_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'مواقع مخصصة سريعة',
        'desc':
            'واجهات زجاجية متجاوبة، سرعة تحميل محسّنة، وتهيئة SEO أساسية مع نشر أولي.',
        'details': [
          'مدة التنفيذ: 1-2 أسبوع حسب عدد الصفحات',
          'يشمل دمج تحليلات أساسية وتتبع تحويلات بسيط',
        ],
        'icon': Icons.web_rounded,
        'color': const Color(0xFF5D7FA0),
      },
      {
        'title': 'متاجر إلكترونية',
        'desc':
            'صفحات منتج بسلاسة شراء، تكامل دفع/تواصل، وتحليلات أساسية لتتبع التحويل.',
        'details': [
          'تكامل دفع (حسب مزودك المفضل) + إشعارات بريد/واتساب',
          'تهيئة صور وضغطها لتحسين السرعة',
        ],
        'icon': Icons.shopping_bag_rounded,
        'color': const Color(0xFF7FB3C8),
      },
      {
        'title': 'Landing Pages',
        'desc':
            'صفحات هبوط مركزة على التحويل، CTA واضح، وحركة خفيفة تعزز تفاعل المستخدم.',
        'details': [
          'تهيئة A/B ready لتجارب العناوين والأزرار',
          'مدة التنفيذ: أقل من أسبوع في أغلب الحالات',
        ],
        'icon': Icons.rocket_launch_rounded,
        'color': const Color(0xFFB7D7C5),
      },
      {
        'title': 'تطبيقات Flutter',
        'desc':
            'واجهة واحدة تعمل عبر المنصات، تصميم متسق، وتحسين أداء للهواتف.',
        'details': [
          'دعم أساسي للإشعارات والـ Deep Links',
          'إعداد بنية جاهزة للنشر التجريبي',
        ],
        'icon': Icons.phone_android_rounded,
        'color': const Color(0xFF5D7FA0),
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall = constraints.maxWidth < 600;
        final double cardWidth = isSmall ? constraints.maxWidth : 230;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF5D7FA0), Color(0xFF7FB3C8)],
              ).createShader(bounds),
              child: const Text(
                'الخدمات',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: services.map((srv) {
                final IconData icon = srv['icon'] as IconData;
                final Color color = srv['color'] as Color;

                return HoverCard(
                  child: SizedBox(
                    width: cardWidth,
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    color,
                                    color.withValues(alpha: 0.6),
                                  ],
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
                              child: Icon(
                                icon,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              srv['title'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              srv['desc'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.6,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(height: 10),
                            ...List<String>.from(
                                    srv['details'] as List<dynamic>? ?? [])
                                .map(
                              (d) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color:
                                            color.withValues(alpha: 0.7),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        d,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          height: 1.4,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
