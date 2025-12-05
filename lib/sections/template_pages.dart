import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String desc;
  const FeatureCard({required this.title, required this.desc, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(desc, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

/// صفحة معاينة بسيطة توضح مكان القالب بدون صور
class TemplatePreviewPage extends StatelessWidget {
  final String title;
  const TemplatePreviewPage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _glassCard(
              context,
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('عنوان رئيسي',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    'هنا وصف سريع للقالب، بدون صور حقيقية. يمكن استبداله لاحقاً بموادك المرئية.',
                    style: TextStyle(fontSize: 14, height: 1.6),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('مزايا القالب',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                FeatureCard(title: 'سرعة', desc: 'تحسين أداء أساسي.'),
                FeatureCard(title: 'تصميم زجاجي', desc: 'تدرجات وأنيميشن ناعم.'),
                FeatureCard(title: 'تكامل تواصل', desc: 'نماذج واتساب وبريد.'),
              ],
            ),
            const SizedBox(height: 20),
            _glassCard(
              context,
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('تواصل',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('email@example.com\n+964 770 000 0000'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassCard(BuildContext context,
      {required double height, required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF5D7FA0), Color(0xFF7FB3C8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5D7FA0).withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        ),
      ),
    );
  }
}
