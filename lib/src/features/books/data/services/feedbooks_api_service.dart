import 'package:dio/dio.dart';
import '../models/book_model.dart';

class FeedbooksApiService {
  final Dio _dio = Dio();
  
  Future<List<Book>> fetchBooks() async {
    try {
      // Full library of public domain classics
      return [
        // Fiction
        Book(
          id: '1',
          title: 'Pride and Prejudice',
          author: 'Jane Austen',
          coverUrl: 'https://www.gutenberg.org/cache/epub/1342/pg1342.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/1342.epub.images',
          description: 'A romantic novel of manners set in Georgian England.',
        ),
        Book(
          id: '2',
          title: 'Frankenstein',
          author: 'Mary Shelley',
          coverUrl: 'https://www.gutenberg.org/cache/epub/84/pg84.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/84.epub.images',
          description: 'The story of Victor Frankenstein and his creature.',
        ),
        Book(
          id: '3',
          title: 'The Great Gatsby',
          author: 'F. Scott Fitzgerald',
          coverUrl: 'https://www.gutenberg.org/cache/epub/64317/pg64317.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/64317.epub.images',
          description: 'A tale of the Jazz Age and the American Dream.',
        ),
        Book(
          id: '4',
          title: 'Moby Dick',
          author: 'Herman Melville',
          coverUrl: 'https://www.gutenberg.org/cache/epub/2701/pg2701.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/2701.epub.images',
          description: 'The quest of Captain Ahab to hunt the white whale.',
        ),
        Book(
          id: '5',
          title: 'Dracula',
          author: 'Bram Stoker',
          coverUrl: 'https://www.gutenberg.org/cache/epub/345/pg345.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/345.epub.images',
          description: 'The classic vampire tale that started them all.',
        ),
        Book(
          id: '6',
          title: 'Alice in Wonderland',
          author: 'Lewis Carroll',
          coverUrl: 'https://www.gutenberg.org/cache/epub/11/pg11.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/11.epub.images',
          description: 'A young girl falls down a rabbit hole into a fantasy world.',
        ),
        Book(
          id: '7',
          title: 'The Adventures of Sherlock Holmes',
          author: 'Arthur Conan Doyle',
          coverUrl: 'https://www.gutenberg.org/cache/epub/1661/pg1661.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/1661.epub.images',
          description: 'Collection of twelve detective stories.',
        ),
        Book(
          id: '8',
          title: 'Jane Eyre',
          author: 'Charlotte Brontë',
          coverUrl: 'https://www.gutenberg.org/cache/epub/1260/pg1260.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/1260.epub.images',
          description: 'The story of an orphaned girl who becomes a governess.',
        ),
        Book(
          id: '9',
          title: 'Wuthering Heights',
          author: 'Emily Brontë',
          coverUrl: 'https://www.gutenberg.org/cache/epub/768/pg768.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/768.epub.images',
          description: 'A tale of passion and revenge on the Yorkshire moors.',
        ),
        Book(
          id: '10',
          title: 'The Picture of Dorian Gray',
          author: 'Oscar Wilde',
          coverUrl: 'https://www.gutenberg.org/cache/epub/174/pg174.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/174.epub.images',
          description: 'A philosophical novel about beauty, morality, and hedonism.',
        ),
        Book(
          id: '11',
          title: 'Emma',
          author: 'Jane Austen',
          coverUrl: 'https://www.gutenberg.org/cache/epub/158/pg158.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/158.epub.images',
          description: 'A comedy about a matchmaking young woman.',
        ),
        Book(
          id: '12',
          title: 'The Count of Monte Cristo',
          author: 'Alexandre Dumas',
          coverUrl: 'https://www.gutenberg.org/cache/epub/1184/pg1184.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/1184.epub.images',
          description: 'A tale of revenge, hope, and justice.',
        ),
        Book(
          id: '13',
          title: 'A Tale of Two Cities',
          author: 'Charles Dickens',
          coverUrl: 'https://www.gutenberg.org/cache/epub/98/pg98.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/98.epub.images',
          description: 'Set during the French Revolution.',
        ),
        Book(
          id: '14',
          title: 'Great Expectations',
          author: 'Charles Dickens',
          coverUrl: 'https://www.gutenberg.org/cache/epub/1400/pg1400.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/1400.epub.images',
          description: 'The coming-of-age story of Pip.',
        ),
        Book(
          id: '15',
          title: 'The Adventures of Tom Sawyer',
          author: 'Mark Twain',
          coverUrl: 'https://www.gutenberg.org/cache/epub/74/pg74.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/74.epub.images',
          description: 'A boy growing up along the Mississippi River.',
        ),
        Book(
          id: '16',
          title: 'The Metamorphosis',
          author: 'Franz Kafka',
          coverUrl: 'https://www.gutenberg.org/cache/epub/5200/pg5200.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/5200.epub.images',
          description: 'A man wakes up transformed into a giant insect.',
        ),
        Book(
          id: '17',
          title: 'The Iliad',
          author: 'Homer',
          coverUrl: 'https://www.gutenberg.org/cache/epub/6130/pg6130.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/6130.epub.images',
          description: 'Ancient Greek epic poem about the Trojan War.',
        ),
        Book(
          id: '18',
          title: 'The Odyssey',
          author: 'Homer',
          coverUrl: 'https://www.gutenberg.org/cache/epub/1727/pg1727.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/1727.epub.images',
          description: 'The journey of Odysseus after the Trojan War.',
        ),
        Book(
          id: '19',
          title: 'Little Women',
          author: 'Louisa May Alcott',
          coverUrl: 'https://www.gutenberg.org/cache/epub/514/pg514.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/514.epub.images',
          description: 'The story of four sisters growing up during the Civil War.',
        ),
        Book(
          id: '20',
          title: 'The Scarlet Letter',
          author: 'Nathaniel Hawthorne',
          coverUrl: 'https://www.gutenberg.org/cache/epub/25344/pg25344.cover.medium.jpg',
          downloadUrl: 'https://www.gutenberg.org/ebooks/25344.epub.images',
          description: 'A story about sin, guilt, and redemption in Puritan New England.',
        ),
      ];
    } catch (e) {
      throw Exception('Failed to fetch books: $e');
    }
  }
}
