import '../models/book_model.dart';
import '../services/google_books_service.dart';

class BooksRepository {
  final GoogleBooksService _apiService = GoogleBooksService();

  Future<List<Book>> searchBooks(String query, {int startIndex = 0}) async {
    final data = await _apiService.searchBooks(query, startIndex: startIndex);
    final items = data['items'] as List<dynamic>? ?? [];
    return items.map((json) => Book.fromGoogleBooks(json)).toList();
  }

  Future<Book> getBookDetails(String bookId) async {
    final data = await _apiService.getBookDetails(bookId);
    return Book.fromGoogleBooks(data);
  }

  Future<List<Book>> getBooksByCategory(String category) async {
    final data = await _apiService.getBooksbyCategory(category);
    final items = data['items'] as List<dynamic>? ?? [];
    return items.map((json) => Book.fromGoogleBooks(json)).toList();
  }

  Future<List<Book>> getFeaturedBooks() async {
    return await searchBooks('bestseller');
  }
}
