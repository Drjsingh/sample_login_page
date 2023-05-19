import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/common.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenWidth = 0;
  double screenHeight = 0;
  Future<bool> _isBack() {
    return Popup().ExitAlert(context);
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      screenWidth = MediaQuery.of(context).size.width / 2.5;
      screenHeight = MediaQuery.of(context).size.height / 1.5;
    } else {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height - 20;
    }
    return SafeArea(
      child: WillPopScope(
        onWillPop: _isBack,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.lighten),
              image: const AssetImage("asset/mobile.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 380),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.all(20),
                    width: screenWidth,
                    height: screenHeight,
                    decoration: BoxDecoration(
                        color: (defaultTargetPlatform == TargetPlatform.windows)
                            ? Color(0xfffffF6F6F6)
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Home Screen",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          "Welcome to the Home Screen of WingMan Web ",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
