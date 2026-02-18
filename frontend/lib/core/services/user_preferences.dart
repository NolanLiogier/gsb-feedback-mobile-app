import 'package:shared_preferences/shared_preferences.dart';

abstract final class UserPreferences {
  UserPreferences._();

  static const _keyUserId = 'userId';
  static const _keyUserCompanyId = 'userCompanyId';
  static const _keyUserFunctionId = 'userFunctionId';

  static Future<void> setUserSession({
    required int userId,
    required int userCompanyId,
    required int userFunctionId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, userId);
    await prefs.setInt(_keyUserCompanyId, userCompanyId);
    await prefs.setInt(_keyUserFunctionId, userFunctionId);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  static Future<int?> getUserCompanyId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserCompanyId);
  }

  static Future<int?> getUserFunctionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserFunctionId);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserCompanyId);
    await prefs.remove(_keyUserFunctionId);
  }
}
