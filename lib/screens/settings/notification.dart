import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import '../../common/config/general.dart';
import 'package:localstorage/localstorage.dart';
import '../../models/notification.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}


class _NotificationScreenState extends State<NotificationScreen> {
  final LocalStorage storage = LocalStorage('fstore');
  List<FStoreNotification> _data;
  String hourAgo(Object hour) {
    return "$hour hours ago ";
  }

  String dayAgo(Object day) {
    return "$day days ago ";
  }

  String mintAgo(Object mint) {
    return "$mint minutes ago ";
  }

  String secondAgo(Object sec) {
    return "$sec seconds ago ";
  }
 bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.pop(context); // Do some stuff.
    return true;
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          "My Notifications",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: themeMainColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        initialData: false,
        future: storage.ready,
        builder: (BuildContext context, snapshot) {
          if (snapshot?.data == true) {
            _data = parseFromListJson(storage.getItem('notifications') as List);
            return _renderBody();
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                  child: Text(
                "Loading",
                style: TextStyle(color: themeMainColor),
              )),
            );
          }
        },
      ),
    );
  }

  Widget _renderBody() {
    if (_data == null || _data != null && _data.isEmpty) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text("No Notification found!!"),
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          if (_data[index].date == null) {
            return Container();
          }
          return Padding(
            child: Dismissible(
              key: Key(_data[index].date),
              onDismissed: (direction) {
                removeItem(index);
              },
              background: Container(color: Colors.redAccent),
              child: Card(
                child: ListTile(
                  onTap: () {
                    _showAlert(context, _data[index], index);
                  },
                  title: Text(
                    _data[index].title,
                    style: TextStyle(
                        color: themeMainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Padding(
                        child: Text(
                          _data[index].body,
                          maxLines: 2,
                          style: TextStyle(
                            color: themeMainColor.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                      ),
                      Text(
                        getTime(
                          _data[index].date,
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: themeMainColor.withOpacity(0.5),
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  leading: Icon(
                    Icons.notifications_none,
                    size: 30,
                    color: _data[index].seen ? Colors.grey : themeMainColor,
                  ),
                  isThreeLine: true,
                ),
              ),
            ),
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          );
        },
      ),
    );
  }

  String getTime(String time) {
    var now = DateTime.now();
    var date = DateTime.parse(time);
    if (now.difference(date).inDays > 0) {
      return dayAgo(now.difference(date).inDays.toString());
    }
    if (now.difference(date).inHours > 0) {
      return hourAgo(now.difference(date).inHours.toString());
    }
    if (now.difference(date).inMinutes > 0) {
      return mintAgo(now.difference(date).inMinutes.toString());
    }
    return secondAgo(now.difference(date).inSeconds.toString());
  }

  Future<void> removeItem(int index) async {
    try {
      final ready = await storage.ready;
      if (ready) {
        var list = storage.getItem('notifications');
        list ??= [];
        list.removeAt(index);
        await storage.setItem('notifications', list);
        setState(() {
          _data = list;
        });
      }
    } catch (err) {
//      print(err);
    }
  }

  Future<void> _showAlert(
      BuildContext context, FStoreNotification data, int index) async {
    await data.updateSeen(index);
    try {
      final ready = await storage.ready;
      if (ready) {
        var list = storage.getItem('notifications');
        list ??= [];
        setState(() {
          _data = list;
        });
      }
    } catch (err) {
//      print(err);
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Container(
          child: Icon(
            Icons.notifications_none,
            color: themeMainColor,
            size: 40,
          ),
          alignment: Alignment.topCenter,
        ),
        content: Container(
            height: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: <Widget>[
                Text(
                  data.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: themeMainColor),
                ),
                SizedBox(height: 20.0),
                Text(
                  data.body,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, color: themeMainColor),
                )
              ],
            )),
      ),
    );
  }
}

List<FStoreNotification> parseFromListJson(List listNotify) {
  return listNotify
      ?.map((item) => item == null
          ? null
          : FStoreNotification.fromLocalStorage(
              convert.jsonDecode(item) as Map<String, dynamic>))
      ?.toList();
}
