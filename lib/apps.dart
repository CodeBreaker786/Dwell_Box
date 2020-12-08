import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'common/config/general.dart';
import 'screens/settings/notification.dart';

class Apps extends StatefulWidget {
  @override
  _AppsState createState() => _AppsState();
}

class _AppsState extends State<Apps> with TickerProviderStateMixin {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  bool canGoBack = false;
  bool isLoading = true;
//////////////////////////////////////////////////////

  /////////////////////////////////////////
  @override
  void initState() {
    // Future.delayed(
    //   Duration(seconds: 1),
    //   () {
    //     OneSignalWapper()..init();
    //     print("[AppState] register modules .. DONE");
    //   },
    // );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String urrl =
    //     "https://api.whatsapp.com/send?phone=$phoneNumber&text=&source=&data=&app_absent=";
    void _go(BuildContext context) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationScreen()));
    }

    var xyz = MediaQuery.of(context).size.width * 0.83333333333;
    var listOfImages = ["assets/images/1.jpeg", "assets/images/2.jpg"];
    var _random = Random();
    var imageToShow = listOfImages[_random.nextInt(listOfImages.length)];
    final snackBar1 = SnackBar(
        content: Text('No Internet Connection. Please try again later'));
    final snackBar2 = SnackBar(content: Text('Loading...'));
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    double ax = MediaQuery.of(context).size.width * 0.6;
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == ConnectivityResult.none) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leading: Image.asset("assets/images/dwellboxlogo.png"),
            ),
            // bottomNavigationBar: BottomNavigationBar(
            //     type: BottomNavigationBarType.fixed,
            //     items: [
            //       BottomNavigationBarItem(
            //           icon: Image.asset(
            //             "assets/images/5.png",
            //             filterQuality: FilterQuality.high,
            //             width: 20,
            //           ),
            //           title: Text(
            //             "Menu",
            //             style: TextStyle(color: Colors.black),
            //           )),
            //       BottomNavigationBarItem(
            //           icon: Icon(
            //             Icons.ac_unit,
            //             color: Colors.black,
            //           ),
            //           title: Text("Categories",
            //               style: TextStyle(color: Colors.black))),
            //       BottomNavigationBarItem(
            //           icon: Image.asset(
            //             "assets/images/6.png",
            //             filterQuality: FilterQuality.high,
            //             width: 24,
            //           ),
            //           title: Text(
            //             "Purchases",
            //             style: TextStyle(color: Colors.black),
            //           )),
            //       BottomNavigationBarItem(
            //           icon: Icon(
            //             Icons.ac_unit,
            //             color: Colors.black,
            //           ),
            //           title:
            //               Text("Deals", style: TextStyle(color: Colors.black)))
            //     ]),
            // appBar: AppBar(
            //   leading: Container(),
            //   backgroundColor: Color(0xFF022335),
            //   title: Image.asset(
            //     "assets/images/logo.jpg",
            //     width: 100,
            //     filterQuality: FilterQuality.high,
            //   ),
            //   actions: [
            //     Icon(Icons.trip_origin),
            //     SizedBox(
            //       width: 6,
            //     ),
            //     Icon(Icons.shopping_cart),
            //     SizedBox(
            //       width: 3,
            //     ),
            //   ],
            // ),
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    // Container(
                    //   height: 147,
                    //   color: Color(0xFF022335),
                    //   child: Column(
                    //     children: [
                    //       SizedBox(height: 20),
                    //       Container(
                    //         height: 40,
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(4.0),
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Image.asset(
                    //                 "assets/images/logo.jpg",
                    //                 width: 150,
                    //                 filterQuality: FilterQuality.high,
                    //               ),
                    //               // Row(
                    //               //   children: [
                    //               //     Image.asset(
                    //               //       "assets/images/3.png",
                    //               //       filterQuality: FilterQuality.high,
                    //               //       width: 28,
                    //               //     ),
                    //               //     // Icon(
                    //               //     //   Icons.shopping_cart,
                    //               //     //   color: Colors.white,
                    //               //     //   size: 28,
                    //               //     // ),
                    //               //     SizedBox(
                    //               //       width: 20,
                    //               //     ),
                    //               //     Image.asset(
                    //               //       "assets/images/4.png",
                    //               //       filterQuality: FilterQuality.high,
                    //               //       width: 28,
                    //               //     ),
                    //               //     // Icon(
                    //               //     //   Icons.person,
                    //               //     //   color: Colors.white,
                    //               //     //   size: 28,
                    //               //     // ),
                    //               //     SizedBox(
                    //               //       width: 5,
                    //               //     ),
                    //               //   ],
                    //               // )
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(16.0),
                    //         child: Container(
                    //             height: 50,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.white,
                    //                 borderRadius: BorderRadius.circular(1.0)),
                    //             child: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.all(4.0),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(8.0),
                    //                         child: Text("Search something...",
                    //                             textAlign: TextAlign.start,
                    //                             style: TextStyle(
                    //                                 fontSize: 16,
                    //                                 color: Colors.blueGrey)),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   width: 35,
                    //                   color: Colors.white,
                    //                   child: Icon(Icons.search,
                    //                       size: 18, color: Colors.black),
                    //                 )

                    //                 // Container(
                    //                 //   child: ListView.builder(
                    //                 //     scrollDirection: Axis.horizontal,
                    //                 //       itemCount:
                    //                 //           CategoryItems.loadCategoryItem()
                    //                 //               .length,
                    //                 //       itemBuilder: (BuildContext context, int index){
                    //                 //         return Container();
                    //                 //       }),
                    //                 // )
                    //               ],
                    //             )),
                    //       ),
                    //       SizedBox(
                    //         height: 5,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Center(child: Image.asset(imageToShow.toString())),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "OOPS!",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "NO INTERNET",
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                            Text("Please check your network connection."),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RaisedButton(
                                onPressed: () {
                                  if (!snapshot.hasData ||
                                      snapshot.data ==
                                          ConnectivityResult.none) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(snackBar1);
                                  } else {
                                    _scaffoldKey.currentState
                                        .showSnackBar(snackBar2);
                                  }
                                },
                                child: Container(
                                    width: double.infinity,
                                    child: Center(child: Text("Try Again"))),
                                disabledColor: Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.grey),
            title: appName,
            home: Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  child: Icon(Icons.arrow_back),
                  onTap: () {
                    webView.goBack();
                  },
                ),
                title: Row(
                  children: [
                    Container(
                      height: 30,
                      child: Image.asset(
                        'assets/images/dwellboxlogo.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Dwell Box',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              body: Stack(
                children: [
                  SafeArea(
                    child: Container(
                      child: InAppWebView(
                        initialUrl: finalURL,
                        initialHeaders: {},
                        initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true,
                        )),
                        onWebViewCreated: (InAppWebViewController controller) {
                          webView = controller;
                        },
                        onLoadStart: (InAppWebViewController controller,
                            String url) async {
                          setState(() {
                            this.url = url;
                          });
                        },
                        onLoadStop: (InAppWebViewController controller,
                            String url) async {
                          setState(() {
                            this.url = url;
                            isLoading = false;
                          });
                        },
                        onProgressChanged:
                            (InAppWebViewController controller, int progress) {
                          setState(() {
                            isLoading = true;
                            this.progress = progress / 100;
                          });
                        },
                      ),
                    ),
                  ),
                  isLoading == true
                      ? SpinKitSquareCircle(
                          color: Color(0xFF022335),
                          size: 50.0,
                          controller: AnimationController(
                              vsync: this,
                              duration: const Duration(milliseconds: 1200)),
                        )
                      : Stack()
                ],
              ),
              // floatingActionButton: Padding(
              //   padding: const EdgeInsets.only(bottom: 85),
              //   child: MyFab(),
              // ),
            ),
          );
        }
      },
    );
  }

  swiperDown() {
    if (webView != null) {
      webView.reload();
    }
  }
}

// class UnicornDialer extends StatelessWidget {
//   const UnicornDialer({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return UnicornDialer(
//       parentButton: Icon(Icons.add),
//       parentButtonBackground: Colors.grey,
//       finalButtonIcon: Icon(Icons.close),
//       childButtons: [
//         UnicornButton(
//           currentButton: FloatingActionButton(
//             child: Icon(
//               Icons.call,
//               size: 18,
//             ),
//             backgroundColor: Colors.grey,
//             mini: true,
//             onPressed: () {},
//           ),
//         ),
//         UnicornButton(
//             currentButton: FloatingActionButton(
//           child: Icon(Icons.notification_important, size: 18),
//           backgroundColor: Colors.grey,
//           mini: true,
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => NotificationScreen()));
//           },
//         ))
//       ],
//     );
//   }
// }

// class CustomText extends StatelessWidget {
//   final String text;
//   final double fontSize;
//   const CustomText({
//     this.text,
//     this.fontSize,
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           text,
//           style: TextStyle(fontSize: 18, color: Colors.white),
//         ),
//         SizedBox(
//           width: 30,
//         ),
//       ],
//     );
//   }
// }

// // _launchURL(String urrl) async {
// //   if (await canLaunch(urrl)) {
// //     await launch(urrl);
// //   } else {
// //     throw 'Could not launch $urrl';
// //   }
// // }
