class Env {
  static Map<String, String> map = {
    'ENV': const String.fromEnvironment('ENV', defaultValue: "local"),
    'ENV_LAUNCH': const String.fromEnvironment('ENV_LAUNCH', defaultValue: ""),
  };

  static get(String key) => _load(map[key]);

  static String? _load(String? env) => env;
}
