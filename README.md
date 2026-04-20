# Product Catalog

A modern Flutter catalog application built with clean architecture and a corporate, minimal UI.

## Project Overview

Product Catalog is a production-style Flutter app that showcases products in a clean grid layout, includes a product detail page, and supports a simple cart experience using `setState` only.

## Flutter Version

- Flutter SDK: 3.41.7 stable
- Dart SDK: 3.11.5

## Features

- Clean Architecture structure
- Product grid home screen
- Product detail screen
- In-memory cart with quantity support
- Cart screen with item removal and total price summary
- Corporate, white-based UI design
- No external packages

## Project Structure

```text
lib/
  core/
    constants/
    theme/
    widgets/
  features/
    product/
      data/
      domain/
      presentation/
  main.dart
```

## How to Run

1. Install Flutter SDK 3.41.7 or newer.
2. Get project dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

4. Run tests:

```bash
flutter test
```

## Application Screenshots


### Home Screen

![Home Screen](https://github.com/MehmetGulbahar/product-catalog/blob/main/assets/home-screen.png)

### Product Detail Screen

![Product Detail Screen](https://github.com/MehmetGulbahar/product-catalog/blob/main/assets/product-detail-screen.png)

### Cart Screen

![Cart Screen](https://github.com/MehmetGulbahar/product-catalog/blob/main/assets/cart-screen.png)

## Design Direction

- White and light-gray corporate palette
- Soft blue accent color
- Rounded corners and subtle shadows
- Clean typography hierarchy
- Minimal, premium e-commerce style

## Notes

- The app uses mock data from a local in-memory source.
- Navigation and cart state are managed with `setState` only.
- This repository is ready for public GitHub release.
