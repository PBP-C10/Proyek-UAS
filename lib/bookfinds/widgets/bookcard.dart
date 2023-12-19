import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:literatour/bookfinds/screens/bookdetails.dart';
import 'package:literatour/bookfinds/widgets/startRating.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      book.fields.thumbnail,
                      width: 200,
                      height: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                  padding: const EdgeInsets.all(16),
                  height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.fields.title,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        book.fields.subtitle,
                        style: GoogleFonts.lato(
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                      ),
                      Text(
                        "Rp${NumberFormat('###,###').format(book.fields.price)}",
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                      ),
                      Text(
                        book.fields.author,
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 87, 87, 87),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                      ),
                      StarRating(
                        rating: double.parse(book.fields.averageRating).toInt(),
                      ),
                      Text(
                        " (${book.fields.averageRating}) | ${NumberFormat('###,###').format(book.fields.ratingsCount)} ratings",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
