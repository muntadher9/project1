import 'package:flutter/material.dart';

typedef NavigateCallback = void Function(String section);

class TopBar extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDark;
  final NavigateCallback onNavigate;
  const TopBar({
    super.key,
    required this.toggleTheme,
    required this.isDark,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmall = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 16,
        vertical: isSmall ? 6 : 10,
      ),
      child: Row(
        children: [
          if (!isSmall) ...[
            Icon(Icons.code, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Montather Saleh',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _NavButton(
                    icon: Icons.person,
                    label: 'الرئيسية',
                    onPressed: () => onNavigate('services'),
                    isDark: isDark,
                  ),
                  _NavButton(
                    icon: Icons.build,
                    label: 'الخدمات',
                    onPressed: () => onNavigate('services'),
                    isDark: isDark,
                  ),
                  _NavButton(
                    icon: Icons.work,
                    label: 'أعمال',
                    onPressed: () => onNavigate('portfolio'),
                    isDark: isDark,
                  ),
                  _NavButton(
                    icon: Icons.price_check,
                    label: 'الأسعار',
                    onPressed: () => onNavigate('pricing'),
                    isDark: isDark,
                  ),
                  _NavButton(
                    icon: Icons.contact_mail,
                    label: 'اتصل بي',
                    onPressed: () => onNavigate('contact'),
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: toggleTheme,
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;

  const _NavButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.isDark,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered
              ? Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: 0.14)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: widget.onPressed,
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: _isHovered ? FontWeight.w700 : FontWeight.w500,
                  color: widget.isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
