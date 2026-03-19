# 📚 API de Gestão de Livros (CRUD com Dart)

Este projeto consiste numa API RESTful simples desenvolvida exclusivamente em Dart. Implementa um CRUD completo para a entidade **Livros**, com persistência de dados em base de dados e proteção de rotas através de um middleware de autenticação.

## 👨‍💻 Autoria
* **Desenvolvido por:** Daniel Bilibio
* **RA:** 1131552

---

## 🚀 Tecnologias Utilizadas

* **Linguagem:** Dart
* **Servidor e Rotas:** `shelf` e `shelf_router`
* **Base de Dados:** SQLite (`sqlite3`)

---

## 🔒 Autenticação

A API possui uma camada de segurança via middleware. Todas as rotas estão protegidas e exigem um *token* de acesso no cabeçalho (*Header*) da requisição HTTP.

* **Chave (Key):** `Authorization`
* **Valor (Value):** `123` (ou `Bearer 123`)

*Nota: Requisições sem este cabeçalho ou com o token incorreto receberão o código de erro HTTP 403 (Acesso Negado).*

---

## ⚙️ Rotas da API (Endpoints)

Abaixo estão as operações disponíveis para gerir os livros:

| Método | Rota | Descrição |
| :--- | :--- | :--- |
| **POST** | `/livros` | Regista um novo livro na base de dados. |
| **GET** | `/livros` | Lista todos os livros guardados. |
| **GET** | `/livros/<id>` | Busca um livro específico através do seu ID. |
| **PUT** | `/livros/<id>` | Atualiza os dados (título e autor) de um livro existente. |
| **DELETE** | `/livros/<id>` | Elimina um livro da base de dados. |

### Exemplo de Corpo da Requisição (POST / PUT)
Para inserir ou atualizar um livro, deves enviar um JSON no corpo (*Body*) da requisição:
```json
{
  "title": "O Senhor dos Anéis",
  "author": "J.R.R. Tolkien"
}
