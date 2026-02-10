<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Flutter TaxCalculate 🧮

A Dart package for calculating taxes on prices, supporting both inclusive and exclusive tax calculations.

## Features ✨

* ✅ Calculate multiple taxes simultaneously
* 🔄 Handle both tax-inclusive and tax-exclusive prices
* 📊 Detailed tax breakdown report
* 🛠️ Simple and intuitive API
* 💰 GHS currency formatting

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_dometax: ^1.0.0
```

## Usage

### Basic Usage

```dart
import 'package:flutter_dometax/flutter_dometax.dart';

void main() {
  // Define your taxes
  final taxes = [
    Tax(name: 'VAT', rate: 0.15), // 15% VAT
    Tax(name: 'NHIL', rate: 0.025), // 2.5% NHIL
  ];

  // Calculate tax-exclusive price
  final result = TaxCalculator.calculateTotal(1000.0, taxes);
  
  // Calculate tax-inclusive price
  final inclusiveResult = TaxCalculator.calculateTotal(
    1000.0,
    taxes,
    isInclusive: true,
  );
}
```

### API Reference

#### Tax Class

```dart
class Tax {
  final String name;  // Name of the tax
  final double rate;  // Tax rate (e.g., 0.15 for 15%)
}
```

#### TaxCalculator Class

```dart
class TaxCalculator {
  // Calculate total with taxes
  static Map<String, dynamic> calculateTotal(
    double price,
    List<Tax> taxes, {
    bool isInclusive = false,
  });

  // Format amount as GHS currency
  static String formatCurrency(double amount);
}
```

The `calculateTotal` method returns a map with:
- `totalExclusivePrice`: The original price
- `total`: The final price with all taxes
- `taxAmounts`: A map of tax names to their calculated amounts

## Example

Check out the [example](example/flutter_dometax_example.dart) for a complete usage example.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Additional information