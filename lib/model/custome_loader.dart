import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:uiblock/uiblock.dart';

class CustomUIBlock {
  static void block(context) {
    UIBlock.block(context,
        imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        canDissmissOnBack: true,
        customLoaderChild: const Center(
            child: SizedBox(
                height: 60.0,
                width: 60.0,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xff8FC046)),
                    strokeWidth: 5.0))));
  }

  static void unblock(context) {
    UIBlock.unblock(context);
  }
}
