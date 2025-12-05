import 'dart:ui';

import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isSmall = MediaQuery.of(context).size.width < 800;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(isSmall ? 24 : 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFF5D7FA0).withValues(alpha: 0.3),
              width: 2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      Colors.white.withValues(alpha: 0.05),
                      Colors.white.withValues(alpha: 0.02),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.7),
                      Colors.white.withValues(alpha: 0.5),
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5D7FA0).withValues(alpha: 0.2),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: isSmall
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Content(isDark: isDark, isSmall: isSmall),
                    const SizedBox(height: 24),
                    _buildImage(isSmall),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _Content(isDark: isDark, isSmall: isSmall)),
                    const SizedBox(width: 40),
                    Expanded(child: _buildImage(isSmall)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildImage(bool isSmall) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF5D7FA0).withValues(alpha: 0.3),
            width: 2,
          ),
          gradient: const LinearGradient(
            colors: [Color(0xFF5D7FA0), Color(0xFF7FB3C8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5D7FA0).withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        width: isSmall ? double.infinity : 400,
        height: isSmall ? 200 : 300,
        child: Center(
          child: Icon(
            Icons.brush_rounded,
            color: Colors.white.withValues(alpha: 0.9),
            size: isSmall ? 52 : 68,
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final bool isDark;
  final bool isSmall;

  const _Content({required this.isDark, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF5D7FA0), Color(0xFF7FB3C8)],
          ).createShader(bounds),
          child: Text(
            'نبذة عني',
            style: TextStyle(
              fontSize: isSmall ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'مطوّر واجهات وتجارب رقمية شغوف ببناء مواقع وتطبيقات أنيقة وسريعة. أركز على التفاصيل الصغيرة التي تضمن تجربة استخدام سلسة، من سرعة التحميل إلى حركة الهوفر والانتقالات الدقيقة التي تعطي إحساساً بالحيوية.',
          style: TextStyle(
            fontSize: isSmall ? 16 : 18,
            height: 1.8,
            color: isDark
                ? Colors.white.withValues(alpha: 0.9)
                : const Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'أمتلك خبرة عملية في Flutter وواجهات الويب الحديثة مع تصميمات زجاجية وتأثيرات حركة محسوبة. أحب تحويل الأفكار إلى تجارب مرئية، مع الحفاظ على بنية نظيفة وقابلة للتطوير، واستخدام ممارسات تحسين الأداء وتهيئة الـ SEO للمشاريع الإنتاجية.',
          style: TextStyle(
            fontSize: isSmall ? 16 : 18,
            height: 1.8,
            color: isDark
                ? Colors.white.withValues(alpha: 0.9)
                : const Color(0xFF4B5563),
          ),
        ),
      ],
    );
  }
}
