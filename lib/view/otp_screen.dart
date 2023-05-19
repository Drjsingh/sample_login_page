import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sample_login_n_profile/model/api.dart';
import 'package:sample_login_n_profile/view/homepage.dart';
import 'package:sample_login_n_profile/view/profile_screen.dart';

import '../model/custome_loader.dart';

class OtpScreen extends StatefulWidget {
  String request_id = '';
  String mobile = '';
  OtpScreen(this.request_id, this.mobile);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  double screenWidth = 0;
  double screenHeight = 0;
  String code = '';
  final apiservice = new ApiService();
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
                  decoration: BoxDecoration(
                      color: (defaultTargetPlatform == TargetPlatform.windows)
                          ? Color(0xfffffF6F6F6)
                          : Colors.transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  width: screenWidth,
                  height: screenHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: const Image(
                              image: AssetImage('asset/wmlogo.jpeg'),
                              height: 130,
                              width: 130,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10,
                            ),
                            child: Text(
                              "Enter OTP",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "OTP has been sent to ${widget.mobile} ",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 6,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            inactiveFillColor:
                                Color(0xffEEEEEE), // default show field color
                            inactiveColor:
                                Colors.white, // default show field border color
                            selectedColor:
                                Color(0xff8FC046), // focus border color
                            selectedFillColor:
                                Color(0xffffffff), // focus in bg color
                            activeFillColor:
                                Color(0xffEEEEEE), // after focus out bg color
                            activeColor: Color(
                                0xffEEEEEE), // after enter otp then border color
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldWidth: 50,
                            fieldHeight: 60,
                          ),
                          cursorColor: Colors.black,
                          //6animationDuration: const Duration(milliseconds: 100),
                          enableActiveFill: true,
                          keyboardType: TextInputType.number,
                          onCompleted: (pin) {
                            code = pin;
                          },
                          onChanged: (pin) {
                            code = pin;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: screenWidth! * 0.75,
                              height: (defaultTargetPlatform ==
                                      TargetPlatform.windows)
                                  ? 40
                                  : 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                  color: Colors.green,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: MaterialButton(
                                  onPressed: () async {
                                    if (code.length == 6) {
                                      CustomUIBlock.block(context);
                                      var response = await apiservice.verifyOtp(
                                          widget.request_id, code);
                                      if (response['status'] == true) {
                                        if (response['profile_exists'] ==
                                            false) {
                                          CustomUIBlock.unblock(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileScreen(
                                                        response['jwt'])),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()),
                                          );
                                        }
                                      } else {
                                        CustomUIBlock.unblock(context);
                                        final snackBar = SnackBar(
                                            content: Row(
                                              children: const [
                                                Flexible(
                                                  child: Text(
                                                    "Incorrect OTP",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            backgroundColor: Colors.red);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } else {
                                      final snackBar = SnackBar(
                                          content: Row(
                                            children: const [
                                              Flexible(
                                                child: Text(
                                                  "Invalid OTP",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          duration: const Duration(seconds: 3),
                                          backgroundColor: Colors.red);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: const Text(
                                    'Verify',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '<<-Retry',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
