import 'dart:convert';
import 'package:http/http.dart' as http;

class ClientNetworkLogin {
  static const String baseUrl = "https://mediadwi.com/api/latihan";

  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl/$endpoint");

    final response = await http.post(
      url,
      body: body, 
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error ${response.statusCode}: ${response.body}");
    }
  }
}
