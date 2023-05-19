import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sample_login_n_profile/view/otp_screen.dart';

import '../model/api.dart';
import '../model/common.dart';
import '../model/custome_loader.dart';

class Login_page extends StatefulWidget {
  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _mobilectrl = TextEditingController();
  final apiservice = new ApiService();
  double? screenWidth;
  double? screenHeight;
  String mobile = '';
  String stdcodemobile = '';
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          children: [
                            Padding(
                              padding: (defaultTargetPlatform ==
                                      TargetPlatform.windows)
                                  ? const EdgeInsets.only(top: 10.0, left: 35)
                                  : const EdgeInsets.only(top: 10.0, left: 15),
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Form(
                          key: _formkey,
                          child: Container(
                            padding: EdgeInsets.only(top: 20),
                            width: screenWidth! * 0.75,
                            child: IntlPhoneField(
                              flagsButtonPadding: const EdgeInsets.all(8),
                              dropdownIconPosition: IconPosition.trailing,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    width: 5,
                                  ),
                                ),
                              ),
                              initialCountryCode: 'IN',
                              onChanged: (phone) {
                                mobile = phone.number;
                                stdcodemobile = phone.completeNumber;
                              },
                            ),
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
                                      if (_formkey.currentState!.validate()) {
                                        CustomUIBlock.block(context);
                                        var response =
                                            await apiservice.sendOtp(mobile);
                                        if (response['status'] == true) {
                                          CustomUIBlock.unblock(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OtpScreen(
                                                    response['request_id'],
                                                    stdcodemobile)),
                                          );
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),
                            ],
                          ),
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
