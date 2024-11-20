import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';

class UtilFunctions{
  tz.TZDateTime nextInstanceOfTime(DateTime time){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = now.add(const Duration(seconds: 5));
    return scheduledDate;
  }


  // Select random index from a list
 int randomIndex(List list){
    return Random().nextInt(list.length);
  }
}


// tz.TZDateTime nextInstanceOfTime(DateTime time, Day day){
//   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//   tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute);
//   if(scheduledDate.isBefore(now)){
//     scheduledDate = scheduledDate.add(const Duration(seconds: 5));
//   }
//   return scheduledDate;
// }