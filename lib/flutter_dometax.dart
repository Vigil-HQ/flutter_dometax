/// A Dart package for calculating taxes on prices, supporting both inclusive and exclusive tax calculations.
library;

/// Represents a tax with a name and rate
class Tax {
  final String name;
  final double rate;
  final bool isInclusive;

  const Tax({required this.name, required this.rate, required this.isInclusive});
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
    if (taxes.isEmpty) {
      return {
        'totalExclusivePrice': price,
        'total': price,
        'taxAmounts': <String, double>{},
      };
    }

    final taxAmounts = <String, double>{};
    double total = price;
    double totalExclusivePrice = price;

    if (isInclusive) {
      // Calculate backwards from inclusive price
      double remainingAmount = price;
      for (final tax in taxes) {
        final taxAmount = remainingAmount * (tax.rate / (1 + tax.rate));
        taxAmounts[tax.name] = taxAmount;
        remainingAmount -= taxAmount;
      }
      totalExclusivePrice = remainingAmount;
    } else {
      // Calculate forward from exclusive price
      for (final tax in taxes) {
        final taxAmount = price * tax.rate;
        taxAmounts[tax.name] = taxAmount;
        total += taxAmount;
      }
    }

    return {
      'totalExclusivePrice': totalExclusivePrice,
      'total': isInclusive ? price : total,
      'taxAmounts': taxAmounts,
    };
  }

  /// Formats a number as currency in GHS (Ghana Cedis)
  static String formatCurrency(double amount) {
    return 'GHS ${amount.toStringAsFixed(2)}';
  }
}