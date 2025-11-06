import 'package:dio/dio.dart';

class GoogleBooksService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<Map<String, dynamic>> searchBooks(String query, {int startIndex = 0}) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'q': query,
          'startIndex': startIndex,
          'maxResults': 40,
          'printType': 'books',
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to search books: $e');
    }
  }

  Future<Map<String, dynamic>> getBookDetails(String bookId) async {
    try {
      final response = await _dio.get('$_baseUrl/$bookId');
      return response.data;
    } catch (e) {
      throw Exception('Failed to get book details: $e');
    }
  }

  Future<Map<String, dynamic>> getBooksbyCategory(String category) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'q': 'subject:$category',
          'maxResults': 20,
          'orderBy': 'relevance',
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get books by category: $e');
    }
  }
}
