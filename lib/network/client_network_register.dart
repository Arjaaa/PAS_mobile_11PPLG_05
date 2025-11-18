import 'dart:convert';
import 'package:http/http.dart' as http;

class ClientNetworkRegister {
  static const String baseUrl = "https://mediadwi.com/api/latihan";

  static Future<Map<String, dynamic>> postForm(String endpoint, Map<String, String> body) async {
    final url = Uri.parse("$baseUrl/$endpoint");
    final response = await http.post(url, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    }, body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception("Error ${response.statusCode}: ${response.body}");
  }

  static Future<Map<String, dynamic>> postJson(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl/$endpoint");
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception("Error ${response.statusCode}: ${response.body}");
  }

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse("$baseUrl/$endpoint");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception("Error ${response.statusCode}: ${response.body}");
  }
}