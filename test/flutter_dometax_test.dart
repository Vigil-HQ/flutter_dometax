

import 'package:flutter_dometax/flutter_dometax.dart';
import 'package:test/test.dart';

void main() {
  group('TaxCalculator', () {
    final taxes = [
      Tax(name: 'VAT', rate: 0.15, isInclusive: true),
      Tax(name: 'NHIL', rate: 0.025, isInclusive: true),
    ];

    test('calculates tax-exclusive total correctly', () {
      final result = TaxCalculator.calculateTotal(1000.0, taxes);
      expect(result['totalExclusivePrice'], 1000.0);
      expect(result['total'], 1175.0);
      expect(result['taxAmounts']['VAT'], 150.0);
      expect(result['taxAmounts']['NHIL'], 25.0);
    });

    test('calculates tax-inclusive total correctly', () {
      final result = TaxCalculator.calculateTotal(
        1175.0,
        taxes,
        isInclusive: true,
      );
      expect(result['totalExclusivePrice'], closeTo(1000.0, 0.01));
      expect(result['total'], 1175.0);
      expect(result['taxAmounts']['VAT'], closeTo(150.0, 0.01));
      expect(result['taxAmounts']['NHIL'], closeTo(25.0, 0.01));
    });
  });
}