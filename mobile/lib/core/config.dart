class Config {
  /// API configuration must be supplied at build time. Secrets belong on the
  /// proxy, never in a mobile-app asset.
  static String get apiKey {
    return const String.fromEnvironment('API_KEY');
  }
}
