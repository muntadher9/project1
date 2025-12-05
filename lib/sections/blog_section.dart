import 'package:flutter/material.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> posts = [
      {
        'title': 'دليل تصميم صفحات هبوط فعّالة',
        'excerpt':
            'كيف تخطط للـ CTA، وتستخدم النص القصير والصور الخفيفة لتحسين التحويل، مع أمثلة عملية.',
      },
      {
        'title': 'بناء واجهات زجاجية متوازنة',
        'excerpt':
            'نصائح لاستخدام الخلفيات الضبابية والظلال دون التضحية بالأداء أو سهولة القراءة.',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('المدونة',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Column(
          children: posts.map((p) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(blurRadius: 8, color: Colors.black12)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    p['excerpt']!,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
