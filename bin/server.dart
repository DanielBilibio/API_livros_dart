import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import '../lib/middlewares/auth_middleware.dart';
import '../lib/routes/book_routes.dart';

void main() async {
  final bookRoutes = BookRoutes();

  // Aqui nós configuramos a "esteira" por onde a requisição vai passar:
  // 1. Passa pelo log (para vermos no terminal)
  // 2. Passa pelo nosso Middleware de Autenticação (A trava do token 123)
  // 3. Chega nas nossas Rotas (O CRUD do banco de dados)
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(authMiddleware()) 
      .addHandler(bookRoutes.router.call);

  // Define a porta onde a API vai rodar (padrão é 8080)
  final port = 8080;
  
  // Sobe o servidor
  final server = await io.serve(handler, InternetAddress.anyIPv4, port);
  print('✅ Servidor rodando com sucesso em http://localhost:${server.port}');
}