import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

extension MaskFactory on TextEditingController {
  TextEditingController cpf() {
    return MaskedTextController(
      mask: '000.000.000-00',
    );
  }

  TextEditingController cellphone() {
    return MaskedTextController(
      mask: '(00) 90000-0000',
    );
  }

  TextEditingController money() {
    return MoneyMaskedTextController(
      leftSymbol: 'R\$',
      precision: 2,
    );
  }

  String unmaskedValue() {
    return text.replaceAll(RegExp(r'[^\d]'), '');
  }

  double unmaskedToCurrency() {
    return double.tryParse(
            text.replaceAll(RegExp(r'[^\d,]'), '').replaceAll(',', '.')) ??
        0;
  }
}
