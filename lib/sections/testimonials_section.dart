import 'package:flutter/material.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> testimonials = [
      {
        'name': 'علي - مالك متجر',
        'feedback':
            'التصميم الزجاجي والحركة أعطت تجربة شراء ممتعة، والسرعة تحسنت كثيراً.',
      },
      {
        'name': 'سارة - مديرة عيادة',
        'feedback':
            'لوحة الحجز الجديدة سهّلت العمل، والواجهات بالعربية واضحة للمرضى.',
      },
      {
        'name': 'حسين - مؤسس ناشئ',
        'feedback':
            'Landing Page مختصرة رفعت التحويلات، وتم التنفيذ في وقت قصير.',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('قالوا عن العمل',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: testimonials.map((t) {
            return SizedBox(
              width: 280,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t['feedback']!,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                        textDirection: TextDirection.rtl,
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
