import 'package:flutter/material.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> steps = [
      'فهم الهدف والجمهور، وتحديد الرسائل الأساسية.',
      'تصميم التجربة والهوية المرئية مع نماذج أولية تفاعلية.',
      'التطوير بتقنيات Flutter/ويب مع اختبارات سرعة وتجربة.',
      'الإطلاق والمتابعة مع تحسينات دورية للأداء والتحويل.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('آلية العمل',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: steps.map((s) {
            return Container(
              width: 230,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                s,
                style: const TextStyle(fontSize: 14, height: 1.5),
                textDirection: TextDirection.rtl,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
