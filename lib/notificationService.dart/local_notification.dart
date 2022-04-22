

import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification/views/DemoScreen.dart';
import 'package:get/get.dart';

class LocalNotificationPlugin {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();



  static void initalize() {
    print("this is the starting of the initalize");
    // initializationSetting for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? id) async {
      print("on select notification");
      if (id!.isNotEmpty) {
        print("this is the id $id");
        Get.to(DemoScreen(id: id));
      }
    });
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    print("makinf the notification desgin");
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              'notificationApp', 'notificationChannel',
              importance: Importance.max, priority: Priority.high));
      await _notificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: message.data['_id']);
    } catch (e) {
      print("this is the error $e");
    }
  }
}
