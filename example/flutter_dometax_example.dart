import 'package:flutter_dometax/flutter_dometax.dart';

void main() {
  // Example 1: Tax-exclusive calculation
  final taxes = [
    Tax(name: 'VAT', rate: 0.15, isInclusive: true), // 15% VAT
    Tax(name: 'NHIL', rate: 0.025, isInclusive: true), // 2.5% NHIL
  ];

  final price = 1000.0;
  final result = TaxCalculator.calculateTotal(price, taxes);

  print('Tax-exclusive calculation:');
  print('Total Exclusive Price: ${TaxCalculator.formatCurrency(result['totalExclusivePrice'])}');
  print('Total: ${TaxCalculator.formatCurrency(result['total'])}');
  print('Tax breakdown:');
  result['taxAmounts'].forEach((name, amount) {
    print('$name: ${TaxCalculator.formatCurrency(amount)}');
  });

  // Example 2: Tax-inclusive calculation
  final inclusiveResult = TaxCalculator.calculateTotal(
    price,
    taxes,
    isInclusive: true,
  );

  print('\nTax-inclusive calculation:');
  print(
    'Total Exclusive Price: ${TaxCalculator.formatCurrency(inclusiveResult['totalExclusivePrice'])}',
  );
  print('Total: ${TaxCalculator.formatCurrency(inclusiveResult['total'])}');
  print('Tax breakdown:');
  inclusiveResult['taxAmounts'].forEach((name, amount) {
    print('$name: ${TaxCalculator.formatCurrency(amount)}');
  });
}