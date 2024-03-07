extension RemoverSimbolos on String {
  String removeSymbols() {
    return replaceAll(RegExp(r'[^\d]'), '');
  }

  String removeSpecificSymbols({required RegExp regex}) {
    return replaceAll(regex, '');
  }
}
