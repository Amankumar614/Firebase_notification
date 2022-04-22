import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification/notificationService.dart/local_notification.dart';

import 'views/Homepage.dart';
import 'package:get/get.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationPlugin.initalize();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Notification",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
Future<void>backgroundHandler(RemoteMessage message)async{
  print(message.data.toString());
  print(message.notification!.title);
}