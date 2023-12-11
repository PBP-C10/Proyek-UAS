// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:literatour/bookclub/models/club.dart';
import 'package:literatour/bookclub/screens/bubble_form.dart';
import 'package:literatour/bookfinds/models/book.dart';

class ClubDetailPage extends StatelessWidget {
  final Club club;
  const ClubDetailPage({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];
    buttons.add(ElevatedButton(
        onPressed: () {}, child: const Text('Add Book Recommendation')));
    buttons.add(ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BubbleFormPage()));
        },
        child: const Text('Post Bubble')));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(club.fields.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(club.fields.description),
            const SizedBox(height: 20),
            Text(
              'Recommended Books',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Display recommended books
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: club.fields.recommendedBooks
                  .map((bookId) => Text(
                        // Replace with the actual book title from your data source
                        'Book Title: $bookId', // Example placeholder text
                        style: const TextStyle(fontSize: 16),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Row(
              children: buttons,
            ),
            // Text(
            //   'Bubbles:',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // // Display bubbles
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: club.fields.bubbles
            //       .map((bubble) => Text(
            //             bubble,
            //             style: const TextStyle(fontSize: 16),
            //           ))
            //       .toList(),
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Text(
            //       club.fields.name,
            //       style: const TextStyle(
            //           fontSize: 20, fontWeight: FontWeight.bold),
            //     ),
            //     const SizedBox(height: 10),
            //     Text(club.fields.description),
            //     const SizedBox(height: 20),
            //     Text(
            //       'Recommended Books:',
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //     ),
            //     // Display recommended books with thumbnail and title
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: club.fields.recommendedBooks.map((bookId) {
            //         // Find the corresponding book based on bookId
            //         final recommendedBook = books.firstWhere(
            //           (book) => book.pk == bookId,
            //           orElse: () => Book(
            //             model: Model.BOOKFINDS_BOOK,
            //             pk: -1,
            //             fields: Fields(
            //               isbn: '',
            //               title: 'Book Not Found', // Placeholder text
            //               thumbnail: '', // Placeholder image URL
            //             ),
            //           ),
            //         );

            //         return ListTile(
            //           leading: Image.network(recommendedBook.fields.thumbnail),
            //           title: Text(recommendedBook.fields.title),
            //         );
            //       }).toList(),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
