import 'package:flutter/material.dart';

import '../widgets/hover_card.dart';
import 'template_pages.dart';

class TemplatesSection extends StatelessWidget {
  const TemplatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> templates = [
      {
        'name': 'صفحة هبوط منتج',
        'description': 'Landing Page بخط عربي، دعوة واضحة للتجربة، ونموذج تواصل سريع.',
        'id': 'template1',
        'tag': 'Landing',
        'icon': Icons.rocket_launch_rounded,
      },
      {
        'name': 'متجر مصغر',
        'description': 'قالب متجر صغير مع عرض منتجات، سلة مبسطة، وروابط دفع خارجية.',
        'id': 'template2',
        'tag': 'Store',
        'icon': Icons.store_rounded,
      },
      {
        'name': 'ملف تعريفي (بورتفوليو)',
        'description': 'قالب شخصي/شركي يعرض الأعمال، الشهادات، ونموذج تواصل.',
        'id': 'template3',
        'tag': 'Portfolio',
        'icon': Icons.work,
      },
      {
        'name': 'مدونة خفيفة',
        'description': 'قالب تدوين سريع مع فئات، بحث بسيط، وتصميم زجاجي أنيق.',
        'id': 'template4',
        'tag': 'Blog',
        'icon': Icons.article,
      },
      {
        'name': 'صفحة خدمات',
        'description': 'تعريف بالخدمات مع تسعير مختصر وروابط مباشرة للتواصل.',
        'id': 'template5',
        'tag': 'Services',
        'icon': Icons.build,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF5D7FA0), Color(0xFF7FB3C8)],
          ).createShader(bounds),
          child: const Text(
            'النماذج الجاهزة',
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
          children: templates.map((template) {
            final IconData icon = template['icon'] as IconData;
            final String tag = template['tag'] as String;
            return HoverCard(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(icon,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                template['name'] as String,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.1),
                            side: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        template['description'] as String,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => TemplatePreviewPage(
                                title: template['name'] as String,
                              ),
                            ));
                          },
                          child: const Text('معاينة القالب'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
