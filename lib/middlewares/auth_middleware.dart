import 'package:shelf/shelf.dart';

Middleware authMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      // Pega o token do cabeçalho da requisição
      final authHeader = request.headers['Authorization'] ?? request.headers['authorization'];

      // Verifica se o token é exatamente '123' ou 'Bearer 123' (como pede a atividade)
      if (authHeader == '123' || authHeader == 'Bearer 123') {
        // Se estiver correto, deixa a requisição passar
        return await innerHandler(request);
      }

      // Se o token estiver errado ou não existir, bloqueia e retorna erro 403
      return Response.forbidden('Acesso negado: Token ausente ou invalido.');
    };
  };
}