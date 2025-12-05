# GitHub Copilot / AI Agent Instructions

This file captures the essential, discoverable knowledge an AI coding agent needs to be productive in this Flutter website repository.

## Purpose / Big picture
- Single-page, scroll-driven portfolio website built with Flutter (web + mobile). Main entry: `lib/main.dart`.
- UI is composed of independent section widgets under `lib/sections/` (e.g. `HeroSection`, `ServicesSection`, `PricingSection`) and small reusable widgets under `lib/widgets/` (e.g. `FadeIn`, `HandDrawnDivider`).
- Navigation uses a `TopBar` which calls `HomePage._scrollToSection` with Arabic-labeled keys stored in a `Map<String, GlobalKey>` to scroll to each section.

## Key files & directories (start here)
- `lib/main.dart` — app entry, theming, `HomePage` composition and section wiring.
- `lib/sections/` — major UI sections, each usually a `StatelessWidget` or `StatefulWidget` with optional `Key` for scroll targets.
- `lib/widgets/` — small shared widgets used across sections (animations, dividers, helpers).
- `pubspec.yaml` — dependencies and `assets/images/` registration.

## How to run & build (developer flow)
- Run locally in Chrome (debug):
  ```powershell
  flutter run -d chrome
  ```
- Build web production bundle:
  ```powershell
  flutter build web
  ```
- Common quick checks:
  - `flutter analyze` — static analysis
  - `flutter test` — unit/widget tests (if present)

## Project conventions & patterns (important)
- Single-page layout: All sections are assembled in `HomePage` and separated by `HandDrawnDivider` and `FadeIn` wrappers — preserve these wrappers when adding new sections for consistent UX.
- Section keys use Arabic labels (e.g. `'عنّي'`, `'الخدمات'`) as map keys in `HomePage._sectionKeys`. When adding or referencing sections, use the existing label strings to ensure `TopBar` navigation works.
- The top navigation does not use named routes — it scrolls to `GlobalKey` contexts using `Scrollable.ensureVisible`.
- Fonts via `google_fonts` package; theme switching toggles `_isDark` inside `MyApp` and is passed to `HomePage`.
- Assets are under `assets/images/` and are registered in `pubspec.yaml`. Use relative asset paths (no package prefix).

## External integrations
- `url_launcher` is present and used for external links; prefer `Uri` typed APIs when launching links.

## Common, discoverable pitfalls (from repo scan)
- Type-safety: code uses maps like `p['name']` and `p['price']` in several places. These are typed as `Object?` by default and may cause compile-time errors. Use safe casts or `toString()` where a `String` is required, e.g. `p['name'] as String` or `p['name']?.toString()`.
- Scroll targets rely on `GlobalKey` being assigned to the section widget (pass `key:` when constructing the section). If navigation doesn't work, ensure the section widget accepts and forwards the `Key` to its root element.

## Examples (copy-paste friendly)
- Scroll to section (pattern used in `HomePage`):
  ```dart
  final key = _sectionKeys[section];
  if (key?.currentContext != null) {
    Scrollable.ensureVisible(key!.currentContext!, duration: Duration(milliseconds: 800));
  }
  ```
- Casting map value to `String` (fixes common compile-time error):
  ```dart
  // BAD (may be Object):
  // p['name']!

  // SAFE:
  final name = (p['name'] as String? ) ?? p['name']?.toString() ?? '';
  ```

## Where to change content
- To edit copy / hero text: `lib/sections/hero_section.dart`.
- To edit pricing data: open `lib/sections/pricing_section.dart` (data usually expressed as `List<Map>` — be mindful of value types).

## PR and editing notes for AI agents
- Keep edits minimal and focused; follow the existing widget composition and styling.
- When adding a new section: add the widget file under `lib/sections/`, export it where needed, add an entry in `HomePage` column and add a matching key in `_sectionKeys` with the Arabic label used by `TopBar`.
- Run `flutter analyze` after changes to catch static typing issues early.

---
If any part of this guidance is unclear or you want me to include more code examples (e.g. `TopBar` internals or `pricing_section.dart` fixes), tell me which area and I'll expand or update this file.
