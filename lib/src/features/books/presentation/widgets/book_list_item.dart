import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/book_model.dart';

class BookListItem extends StatelessWidget {
  final Book book;

  const BookListItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: SizedBox(
          width: 50,
          child: CachedNetworkImage(
            imageUrl: book.thumbnail ?? book.coverUrl ?? '',
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.book),
          ),
        ),
        title: Text(
          book.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          book.authorsString,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              book.priceString,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (book.rating != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 12, color: Colors.amber),
                  Text(book.rating!.toStringAsFixed(1)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
