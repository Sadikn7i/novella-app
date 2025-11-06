class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String? coverUrl;
  final String? thumbnail;
  final String? description;
  final String? publisher;
  final String? publishedDate;
  final int? pageCount;
  final List<String>? categories;
  final double? rating;
  final int? ratingsCount;
  final String? language;
  final String? previewLink;
  final String? infoLink;
  final bool? isEbook;
  final double? price;
  final String? currencyCode;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    this.coverUrl,
    this.thumbnail,
    this.description,
    this.publisher,
    this.publishedDate,
    this.pageCount,
    this.categories,
    this.rating,
    this.ratingsCount,
    this.language,
    this.previewLink,
    this.infoLink,
    this.isEbook,
    this.price,
    this.currencyCode,
  });

  factory Book.fromGoogleBooks(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final saleInfo = json['saleInfo'] ?? {};
    final imageLinks = volumeInfo['imageLinks'] ?? {};

    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? 'Unknown Title',
      authors: (volumeInfo['authors'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          ['Unknown Author'],
      coverUrl: imageLinks['large'] ?? imageLinks['medium'] ?? imageLinks['thumbnail'],
      thumbnail: imageLinks['thumbnail'],
      description: volumeInfo['description'],
      publisher: volumeInfo['publisher'],
      publishedDate: volumeInfo['publishedDate'],
      pageCount: volumeInfo['pageCount'],
      categories: (volumeInfo['categories'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      rating: volumeInfo['averageRating']?.toDouble(),
      ratingsCount: volumeInfo['ratingsCount'],
      language: volumeInfo['language'],
      previewLink: volumeInfo['previewLink'],
      infoLink: volumeInfo['infoLink'],
      isEbook: saleInfo['isEbook'],
      price: saleInfo['listPrice']?['amount']?.toDouble(),
      currencyCode: saleInfo['listPrice']?['currencyCode'],
    );
  }

  String get authorsString => authors.join(', ');
  
  String get priceString {
    if (price == null) return 'Free';
    return '${currencyCode ?? '\$'}${price!.toStringAsFixed(2)}';
  }
}
