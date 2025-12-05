import 'package:flutter/material.dart';

import '../widgets/section_wrapper.dart';

/// نسخ مبسطة لكل قسم بنصوص عربية واضحة تستخدم عند الحاجة لتخطيط سريع.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.home,
      title: 'أصمم وأطوّر واجهات وتجارب رقمية حديثة',
      child: const Text(
        'واجهات زجاجية، حركة سلسة، وسرعة تحميل محسّنة باللغة العربية.',
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.person,
      title: 'نبذة عني',
      child: const Text(
        'مطوّر واجهات وتجارب رقمية مع خبرة في Flutter والويب وتحسين الأداء.',
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.build,
      title: 'الخدمات',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(leading: Icon(Icons.web_rounded), title: Text('مواقع مخصصة متجاوبة', textDirection: TextDirection.rtl)),
          ListTile(leading: Icon(Icons.shopping_bag_rounded), title: Text('متاجر إلكترونية وتجربة شراء سلسة', textDirection: TextDirection.rtl)),
          ListTile(leading: Icon(Icons.rocket_launch_rounded), title: Text('Landing Pages لتحسين التحويل', textDirection: TextDirection.rtl)),
          ListTile(leading: Icon(Icons.phone_android_rounded), title: Text('تطبيقات Flutter هجينة بواجهة واحدة', textDirection: TextDirection.rtl)),
        ],
      ),
    );
  }
}

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.price_check,
      title: 'الأسعار',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.circle),
            title: Text('بداية: 250-400 USD، صفحات محدودة وسرعة عالية', textDirection: TextDirection.rtl),
          ),
          ListTile(
            leading: Icon(Icons.circle),
            title: Text('نمو: 700-1200 USD، موقع متكامل وتكاملات تواصل', textDirection: TextDirection.rtl),
          ),
          ListTile(
            leading: Icon(Icons.circle),
            title: Text('إطلاق منتج: 1500-2500 USD، تصميم وتطوير كامل', textDirection: TextDirection.rtl),
          ),
        ],
      ),
    );
  }
}

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.work,
      title: 'أعمال مختارة',
      child: const Text(
        'متاجر، عيادات، وصفحات هبوط بتصميم زجاجي وحركة محسوبة.',
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.photo_library,
      title: 'معرض الصور',
      child: const Text(
        'تدرجات وأيقونات كمعاينات خفيفة بدلاً من الصور الثقيلة.',
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.article,
      title: 'المدونة',
      child: const Text(
        'دروس قصيرة عن صفحات الهبوط، التصميم الزجاجي، وتحسين الأداء.',
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.reviews,
      title: 'قالوا عني',
      child: const Text(
        'ملاحظات من عملاء حول السرعة، وضوح التسليم، وتجربة الاستخدام.',
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

class CvSection extends StatelessWidget {
  const CvSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.badge,
      title: 'السيرة والخبرة',
      child: const Text(
        'خبرات في Flutter والويب مع مشاريع إنتاجية متنوعة وتحسين أداء.',
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

class TemplatesSection extends StatelessWidget {
  const TemplatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.description,
      title: 'النماذج الجاهزة',
      child: const Text(
        'Landing ومتاجر وبورتفوليو جاهزة للتخصيص السريع مع معاينات نصية.',
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.timeline,
      title: 'آلية العمل',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.search),
            title: Text('1. فهم الهدف والجمهور', textDirection: TextDirection.rtl),
          ),
          ListTile(
            leading: Icon(Icons.design_services),
            title: Text('2. تصميم تجربة وهوية', textDirection: TextDirection.rtl),
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('3. تطوير واختبار وإطلاق', textDirection: TextDirection.rtl),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      icon: Icons.contact_mail,
      title: 'اتصل بي',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.email),
            title: Text('email@example.com', textDirection: TextDirection.rtl),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('+964 xx xxx xxxx', textDirection: TextDirection.rtl),
          ),
        ],
      ),
    );
  }
}

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          '© ${DateTime.now().year} Montather Saleh — تطوير واجهات وتجارب رقمية',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
