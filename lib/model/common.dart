import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Popup {
  ExitAlert(BuildContext context) {
    bool isPortrait = false;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double width = MediaQuery.of(context).size.width;
    double containerWidth = width - 40;

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding:
                EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Container(
              width: containerWidth,
              // height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 20, right: 20, bottom: 30),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Do you want to Exit App?',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Spacer(),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            minWidth: containerWidth / 2.7,
                            height: 40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: const BorderSide(
                                  color: Color(0xFFE73E34), width: 2.0),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: MaterialButton(
                                onPressed: () {
                                  exit(0);
                                },
                                minWidth: containerWidth / 2.7,
                                height: 40,
                                color: const Color(0xFF8FC046),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
