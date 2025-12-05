import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onPricingTap;
  const HeroSection({super.key, required this.onPricingTap});

  Future<void> _launchWhatsApp() async {
    final Uri waUri = Uri.parse(
      'https://wa.me/9647729081541?text=مرحبا، أود معرفة المزيد عن خدماتك.',
    );
    if (!await launchUrl(waUri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $waUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    final int hour = DateTime.now().hour;
    final String greeting = hour < 12
        ? 'صباح الخير'
        : hour < 18
            ? 'نهارك سعيد'
            : 'مساء الخير';

    const String subtitle =
        'أصمّم وأطوّر تجارب ويب وتطبيقات Flutter بتصاميم زجاجية مبهجة وحركة سلسة. أركز على التفاصيل الصغيرة: سرعة التحميل، دقّة الهوفر، وأنيميشن محسوب يضيف حياة للتجربة.\n'
        'أعمل مع العلامات التجارية الناشئة والشركات القائمة لبناء واجهات عربية/إنجليزية متجاوبة، مع تحسين الأداء وتهيئة SEO وتجهيز خطوط الإنتاج للنشر.';

    final bool isSmall = MediaQuery.of(context).size.width < 800;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Widget leftContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF5D7FA0), Color(0xFF7FB3C8)],
          ).createShader(bounds),
          child: Text(
            greeting,
            style: TextStyle(
              fontSize: isSmall ? 20 : 28,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'أصمم وأطوّر واجهات وتجارب رقمية حديثة',
          style: TextStyle(
            fontSize: isSmall ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF1F2937),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF5D7FA0), Color(0xFF7FB3C8)],
          ).createShader(bounds),
          child: Text(
            'مطور واجهات | Montather Saleh',
            style: TextStyle(
              fontSize: isSmall ? 18 : 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: isSmall ? 14 : 18,
            height: 1.8,
            color: isDark
                ? Colors.white.withValues(alpha: 0.8)
                : const Color(0xFF4B5563),
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF5D7FA0), Color(0xFF7FB3C8)],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5D7FA0).withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: _launchWhatsApp,
                icon:
                    const Icon(Icons.chat_bubble_rounded, color: Colors.white),
                label: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    'تواصل عبر واتساب',
                    style: TextStyle(
                      fontSize: isSmall ? 16 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: onPricingTap,
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                side: BorderSide(
                  color: const Color(0xFF5D7FA0).withValues(alpha: 0.6),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.price_check, color: Color(0xFF5D7FA0)),
              label: Text(
                'عرض الباقات',
                style: TextStyle(
                  fontSize: isSmall ? 15 : 17,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5D7FA0),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    final Widget rightImage = ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: isSmall ? double.infinity : 450,
          height: isSmall ? 250 : 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border:
                Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF5D7FA0), Color(0xFFB7D7C5)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5D7FA0).withValues(alpha: 0.25),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.auto_awesome,
              size: isSmall ? 64 : 96,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ),
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmall ? 24 : 40),
      child: isSmall
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [leftContent, const SizedBox(height: 32), rightImage],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: leftContent),
                const SizedBox(width: 60),
                Expanded(child: rightImage),
              ],
            ),
    );
  }
}
