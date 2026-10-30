# Mini Product Catalog (Flutter)

A three-screen Flutter app for the Lifecycle, Navigator, and go_router assignment.

## Included
- `lib/main.dart`: all three StatefulWidget pages, lifecycle logging, active go_router navigation, answers to the written questions, and commented Navigator examples.
- `lib/product_widgets.dart`: reusable responsive list/grid product widgets.
- `pubspec.yaml`: minimal project manifest with `go_router`.

## Run it
1. Create a new Flutter project in a new folder:
   ```bash
   flutter create mini_product_catalog
   ```
2. Replace that project's `lib` folder with the `lib` folder from this package, and replace `pubspec.yaml` with the included one (or add `go_router: ^16.0.0` under dependencies if your installed Flutter/Dart version requires a compatible version).
3. In the project root, run:
   ```bash
   flutter pub get
   flutter run -d chrome
   ```
4. Open the Debug Console/terminal, log in as Guest, tap a heart, open a product, add it to cart, and resize the browser. Capture a screenshot of the lifecycle prints for submission.

## Notes
- The active app uses `MaterialApp.router` and `go_router`, as required for final submission.
- Navigator snippets are intentionally commented out in `main.dart`.
- If `go_router` reports a version constraint conflict, keep the Flutter-generated environment constraints and select the latest compatible `go_router` version shown by `flutter pub add go_router`.
- Product prices and images are demo placeholders; no form, validation, or persistence is required.
