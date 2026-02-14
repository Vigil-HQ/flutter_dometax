import 'package:flutter_dometax/flutter_dometax.dart';

void main() {
  final taxes = [
    Tax(name: 'VAT', rate: 0.15, isInclusive: true),
    Tax(name: 'NHIL', rate: 0.025, isInclusive: true),
  ];

  // ----------------------------
  // Example 1: Tax-exclusive
  // ----------------------------
  final exclusivePrice = 1000.0;

  final result =
  TaxCalculator.calculateTotal(exclusivePrice, taxes);

  print('Tax-exclusive calculation:');
  print(
    'Total Exclusive Price: '
        '${TaxCalculator.formatCurrency(result['totalExclusivePrice'])}',
  );
  print(
    'Total: '
        '${TaxCalculator.formatCurrency(result['total'])}',
  );
  print('Tax breakdown:');
  result['taxAmounts'].forEach((name, amount) {
    print('$name: ${TaxCalculator.formatCurrency(amount)}');
  });

  // ----------------------------
  // Example 2: Tax-inclusive
  // ----------------------------
  final inclusivePrice = 1175.0;

  final inclusiveResult = TaxCalculator.calculateTotal(
    inclusivePrice,
    taxes,
    isInclusive: true,
  );

  print('\nTax-inclusive calculation:');
  print(
    'Total Exclusive Price: '
        '${TaxCalculator.formatCurrency(inclusiveResult['totalExclusivePrice'])}',
  );
  print(
    'Total: '
        '${TaxCalculator.formatCurrency(inclusiveResult['total'])}',
  );
  print('Tax breakdown:');
  inclusiveResult['taxAmounts'].forEach((name, amount) {
    print('$name: ${TaxCalculator.formatCurrency(amount)}');
  });
}
