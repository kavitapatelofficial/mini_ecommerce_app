# README.md
--------------------------------------------------------------------------------
# Mini E‑Commerce (Flutter)

A clean, testable implementation of a mini e‑commerce app with product listing, details, cart, offline cache, dark mode, localization, animations, and CI.

## Architecture
- **Clean Architecture + MVVM**
- **Data**: Remote (Dio) + Local (SharedPreferences JSON)
- **Domain**: Entities, Repositories, UseCases
- **Presentation**: Riverpod providers (Async/State notifiers), pages, widgets

## Why these libraries
- **Riverpod**: compile‑time safety, testable, global yet scoped providers
- **Dio**: robust HTTP, interceptors, great error handling
- **SharedPreferences**: simple persistence for cache/cart; fast to set up
- **connectivity_plus**: network reachability checks for offline fallback
- **easy_localization**: minimal boilerplate for i18n

## Run Locally
```bash
flutter pub get
flutter run -d <device>
```

## Tests
```bash
flutter test
```

## Features
- Home grid with images, name, price, Add to Cart
- Product details with large image, description
- Cart with +/−, remove, total calculation, persistent across restarts
- Offline cache for products; shows cached list when offline
- Dark mode toggle, English/Hindi localization
- Pull to refresh, retry on error
- Subtle animations (button scale, hero image)

## CI
- GitHub Actions workflow builds and tests on push/PR to main

---

> Tip: To change currency formatting or add more locales, extend translations and add a formatter in `intl`.
