import 'package:flutter/material.dart';

import '../widgets/hover_card.dart';

class CvSection extends StatelessWidget {
  const CvSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> packages = [
      {
        'title': 'ملخص سريع',
        'desc':
            'تعريف مختصر بالسيرة والخبرات التقنية، مع روابط مباشرة لأهم الأعمال.',
        'features': [
          'بطاقة خبرات مختصرة',
          'روابط أعمال وشهادات',
          'تصميم بسيط وسريع القراءة',
        ],
      },
      {
        'title': 'سيرة كاملة',
        'desc':
            'عرض مفصل للتجارب، التقنيات، والشهادات مع تايملاين وشرائح قابلة للتطوير.',
        'features': [
          'خط زمني للتجارب',
          'قائمة مهارات منظمة',
          'قسم إنجازات بالأرقام',
        ],
      },
      {
        'title': 'حزمة عرض للشركات',
        'desc':
            'سيرة تفاعلية مع عرض تقديمي صغير، صور للأعمال، وخطة تعاون أولية.',
        'features': [
          'عرض تقديمي قصير',
          'ملف أعمال مختصر',
          'اقتراح خطوات التعاون',
        ],
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'السيرة والخبرة',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: packages.map((p) {
            final String title = p['title'] as String;
            final String desc = p['desc'] as String;
            final List<String> features = List<String>.from(
              p['features'] as List<dynamic>,
            );
            return HoverCard(
              child: SizedBox(
                width: 300,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          desc,
                          style: const TextStyle(fontSize: 14, height: 1.4),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'المحتوى:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...features.map(
                          (f) => Text(
                            '• $f',
                            style: const TextStyle(fontSize: 13),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text('اطلب نسخة PDF'),
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
  }
}
