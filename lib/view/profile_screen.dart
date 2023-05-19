import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_login_n_profile/model/api.dart';

import '../model/common.dart';
import '../model/custome_loader.dart';
import 'homepage.dart';

class ProfileScreen extends StatefulWidget {
  var token;
  ProfileScreen(this.token);
  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _emailctrl = TextEditingController();
  final _namectrl = TextEditingController();
  final apiservice = new ApiService();
  double screenWidth = 0;
  double screenHeight = 0;

  bool isEmail(String input) => EmailValidator.validate(input);
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: (defaultTargetPlatform ==
                                    TargetPlatform.windows)
                                ? const EdgeInsets.only(left: 55, top: 8.0)
                                : const EdgeInsets.only(top: 30.0, left: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Welcome",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "Looks like you are new here. Tell us a bit about yourself.",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      width: screenWidth! * 0.75,
                                      child: TextFormField(
                                        controller: _namectrl,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        inputFormatters: [
                                          NoLeadingSpaceFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                            hintText: "Enter Name",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              borderSide: const BorderSide(
                                                width: 5,
                                              ),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.person)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please Enter Name";
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 20),
                                      width: screenWidth! * 0.75,
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: _emailctrl,
                                        decoration: InputDecoration(
                                            hintText: "Enter Email",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              borderSide: const BorderSide(
                                                width: 5,
                                              ),
                                            ),
                                            prefixIcon: Icon(Icons.email)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please Enter emailID";
                                          }
                                          if (!isEmail(value)) {
                                            return "Enter valid Email";
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: screenWidth! * 0.7,
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
                                              await apiservice.submitProfile(
                                                  _emailctrl.text,
                                                  _namectrl.text,
                                                  widget.token);
                                          if (response['status'] == true) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()),
                                            );
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'Submit',
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
                ),
              )),
        ),
      ),
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}
