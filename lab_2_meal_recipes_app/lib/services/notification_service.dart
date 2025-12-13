import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidInit,
    );

    await _notifications.initialize(initSettings);
  }

  static Future<void> scheduleDailyRandomRecipe() async {
    const androidDetails = AndroidNotificationDetails(
      'daily_recipe_channel',
      'Daily Recipe Reminder',
      channelDescription: 'Daily reminder for random recipe',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    final now = DateTime.now();

    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      22,
      05,
    );

    final firstNotificationTime =
    scheduledTime.isAfter(now)
        ? scheduledTime
        : scheduledTime.add(const Duration(days: 1));

    await _notifications.zonedSchedule(
      0,
      ' Random Recipe of the Day',
      'Open the app and discover today’s recipe!',
      tz.TZDateTime.from(firstNotificationTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

}

