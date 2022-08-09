import 'package:get_storage/get_storage.dart';

class PrefUtils {
  static PrefUtils? _shared;

  PrefUtils._();

  static PrefUtils get getInstance => _shared = _shared ?? PrefUtils._();

  final _box = GetStorage();

  final credential = GetStorage();

  String get accessToken => "accessToken";
  String get isUserLoginKey => "isUserLogin";
  String get userInfo => "userInfo";
  String get apiConfigKey => "apiConfig";
  String get ssidForWifi => "ssidForWifi";
  String get passwordForWifi => "passwordForWifi";

  apiConfig() {
    final apiConfig = readData(PrefUtils.getInstance.apiConfigKey);

    return apiConfig;
  }

  isUserLogin() {
    return readData(PrefUtils.getInstance.isUserLoginKey) ?? false;
  }

  writeData(String key, dynamic value) {
    _box.write(key, value);
  }

  readData(String key) {
    dynamic jsonData = _box.read(key);
    return jsonData;
  }

  void clearLocalStorage() {
    _box.erase();
  }
}
