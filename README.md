discoverydoc
============

Generate markdown document from discovery file.

From following YAML Dicovery file,

```yaml
service:
  name: BookService
  id: com.example.book_service
  base_url: http://example.com/book_service/api

endpoint:
  ListBook:
    path: GET /books
    response: [Book]
  GetBook:
    path: GET /books/{id}
    response: Book
  PostBook:
    path: POST /books
    body: Book
    response: Book
  PatchBook:
    path: PATCH /books/{id}
    body: Book
    response: Book
  SearchBook:
    path: GET /books/search
    params:
      query: String
    response: [Book]

entity:
  Book:
    title: String
    author_name: String
    published_at: Date

error:
  id: String
  message: String
  url: String
```

Following markdown documentation is generated.

---

## BookService Service 

### Base URL 

http://example.com/book_service/api

## Endpoint

### `GET /books` (ListBook) 

#### Response 

[Array<Book>](#book)

### `GET /books/{id}` (GetBook) 

#### Response 

[Book](#book)

### `POST /books` (PostBook) 

#### Response 

[Book](#book)

### `PATCH /books/{id}` (PatchBook) 

#### Response 

[Book](#book)

### `GET /books/search` (SearchBook) 

#### Parameters 

|Field|Type|
|-----|----|
|query|`String`|

#### Response 

[Array<Book>](#book)

## Entity

### Book 

|Field|Type|
|-----|----|
|title|`String`|
|author_name|`String`|
|published_at|`Date`|
