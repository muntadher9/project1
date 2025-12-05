import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final links = [
      {
        'icon': Icons.link,
        'label': 'LinkedIn',
        'url': 'https://www.linkedin.com/in/montather-saleh'
      },
      {
        'icon': Icons.palette,
        'label': 'Behance',
        'url': 'https://www.behance.net/montather-saleh'
      },
      {
        'icon': Icons.code,
        'label': 'GitHub',
        'url': 'https://github.com/montather-saleh'
      },
    ];

    return Wrap(
      spacing: 8,
      children: links
          .map(
            (l) => ActionChip(
              avatar: Icon(l['icon'] as IconData, size: 16),
              label: Text(l['label'] as String),
              onPressed: () async {
                final uri = Uri.parse(l['url'] as String);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
            ),
          )
          .toList(),
    );
  }
}
