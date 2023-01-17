import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String dMMMyyyy([DateTime? time]) {
    return DateFormat('d MMM yyyy').format(time ?? DateTime.now());
  }

  static String hmma([DateTime? time]) {
    return DateFormat('hh:mm a').format(time ?? DateTime.now());
  }

  static String shortDateTime([DateTime? time]) {
    return DateFormat('d MMM yyyy, hh:mm a').format(time ?? DateTime.now());
  }
}
