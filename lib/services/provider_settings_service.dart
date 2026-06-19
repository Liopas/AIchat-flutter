import 'package:shared_preferences/shared_preferences.dart';

class ProviderSettingsService {
  static const _providerKey = 'provider';
  static const _apiKey = 'api_key';
  static const _baseUrl = 'base_url';

  Future<void> save({
    required String provider,
    required String apiKey,
    required String baseUrl,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_providerKey, provider);
    await prefs.setString(_apiKey, apiKey);
    await prefs.setString(_baseUrl, baseUrl);
  }

  Future<Map<String, String>> load() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'provider': prefs.getString(_providerKey) ?? 'OpenRouter',
      'apiKey': prefs.getString(_apiKey) ?? '',
      'baseUrl': prefs.getString(_baseUrl) ?? '',
    };
  }
}