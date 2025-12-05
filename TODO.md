# Full Cleanup and Polish TODO

## Deprecations and Issues to Fix
- [x] Fix deprecated `withOpacity` to `withValues(alpha: )` across all files
- [x] Fix deprecated `Matrix4.translate` and `scale` to new methods
- [x] Use super parameters where applicable
- [x] Remove unnecessary imports
- [x] Fix private types in public API (make state classes public)

## Files to Update
- [x] lib/main.dart
- [x] lib/sections/about_section.dart
- [x] lib/sections/contact_section.dart
- [x] lib/sections/hero_section.dart
- [x] lib/sections/portfolio_section.dart
- [x] lib/sections/pricing_section.dart
- [x] lib/sections/services_section.dart
- [x] lib/sections/simple_sections.dart
- [x] lib/sections/top_bar.dart
- [x] lib/widgets/fade_in.dart
- [x] lib/widgets/hand_drawn_divider.dart
- [x] lib/widgets/hover_card.dart
- [x] lib/widgets/section_wrapper.dart

## Followup
- [x] Run flutter analyze to verify all issues fixed
- [ ] Test the app for regressions
