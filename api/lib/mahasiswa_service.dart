import 'dart:convert';
import 'package:http/http.dart' as http;
import 'mahasiswa.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1/api_mahasiswa/index.php";

  static Future<List<Mahasiswa>> getData() async {
    final res = await http.get(Uri.parse(baseUrl));
    List data = jsonDecode(res.body);
    return data.map((e) => Mahasiswa.fromJson(e)).toList();
  }

  static Future createData(Mahasiswa mhs) async {
    await http.post(Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(mhs.toJson()));
  }

  static Future updateData(Mahasiswa mhs) async {
    await http.put(Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(mhs.toJson()));
  }

  static Future deleteData(int id) async {
    await http.delete(Uri.parse("$baseUrl?id=$id"));
  }
}
  