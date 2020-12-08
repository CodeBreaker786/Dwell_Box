import 'package:dwel_lbox/screens/settings/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class MyFab extends StatefulWidget {
  @override
  MyFabState createState() => MyFabState();
}

class MyFabState extends State<MyFab> with TickerProviderStateMixin {
  ScrollController scrollController;
  bool dialVisible = true;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  Widget buildBody() {
    return ListView.builder(
      controller: scrollController,
      itemCount: 30,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      closeManually: true,
      backgroundColor: Color(0xFFda8a15),
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
            child: Icon(Icons.notifications, color: Colors.white),
            backgroundColor: Color(0xFFda8a15),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            }),
        SpeedDialChild(
            child: Icon(Icons.chat, color: Colors.white),
            backgroundColor: Color(0xFFda8a15),
            onTap: () {
              _onLaunch();
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSpeedDial();
  }

  _onLaunch() async {
    const url =
        'https://stardust.humandoll.co.uk/livechat/php/app.php?widget-mobile';
    if (await canLaunch(url)) {
      await _openChat(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openChat(String url) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => WebviewScaffold(
          withJavascript: true,
          appCacheEnabled: true,
          resizeToAvoidBottomInset: true,
          url: url,
          appBar: AppBar(
            backgroundColor: Color(0xFFfd9f00),
            title: Text("Chat"),
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            elevation: 0.0,
          ),
          withZoom: true,
          withLocalStorage: true,
          hidden: true,
          initialChild: Container(child: kLoadingWidget(context)),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  Widget kLoadingWidget(context) => Center(
        child: SpinKitDualRing(
          color: Color(0xFFfd9f00),
          size: 30.0,
        ),
      );
}
