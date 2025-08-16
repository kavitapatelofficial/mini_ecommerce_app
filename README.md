# Mini E‑Commerce (Flutter)

A clean, testable mini e‑commerce app with product listing, details, cart, offline cache, dark mode, localization, animations, and CI.

## Architecture
- **Clean Architecture + MVVM**
- **Data Layer**: Remote (Dio) + Local (Hive)
- **Domain Layer**: Entities, Repositories, UseCases
- **Presentation Layer**: Riverpod providers (Async/State notifiers), pages, widgets

## Libraries Used
- **Riverpod**: compile‑time safety, testable, global yet scoped providers  
- **Dio**: robust HTTP client, interceptors, error handling  
- **Hive + hive_flutter**: fast local storage & offline cache, including product images  
- **connectivity_plus**: check network connectivity for offline fallback  
- **easy_localization**: multi-language support (English & Hindi)  
- **animations**: smooth UI transitions and hero effects  

## Features
- Home grid with images, title, price, Add to Cart  
- Product details with large image, description  
- Cart with increment/decrement, remove, total calculation  
- Offline cache for products and images; displays cached data when offline  
- Dark mode toggle & English/Hindi localization  
- Pull-to-refresh, retry button on error  
- Subtle animations: button scale, hero image transition  

## Getting Started

### 1️⃣ Clone the repository
```bash
git clone https://github.com/<your-username>/mini_ecommerce.git
cd mini_ecommerce

2️⃣ Install dependencies
flutter pub get

3️⃣ Generate Hive type adapters
flutter packages pub run build_runner build --delete-conflicting-outputs


4️⃣ Run the app
flutter run -d <device>

5️⃣ Run tests
flutter test
