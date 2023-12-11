// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:literatour/bookclub/models/bubble.dart';
import 'package:literatour/bookclub/models/club.dart';
import 'package:literatour/bookclub/screens/form/bubble_form.dart';
import 'package:literatour/bookclub/screens/recommended_book_form.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ClubDetailPage extends StatefulWidget {
  final Club club;
  const ClubDetailPage({Key? key, required this.club}) : super(key: key);

  @override
  _ClubDetailPageState createState() => _ClubDetailPageState();
}

class _ClubDetailPageState extends State<ClubDetailPage> {
  Map<String, String> bookIdToTitleMap = {};
  List<Book> books = [];
  List<Bubble> bubbles = [];
  List<Club> clubs = [];
  List<Book> recBooks = [];
  bool bookIsLoaded = false;
  bool bubbleIsLoaded = false;

  Future<bool> fetchData(CookieRequest request) async {
    await fetchBook(request);
    await fetchBubble(request);

    return true; // hard-coded bgt maaf
  }

  Future<List<Book>> fetchBook(CookieRequest request) async {
    if (!bookIsLoaded) {
      final response = await request
          .get('https://literatour-c10-tk.pbp.cs.ui.ac.id/get-books-flutter/');

      // melakukan konversi data json menjadi object Book
      // try {
      for (var d in response) {
        if (d != null) {
          // try {
          books.add(Book.fromJson(d));
          // } catch (e) {
          //   print("Error decoding a book entry: $e");
          //   // Handle or log the error, maybe skip this entry
          // }
        }
      }
      // } catch (e) {
      //   print("Bad UTF-8 encoding found: $e");
      // }

      for (var book in books) {
        bookIdToTitleMap[book.pk.toString()] = book.fields.title;
      }

      bookIsLoaded = true;
    }

    return books;
  }

  Future<List<Bubble>> fetchBubble(CookieRequest request) async {
    String clubId = widget.club.pk.toString();
    final response = await request
        .get('http://127.0.0.1:8000/book-club/${clubId}/get-bubble-flutter/');

    for (var d in response) {
      if (d != null) {
        print(d);
        bubbles.add(Bubble.fromJson(d));
      }
    }
    return bubbles;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    print(widget.club.fields.recommendedBooks);

    List<Widget> buttons = [];
    buttons.add(ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => RecommendedBookFormPage(
                        club: widget.club,
                      )));
        },
        child: const Text('Add Book Recommendation')));
    buttons.add(ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BubbleFormPage(
                        club: widget.club,
                      )));
        },
        child: const Text('Post Bubble')));

    return Scaffold(
        appBar: AppBar(
          title: Text('Club Page - ${widget.club.fields.name}'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: StreamBuilder<bool>(
            stream: Stream.fromFuture(fetchData(request)),
            builder: (context, AsyncSnapshot snapshot) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.club.fields.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(widget.club.fields.description),
                    const SizedBox(height: 20),
                    Text(
                      'Recommended Books',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.club.fields.recommendedBooks
                          .map((bookId) => Text(
                                '${bookIdToTitleMap[bookId.toString()]}',
                                style: const TextStyle(fontSize: 16),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Bubbles',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: bubbles.length,
                      itemBuilder: (context, index) {
                        Bubble bubble = bubbles[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  bubble.fields.username,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${bubble.fields.timestamp}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  bubble.fields.content,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: buttons,
                    ),
                  ],
                ),
              );
            }));
  }
}
