import 'dart:convert';

import 'package:frontend/core/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class LoginResult {
  const LoginResult({required this.statusCode, this.body});

  final int statusCode;
  final Map<String, dynamic>? body;
}

class VisitsResult {
  const VisitsResult({required this.statusCode, this.body});

  final int statusCode;
  final Map<String, dynamic>? body;
}

abstract final class ApiService {
  ApiService._();

  static Future<LoginResult> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('${AppConstants.apiBaseUrl}/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    Map<String, dynamic>? decoded;
    final responseBody = response.body;
    if (responseBody.isNotEmpty) {
      try {
        decoded = jsonDecode(responseBody) as Map<String, dynamic>?;
      } catch (exception) {
        decoded = null;
      }
    }
    return LoginResult(statusCode: response.statusCode, body: decoded);
  }

  static Future<VisitsResult> getVisitsByUserId(int userId) async {
    final uri = Uri.parse('${AppConstants.apiBaseUrl}/visits/getVisitsByUserId');
    final request = http.Request('GET', uri);
    request.body = jsonEncode({'userId': userId});
    request.headers['Content-Type'] = 'application/json';
    final streamedResponse = await http.Client().send(request);
    final response = await http.Response.fromStream(streamedResponse);
    Map<String, dynamic>? decoded;
    final responseBody = response.body;
    if (responseBody.isNotEmpty) {
      try {
        decoded = jsonDecode(responseBody) as Map<String, dynamic>?;
      } catch (exception) {
        decoded = null;
      }
    }
    return VisitsResult(statusCode: response.statusCode, body: decoded);
  }

  static Future<VisitsResult> getVisitDatasById(int visitId) async {
    final uri = Uri.parse(
        '${AppConstants.apiBaseUrl}/visits/getVisitDatasById');
    final request = http.Request('GET', uri);
    request.body = jsonEncode({'visitId': visitId});
    request.headers['Content-Type'] = 'application/json';
    final streamedResponse = await http.Client().send(request);
    final response = await http.Response.fromStream(streamedResponse);
    Map<String, dynamic>? decoded;
    final responseBody = response.body;
    if (responseBody.isNotEmpty) {
      try {
        decoded = jsonDecode(responseBody) as Map<String, dynamic>?;
      } catch (exception) {
        decoded = null;
      }
    }
    return VisitsResult(statusCode: response.statusCode, body: decoded);
  }
}
