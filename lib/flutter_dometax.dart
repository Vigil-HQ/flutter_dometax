/// A Dart package for calculating taxes on prices, supporting both inclusive and exclusive tax calculations.
library;

/// Represents a tax with a name and rate
class Tax {
  final String name;
  final double rate;
  final bool isInclusive; // kept for compatibility (not used in global mode)

  const Tax({
    required this.name,
    required this.rate,
    required this.isInclusive,
  });
}
/// A class that handles tax calculations
class TaxCalculator {
  /// Calculates the total amount including taxes
  ///
  /// [price] is the base price
  /// [taxes] is a list of taxes to apply
  /// [isInclusive] indicates if the price already includes taxes
  ///
  /// Returns a map containing:
  /// - 'totalExclusivePrice': The original price
  /// - 'total': The final price with all taxes
  /// - 'taxAmounts': A map of tax names to their calculated amounts
  static Map<String, dynamic> calculateTotal(
      double price,
      List<Tax> taxes, {
        bool isInclusive = false,
      }) {
    final taxAmounts = <String, double>{};

    if (taxes.isEmpty) {
      return {
        'totalExclusivePrice': _round(price),
        'total': _round(price),
        'taxAmounts': taxAmounts,
      };
    }

    if (!isInclusive) {
      // ✅ Forward calculation (exclusive price)
      double total = price;

      for (final tax in taxes) {
        final amount = price * tax.rate;
        taxAmounts[tax.name] = _round(amount);
        total += amount;
      }

      return {
        'totalExclusivePrice': _round(price),
        'total': _round(total),
        'taxAmounts': taxAmounts,
      };
    } else {
      // ✅ Correct proportional backward calculation
      final totalRate =
      taxes.fold(0.0, (sum, tax) => sum + tax.rate);

      final basePrice = price / (1 + totalRate);

      for (final tax in taxes) {
        final amount = basePrice * tax.rate;

        
        taxAmounts[tax.name] = _round(amount);
      }

      return {
        'totalExclusivePrice': _round(basePrice),
        'total': _round(price),
        'taxAmounts': taxAmounts,
      };
    }
  }

  static double _round(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  static String formatCurrency(double amount) {
    return 'GHS ${amount.toStringAsFixed(2)}';
  }
}