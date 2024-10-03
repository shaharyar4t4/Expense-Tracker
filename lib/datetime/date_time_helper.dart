import 'dart:ffi';

// this function is help  to Convert the DateTime into String
String coventDateTimeToString(DateTime dateTime) {
  // for Year
  String year = dateTime.year.toString();
  // for month
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // for day
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
