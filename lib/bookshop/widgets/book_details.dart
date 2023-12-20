import 'package:flutter/material.dart';
import 'package:literatour/bookfinds/models/book.dart';

class BookDetails extends StatelessWidget {
  final Book book;
  final String bookPrice;
  final VoidCallback onDeletePressed;

  const BookDetails(this.book, this.bookPrice,
      {Key? key, required this.onDeletePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
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
              // Delete button
              // Delete button
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    // Tambahkan print statement untuk memeriksa apakah fungsi terpanggil
                    print('Delete button pressed');
                    onDeletePressed();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
