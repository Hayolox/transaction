import 'package:intl/intl.dart';

class Utility {
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatDecimal(double value) {
    final double doubleValue = value.toDouble();
    return doubleValue % 1 == 0
        ? doubleValue.toInt().toString()
        : doubleValue.toString();
  }
}
