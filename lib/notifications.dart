/*This is not used yet. I'll do this later here is some code you need to add too main.dart in order to get it working. However, it's not yet ready and will give you errors/not even work at all.

    List<String> dateUnsplit = DateTime.now().toString().split(" ");
    String date = dateUnsplit[0];

    String reminder = date.toString() + " " + hours.toString() + ":" + minutes.toString();
    print(reminder);

*/


import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPlugin 
{
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationPlugin()
  {
    _initializeNotifications();
  }


  _initializeNotifications() async 
  {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettingsAndroid = new AndroidInitializationSettings('assets/zzz.png');
    final initializationSettingsIOS = new IOSInitializationSettings();
    final initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async
  {
    if (payload != null)
    {
      print('notification payload: ' + payload);
    }
  }

  Future<void> showAtTime(Time time) async
  {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails("channelId", "channelName", "channelDescription");
    final iOSPlatformChannelSecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSecifics);
    await _flutterLocalNotificationsPlugin.showDailyAtTime(0, "title", "body", time, platformChannelSpecifics);
  }

  Future<List<PendingNotificationRequest>> getScheduledNotifications() async
  {
    final pendingNotifications = await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  Future cancelNotification() async
  {
    await _flutterLocalNotificationsPlugin.cancel(0);
  }
}