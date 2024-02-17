class Env {
  static Map<String, String> map = {
    'ENV': const String.fromEnvironment('ENV', defaultValue: "dev"),
    'BASE_URL': const String.fromEnvironment('BASE_URL', defaultValue: ""),
    'BASE_URL_SUFIXO':
        const String.fromEnvironment('BASE_URL_SUFIXO', defaultValue: ""),
  };

  static get(String key) => _load(map[key] ?? "");

  static String? _load(String? env) => env;
}
