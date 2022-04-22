
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:notification/notificationService.dart/local_notification.dart';
import 'package:notification/views/DemoScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // When app is closed
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DemoScreen(
                  id: message.data['_id'],
                ),
              ),
            );
          }
          LocalNotificationPlugin.createAndDisplayNotification(message);
        }print(" no Notification");
      },
    );


  // This is working fine
    // when app is in forground
    FirebaseMessaging.onMessage.listen((Message) {
      print("FirebaseMessaging.onMessaging.listen");
      if (Message != null) {
        print(Message.notification!.title);
        print(Message.notification!.body);
        print("message.data11 ${Message.data['_id']}");
        LocalNotificationPlugin.createAndDisplayNotification(Message);
      }
    });


  // When app is in the recent tab
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationPlugin.createAndDisplayNotification(message);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Firebase Notification App",style: TextStyle(color: Colors.black),),
        actions: [
        ],
      ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/firebase.png"),fit: BoxFit.fitWidth)),
        child: Center(
          
          child: Text('Push Notification'),
        ),
      ),
    );
  }
}
