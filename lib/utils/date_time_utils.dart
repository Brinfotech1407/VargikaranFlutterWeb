import 'package:intl/intl.dart';


class DateTimeUtils {
  static String getFormattedDate(int timeInMillis) {
    final DateTime currentDate = DateTime.now();
    final DateTime messageDate =
    DateTime.fromMillisecondsSinceEpoch(timeInMillis);

    final bool isSameMonth = currentDate.month == messageDate.month;
    if (currentDate.day - messageDate.day == 0 && isSameMonth) {
      return DateFormat('HH:mm').format(messageDate).toString();
    } else if (currentDate.day - messageDate.day == 1 && isSameMonth) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yy').format(messageDate).toString();
    }
  }

  static int getDiffBetweenTwoTimesInSeconds(int messageTime) {
    final int messageTimeSeconds = messageTime;
    final int currentTimeSeconds = DateTime.now().millisecondsSinceEpoch;
    final int timesToLive = currentTimeSeconds - messageTimeSeconds;
    final int diffInSec = (timesToLive / 1000).truncate();
    return diffInSec;
  }

  static int getDiffBetweenTwoDatesInMinutes({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final int dateOneInSeconds = startDate.millisecondsSinceEpoch;
    final int dateTwoInSeconds = endDate.millisecondsSinceEpoch;

    final int timesToLive = dateTwoInSeconds - dateOneInSeconds;
    final int diffInSec = (timesToLive / 1000).truncate();
    final int minutes = Duration(seconds: diffInSec).inMinutes;
    return minutes;
  }

  static String getFilterFormattedDate(int timeInMillis) {
    final DateTime messageDate =
    DateTime.fromMillisecondsSinceEpoch(timeInMillis);

    return DateFormat('EEE MMM dd').format(messageDate).toString();
  }

  static String getTimeFromMilliSeconds(int timeInMillis) {
    final DateTime now = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    return DateFormat('HH:mm').format(now).toString();
  }

  static DateTime getTime(int timeInMillis) {
    final DateTime now = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    return now;
  }

  static DateTime getDateFromTimeStamp({required int milliSeconds}) {
    return DateTime.fromMillisecondsSinceEpoch(milliSeconds);
  }

  static int getCurrentDateTime() {
    final DateTime now = DateTime.now();
    return now.millisecondsSinceEpoch;
  }

}
