import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static SecureStorage instance = SecureStorage();
  SecureStorage();

  String highestScore = "0";

  final _storage = const FlutterSecureStorage();
  final String highestScoreKey = "highestScore";

  Future<void> storeHighScore(String currentScore) async {
    highestScore = currentScore;
    await _storage.write(key: highestScoreKey, value: currentScore);
  }

  Future<String> readFromStorage() async {
    String authorizationToken =
        await _storage.read(key: highestScoreKey) ?? "0";
    return authorizationToken;
  }

  Future<String> checkUserHighScore() async {
    String tempAuthToken = await readFromStorage();
    highestScore = tempAuthToken;

    return highestScore;
  }

  Future deleteStorage() async {
    await _storage.deleteAll();
  }
}
