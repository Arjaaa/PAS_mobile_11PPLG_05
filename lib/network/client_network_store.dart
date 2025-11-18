import 'package:http/http.dart' as http;

class ClientNetworkStore {
  // sesuaikan baseUrl kalau perlu
  static const String baseUrl = 'https://fakestoreapi.com';

  static Future<String> get(String path) async {
    final uri = Uri.parse('$baseUrl$path');
    final resp = await http.get(uri).timeout(const Duration(seconds: 15));
    if (resp.statusCode == 200) {
      return resp.body;
    }
    throw Exception('HTTP ${resp.statusCode}: ${resp.reasonPhrase}\n${resp.body}');
  }
}