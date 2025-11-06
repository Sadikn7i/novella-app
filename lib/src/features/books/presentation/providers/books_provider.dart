import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/book_model.dart';
import '../../data/repositories/books_repository.dart';

final booksRepositoryProvider = Provider((ref) => BooksRepository());

enum ViewMode { grid, list }

final viewModeProvider = StateProvider<ViewMode>((ref) => ViewMode.grid);

final selectedCategoryProvider = StateProvider<String>((ref) => 'bestseller');

final currentBooksProvider = FutureProvider<List<Book>>((ref) async {
  final category = ref.watch(selectedCategoryProvider);
  final repository = ref.watch(booksRepositoryProvider);
  return await repository.getBooksByCategory(category);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchBooksProvider = FutureProvider<List<Book>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  final repository = ref.watch(booksRepositoryProvider);
  return await repository.searchBooks(query);
});
