class Numbers {
  kFormatter(int number) {
    if (number > 999999) {
      return '${(number/1000000).toStringAsFixed(2)}m';
    }
    if (number > 999) {
      return '${(number/1000).toStringAsFixed(1)}k';
    }
    return '$number';
  }

  commaThousands(int number) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';

    String str = number.toString();
    final newStr = str.replaceAllMapped(reg, mathFunc);
    return newStr;
  }
}