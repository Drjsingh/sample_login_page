import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future Post(url, data, [token]) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {
          'Content-type': 'application/json',
          'Accept': '*/*',
          'Token': token ?? '',
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      print("Error Occured in Main Post Method");
      print(e);
    }
  }

  Future sendOtp(mobile) async {
    dynamic url = "https://test-otp-api.7474224.xyz/sendotp.php";
    dynamic data = jsonEncode(<dynamic, dynamic>{
      "mobile": mobile,
    });
    Map<dynamic, dynamic> response = await Post(url, data);
    return response;
  }

  Future verifyOtp(request_id, code) async {
    dynamic url = "https://test-otp-api.7474224.xyz/verifyotp.php";
    dynamic data = jsonEncode(<dynamic, dynamic>{
      "request_id": request_id,
      "code": code,
    });
    Map<dynamic, dynamic> response = await Post(url, data);
    return response;
  }

  Future submitProfile(email, name, token) async {
    dynamic url = "https://test-otp-api.7474224.xyz/profilesubmit.php";
    dynamic data = jsonEncode(<dynamic, dynamic>{
      "name": name,
      "email": email,
    });
    Map<dynamic, dynamic> response = await Post(url, data, token);
    return response;
  }
}
