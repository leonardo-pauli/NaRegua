class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Erro no servidor']);

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Erro no cache']);

  @override
  String toString() => 'CacheException: $message';
}
