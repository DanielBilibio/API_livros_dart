import 'package:sqlite3/sqlite3.dart';

class DatabaseService {
  late Database _db;

  DatabaseService() {
    // Inicializa o banco (cria o arquivo books.db na raiz do projeto)
    _db = sqlite3.open('books.db');
    _db.execute('''
      CREATE TABLE IF NOT EXISTS books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        author TEXT NOT NULL
      )
    ''');
  }

  // CREATE
  int insertBook(String title, String author) {
    _db.execute('INSERT INTO books (title, author) VALUES (?, ?)', [title, author]);
    return _db.lastInsertRowId;
  }

  // READ ALL
  List<Map<String, dynamic>> getAllBooks() {
    final result = _db.select('SELECT * FROM books');
    return result.map((row) => {
      'id': row['id'], 
      'title': row['title'], 
      'author': row['author']
    }).toList();
  }

  // READ BY ID
  Map<String, dynamic>? getBookById(int id) {
    final result = _db.select('SELECT * FROM books WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    final row = result.first;
    return {'id': row['id'], 'title': row['title'], 'author': row['author']};
  }

  // UPDATE
  void updateBook(int id, String title, String author) {
    _db.execute('UPDATE books SET title = ?, author = ? WHERE id = ?', [title, author, id]);
  }

  // DELETE
  void deleteBook(int id) {
    _db.execute('DELETE FROM books WHERE id = ?', [id]);
  }
}