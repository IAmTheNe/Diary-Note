import 'package:intl/intl.dart';

/// A class that formats date and time values according to a user-specified pattern
class DateTimeFormatter {
  /// `dMMMyyyy` is a function that takes an optional `DateTime` parameter and returns a `String`
  /// formatted as `d MMM yyyy`
  ///
  /// Args:
  ///   time (DateTime): The time to format. If null, the current time is used.
  ///
  /// Returns:
  ///   A String
  static String dMMMyyyy([DateTime? time]) {
    return DateFormat('d MMM yyyy').format(time ?? DateTime.now());
  }

  /// It returns a string that
  /// represents the time in the format "HH:MM AM/PM"
  ///
  /// Args:
  ///   time (DateTime): The time to format. If not specified, the current time is used.
  static String hmma([DateTime? time]) {
    return DateFormat('hh:mm a').format(time ?? DateTime.now());
  }

  /// It takes an optional parameter of type DateTime and returns a String
  ///
  /// Args:
  ///   time (DateTime): The time to format. If not specified, the current time is used.
  ///
  /// Returns:
  ///   A String
  static String shortDateTime([DateTime? time]) {
    return DateFormat('d MMM yyyy, hh:mm a').format(time ?? DateTime.now());
  }

  /// `customPattern` is a function that takes a `pattern` and an optional `time` and returns a `String`
  ///
  /// Args:
  ///   `pattern` (String): The pattern to use for formatting.
  ///   `time` (DateTime): The time to be formatted. If not provided, the current time is used.
  ///
  /// Returns:
  ///   A String
  static String customPattern({required String pattern, DateTime? time}) {
    return DateFormat(pattern).format(time ?? DateTime.now());
  }
}
