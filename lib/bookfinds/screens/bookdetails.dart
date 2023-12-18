import 'package:flutter/material.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literatour/bookfinds/widgets/startRating.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;
  const BookDetailPage({super.key, required this.book});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.book.fields.title,
          style: GoogleFonts.lato(),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Image.network(
                      widget.book.fields.thumbnail,
                      width: double.infinity,
                      height: 430,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.fields.title,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 1,
                          ),
                        ),
                        Text(
                          widget.book.fields.subtitle,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                        ),
                        Text(
                          "Rp${widget.book.fields.price / 1000}",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                        ),
                        Row(
                          children: [
                            StarRating(
                              rating:
                                  double.parse(widget.book.fields.averageRating)
                                      .toInt(),
                            ),
                            Text(
                              " (${widget.book.fields.averageRating}) | ${widget.book.fields.ratingsCount / 1000} ratings",
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                        ),
                        Text(
                          widget.book.fields.description,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align the columns to the start (left)
                      children: [
                        Row(
                          children: [
                            Text(
                              "Details",
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Author",
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Category",
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Published Year",
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  "ISBN",
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Average Rating",
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Page Count",
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .end, // Align data to the end (right)
                              children: [
                                Text(
                                  widget.book.fields.author,
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  widget.book.fields.category.name,
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  widget.book.fields.publishedYear.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  widget.book.fields.isbn,
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  widget.book.fields.averageRating.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  widget.book.fields.numPages.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            height: 110,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  width: double.infinity, // Set the desired width
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_shopping_cart,
                    ),
                    label: const Text(
                      "Add to Cart",
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity, // Set the desired width
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_add,
                    ),
                    label: const Text(
                      "Add to Wishlist",
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
