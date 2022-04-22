import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
    // when app is closed
    // FirebaseMessaging.instance.getInitialMessage().then((Message) {
    //   // print("FirebaseMessaging.instance.getInitialMessage");
    //   if (Message!= null) {
    //     print("new notification");
    //     if(Message.data['_id']){
    //       Navigator.push(context,MaterialPageRoute(builder: ((context) => DemoScreen(id: Message.data['_id']))));
    //     }
        
    //   }
    // });

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

    // Our app in the background state




    // FirebaseMessaging.onMessageOpenedApp.listen((Message) {
    //   print("FirebaseMessaging.onMessageOpenedApp.listen");
    //   if (Message.notification != null) {
    //     print(Message.notification!.title);
    //     print(Message.notification!.body);
    //     print("message.data22 ${Message.data['_id']}");
    //     //  LocalNotificationPlugin.createAndDisplayNotification(Message);
    //   }
    // });



    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          // LocalNotificationPlugin.createAndDisplayNotification(message);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification App"),
        actions: [
        ],
      ),
      body: Center(
        child: Text('Push Notification'),
      ),
    );
  }
}
