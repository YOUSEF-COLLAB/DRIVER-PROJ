import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'http://192.168.1.13:5001/api'; // ⬅️ غيّره حسب IP جهازك

// ✅ تسجيل الدخول
Future<Map<String, dynamic>> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );
  return jsonDecode(response.body);
}

// ✅ تسجيل حساب جديد
Future<Map<String, dynamic>> signup(String name, String email, String password, String dob) async {
  final response = await http.post(
    Uri.parse('$baseUrl/signup'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name, 'email': email, 'password': password, 'dob': dob}),
  );
  return jsonDecode(response.body);
}

// ✅ استدعاء البروفايل المحمي
Future<Map<String, dynamic>> getProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse('$baseUrl/profile'),
    headers: {'Authorization': 'Bearer $token'},
  );
  return jsonDecode(response.body);
}

// ✅ إرسال صورة الوجه (base64) للتصنيف
Future<Map<String, dynamic>> classifyFace(String base64Image) async {
  final response = await http.post(
    Uri.parse('$baseUrl/classify-face'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'image': base64Image}),
  );
  return jsonDecode(response.body);
}

// ✅ تخزين التوكن بعد تسجيل الدخول
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

// ✅ حذف التوكن عند تسجيل الخروج
Future<void> clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}
