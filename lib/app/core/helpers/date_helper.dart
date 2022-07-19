import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static final _dateFormat = DateFormat('dd/MM/yyyy');

  static String formatDate(String date) {
    initializeDateFormatting('pt_BR');

    return _dateFormat.format(DateTime.parse(date));
  }
}
