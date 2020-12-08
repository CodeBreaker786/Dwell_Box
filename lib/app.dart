import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'apps.dart';
import 'models/notification.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  void initState() {
    // Future.delayed(
    //   Duration(seconds: 1),
    //   () {
    //     FirebaseCloudMessagagingWapper()
    //       ..init()
    //       ..delegate = this;
    //
    //     OneSignalWapper()..init();
    //   },
    // );

    super.initState();
  }

  _saveMessage(message) {
    FStoreNotification a = FStoreNotification.fromJsonFirebase(message);
    a.saveToLocal(
      message['notification'] != null
          ? message['notification']['tag']
          : message['data']['google.message_id'],
    );
  }

  @override
  onLaunch(Map<String, dynamic> message) {
    _saveMessage(message);
  }

  @override
  onMessage(Map<String, dynamic> message) {
    _saveMessage(message);
  }

  @override
  onResume(Map<String, dynamic> message) {
    _saveMessage(message);
  }

  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100) {
      return 1;
    } else {
      return 2;
    }
  };
  Map<int, Widget> op = {1: App(), 2: App()};

  /// Build the App Theme
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xFFfd9f00)));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: Apps()
        initialRoute: "/",
        routes: {
          '/': (context) => Apps(),
        },
      ),
    );
  }
}
