import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../database/database_service.dart';

class BookRoutes {
  final DatabaseService _db = DatabaseService();

  Router get router {
    final router = Router();

    // GET /livros -> Listar todos os livros
    router.get('/livros', (Request req) {
      final books = _db.getAllBooks();
      return Response.ok(jsonEncode(books), headers: {'content-type': 'application/json'});
    });

    // GET /livros/:id -> Buscar um livro específico pelo ID
    router.get('/livros/<id>', (Request req, String id) {
      final book = _db.getBookById(int.parse(id));
      if (book == null) {
        return Response.notFound(jsonEncode({'erro': 'Livro nao encontrado'}), 
                                 headers: {'content-type': 'application/json'});
      }
      return Response.ok(jsonEncode(book), headers: {'content-type': 'application/json'});
    });

    // POST /livros -> Cadastrar um novo livro
    router.post('/livros', (Request req) async {
      final payload = await req.readAsString();
      final data = jsonDecode(payload);
      
      final id = _db.insertBook(data['title'], data['author']);
      
      return Response(201, 
        body: jsonEncode({'id': id, 'mensagem': 'Livro criado com sucesso!'}),
        headers: {'content-type': 'application/json'});
    });

    // PUT /livros/:id -> Atualizar um livro existente
    router.put('/livros/<id>', (Request req, String id) async {
      final payload = await req.readAsString();
      final data = jsonDecode(payload);
      
      _db.updateBook(int.parse(id), data['title'], data['author']);
      return Response.ok(jsonEncode({'mensagem': 'Livro atualizado com sucesso!'}),
                         headers: {'content-type': 'application/json'});
    });

    // DELETE /livros/:id -> Remover um livro
    router.delete('/livros/<id>', (Request req, String id) {
      _db.deleteBook(int.parse(id));
      return Response.ok(jsonEncode({'mensagem': 'Livro removido com sucesso!'}),
                         headers: {'content-type': 'application/json'});
    });

    return router;
  }
}