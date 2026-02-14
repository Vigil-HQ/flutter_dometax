import 'package:flutter_dometax/flutter_dometax.dart';
import 'package:test/test.dart';

void main() {
  group('TaxCalculator - Exclusive Mode', () {
    final taxes = [
      Tax(name: 'VAT', rate: 0.15, isInclusive: true),
      Tax(name: 'NHIL', rate: 0.025, isInclusive: true),
    ];

    test('calculates tax-exclusive total correctly', () {
      final result = TaxCalculator.calculateTotal(1000.0, taxes);

      expect(result['totalExclusivePrice'], closeTo(1000.0, 0.01));
      expect(result['total'], closeTo(1175.0, 0.01));
      expect(result['taxAmounts']['VAT'], closeTo(150.0, 0.01));
      expect(result['taxAmounts']['NHIL'], closeTo(25.0, 0.01));
    });

    test('handles empty tax list', () {
      final result = TaxCalculator.calculateTotal(500.0, []);

      expect(result['totalExclusivePrice'], 500.0);
      expect(result['total'], 500.0);
      expect(result['taxAmounts'], isEmpty);
    });
  });

  group('TaxCalculator - Inclusive Mode', () {
    final taxes = [
      Tax(name: 'VAT', rate: 0.15, isInclusive: true),
      Tax(name: 'NHIL', rate: 0.025, isInclusive: true),
    ];

    test('calculates tax-inclusive total correctly', () {
      final result = TaxCalculator.calculateTotal(
        1175.0,
        taxes,
        isInclusive: true,
      );

      expect(result['totalExclusivePrice'], closeTo(1000.0, 0.01));
      expect(result['total'], closeTo(1175.0, 0.01));
      expect(result['taxAmounts']['VAT'], closeTo(150.0, 0.01));
      expect(result['taxAmounts']['NHIL'], closeTo(25.0, 0.01));
    });

    test('handles rounding correctly', () {
      final result = TaxCalculator.calculateTotal(
        100.0,
        [
          Tax(name: 'TestTax', rate: 0.175, isInclusive: true),
        ],
        isInclusive: true,
      );

      expect(result['total'], closeTo(100.0, 0.01));
      expect(result['totalExclusivePrice'], closeTo(85.11, 0.01));
      expect(result['taxAmounts']['TestTax'], closeTo(14.89, 0.01));
    });
  });

  group('Currency Formatting', () {
    test('formats correctly', () {
      final formatted = TaxCalculator.formatCurrency(1234.5);
      expect(formatted, 'GHS 1234.50');
    });
  });
}