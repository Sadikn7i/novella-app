import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/book_model.dart';

class AdvancedBookCard extends StatelessWidget {
  final Book book;
  const AdvancedBookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: book.thumbnail ?? book.coverUrl ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                errorWidget: (context, url, error) => Container(color: Colors.grey[300], child: const Icon(Icons.book)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(book.title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black), maxLines: 2, overflow: TextOverflow.ellipsis),
                Text(book.authorsString, style: TextStyle(fontSize: 8, color: Colors.grey[600]), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
