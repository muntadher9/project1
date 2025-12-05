import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class PricingSection extends StatelessWidget {
  final VoidCallback onCta;
  const PricingSection({required this.onCta, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isSmall = MediaQuery.of(context).size.width < 600;

    final List<Map<String, Object>> plans = [
      {
        'name': 'بداية',
        'price': '250 - 400 USD',
        'gradient': [const Color(0xFF5D7FA0), const Color(0xFF7FB3C8)],
        'features': [
          'صفحة أو صفحتان بهوية بسيطة وسرعة عالية',
          'تهيئة أساسية للسرعة و SEO',
          'استضافة ونشر أولي',
          'مدة التسليم: 1-2 أسبوع',
          'مراجعتان للتعديل',
        ],
      },
      {
        'name': 'نمو',
        'price': '700 - 1200 USD',
        'gradient': [const Color(0xFF7FB3C8), const Color(0xFFB7D7C5)],
        'features': [
          'موقع متكامل مع 5-8 صفحات',
          'نماذج واتساب/بريد وتصميم زجاجي بحركة خفيفة',
          'تحسين أداء وتهيئة SEO متقدمة',
          'مدة التسليم: 3-4 أسابيع',
          '3-4 مراجعات للتعديل',
        ],
      },
      {
        'name': 'إطلاق منتج',
        'price': '1500 - 2500 USD',
        'gradient': [const Color(0xFFB7D7C5), const Color(0xFF5D7FA0)],
        'features': [
          'تصميم UX/UI كامل (منتج أو لوحة تحكم) + Landing',
          'إعداد تحليلات وتحويلات',
          'دعم نشر وإصدارات لمدة شهرين',
          'خطة تحسين دورية للأداء والتحويل',
          'مدة التسليم: 6-8 أسابيع',
          '5 مراجعات للتعديل',
        ],
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
            'الباقات والأسعار',
            style: TextStyle(
              fontSize: isSmall ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: plans.map((p) {
            final String name = p['name'] as String;
            final String price = p['price'] as String;
            final List<Color> gradient = p['gradient'] as List<Color>;
            final List<String> features =
                List<String>.from(p['features'] as List<dynamic>);

            return _PricingCard(
              name: name,
              price: price,
              gradient: gradient,
              features: features,
              isDark: isDark,
              isSmall: isSmall,
              onCta: onCta,
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const Text(
          'الأسئلة الشائعة',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        ...const [
          _FaqItem(
            question: 'هل يمكن التوسعة لاحقاً؟',
            answer:
                'نعم، يمكن إضافة صفحات أو خصائص جديدة مع الحفاظ على التصميم والأداء.',
          ),
          _FaqItem(
            question: 'هل يشمل السعر الاستضافة؟',
            answer:
                'الباقات تتضمن نشر أولي، ويمكن تضمين الاستضافة والدومين حسب الحاجة.',
          ),
          _FaqItem(
            question: 'كيف يتم الدفع؟',
            answer:
                'دفعة مبدئية عند البدء ودفعة عند التسليم، مع خيارات دفع مرنة.',
          ),
        ],
      ],
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600),
          textDirection: TextDirection.rtl,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              answer,
              style: const TextStyle(height: 1.5),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}

class _PricingCard extends StatefulWidget {
  final String name;
  final String price;
  final List<Color> gradient;
  final List<String> features;
  final bool isDark;
  final bool isSmall;
  final VoidCallback onCta;

  const _PricingCard({
    required this.name,
    required this.price,
    required this.gradient,
    required this.features,
    required this.isDark,
    required this.isSmall,
    required this.onCta,
  });

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double cardWidth = widget.isSmall ? double.infinity : 320;

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
                      ? widget.gradient[0].withValues(alpha: 0.6)
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
                        ? widget.gradient[0].withValues(alpha: 0.4)
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
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: widget.gradient,
                      ).createShader(bounds),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.price,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: widget.gradient[0],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: widget.gradient),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...widget.features.map((f) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: widget.gradient,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  f,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: widget.isDark
                                        ? Colors.white.withValues(alpha: 0.8)
                                        : const Color(0xFF4B5563),
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: widget.gradient),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: widget.gradient[0].withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: widget.onCta,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'احجز باقتك الآن',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
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
}
