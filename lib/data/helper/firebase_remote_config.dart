import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._internal();

  static final FirebaseRemoteConfigService _instance =
      FirebaseRemoteConfigService._internal();

  FirebaseRemoteConfig? _remoteConfig;

  factory FirebaseRemoteConfigService() {
    return _instance;
  }

  FirebaseRemoteConfig get remoteConfig {
    if (_remoteConfig == null) {
      throw Exception(
          "Firebase Remote Config not initialized. Call initialize() first.");
    }
    return _remoteConfig!;
  }

  Future<void> initialize() async {
    _remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await _remoteConfig!.setDefaults(<String, dynamic>{
        'discount': false,
      });

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 10),
      ));

      // Fetch and activate the latest values from Firebase Remote Config
      await _remoteConfig!.fetchAndActivate();

      if (kDebugMode) {
        print('Remote Config initialized and fetched');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize Firebase Remote Config: $e');
      }
      throw Exception("Failed to initialize Firebase Remote Config");
    }
  }
}
