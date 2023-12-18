import 'package:flutter/material.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:literatour/bookfinds/screens/bookdetails.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final String bookPrice;

  const BookCard(this.book, this.bookPrice, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content:
                    Text("You have pressed the ${book.fields.title} page!")));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailPage(
                book: book,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          // padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 10,
                  child: Image(
                    image: NetworkImage(book.fields.thumbnail),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    book.fields.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    book.fields.author,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Rp$bookPrice",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
