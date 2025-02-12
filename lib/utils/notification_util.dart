import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:demo_project/constants/color_constants.dart';
import 'package:flutter/material.dart';

class NotificationUtil {
  NotificationUtil._();

  factory NotificationUtil() => instance;
  static final NotificationUtil instance = NotificationUtil._();
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  Future<void> configuration() async {
    await awesomeNotifications.initialize(
      "",
      [
        NotificationChannel(
          channelKey: 'test',
          channelName: 'Test Notification',
          channelDescription: 'Test notification desc',
          defaultColor: ColorConstants.primaryColor,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
      debug: true,
    );
  }

  Future<bool> checkingPermission(BuildContext context) async {
    return await awesomeNotifications.isNotificationAllowed();
  }

  Future<bool> createLocalNotification() async {
    final bool notificationCreated =
        await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'test',
        title: "Oriflame Nepal",
        body: "Thank you for Contacting Us",
        displayOnBackground: true,
        payload: {'notification': "Thank you for Contacting Us"},
      ),
    );
    return notificationCreated;
  }
}
