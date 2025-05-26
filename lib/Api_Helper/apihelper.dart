import 'dart:convert';

import 'package:http/http.dart' as http;

class Api_Helper {
  Future<dynamic> getApi({required String url}) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
