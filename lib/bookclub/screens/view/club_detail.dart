// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:literatour/bookclub/models/bubble.dart';
import 'package:literatour/bookclub/models/club.dart';
import 'package:literatour/bookclub/screens/form/bubble_form.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ClubDetailPage extends StatefulWidget {
  Club club;
  ClubDetailPage({Key? key, required this.club}) : super(key: key);

  @override
  _ClubDetailPageState createState() => _ClubDetailPageState();
}

class _ClubDetailPageState extends State<ClubDetailPage> {
  final _formKey = GlobalKey<FormState>();
  List<Club> clubs = [];
  List<Book> books = [];
  List<Bubble> bubbles = [];
  bool clubIsUpdated = false;
  bool bookIsLoaded = false;
  bool bubbleIsLoaded = false;
  Map<String, String> bookIdToTitleMap = {};
  Map<String, String> bookTitleToIdMap = {};
  String? _selectedBookTitle;

  Future<void> fetchData(CookieRequest request) async {
    await fetchClub(request);
    await fetchBook(request);
    await fetchBubble(request);
  }

  Future<List<Club>> fetchClub(CookieRequest request) async {
    if (!clubIsUpdated) {
      final response = await request.get(
        'https://literatour-c10-tk.pbp.cs.ui.ac.id/book-club/get-club-flutter/',
        // 'http://127.0.0.1:8000/book-club/get-club-flutter/',
      );

      // melakukan konversi data json menjadi object Book
      clubs = [];
      for (var d in response["clubs"]) {
        if (d != null) {
          Club club = Club.fromJson(d);
          clubs.add(Club.fromJson(d));

          if (club.pk == widget.club.pk) {
            widget.club = club;
          }
        }
      }
      clubIsUpdated = true;
    }

    return clubs;
  }

  Future<List<Book>> fetchBook(CookieRequest request) async {
    if (!bookIsLoaded) {
      final response = await request
          .get('https://literatour-c10-tk.pbp.cs.ui.ac.id/get-books-flutter/');
      // 'http://127.0.0.1:8000/get-books-flutter/');

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

      for (var book in books) {
        bookIdToTitleMap[book.pk.toString()] = book.fields.title;
        bookTitleToIdMap[book.fields.title] = book.pk.toString();
      }

      bookIsLoaded = true;
    }

    return books;
  }

  Future<List<Bubble>> fetchBubble(CookieRequest request) async {
    if (!bubbleIsLoaded) {
      String clubId = widget.club.pk.toString();
      final response = await request.get(
          'https://literatour-c10-tk.pbp.cs.ui.ac.id/book-club/${clubId}/get-bubble-flutter/');

      for (var d in response) {
        if (d != null) {
          bubbles.add(Bubble.fromJson(d));
        }
      }

      bubbleIsLoaded = true;
    }
    return bubbles;
  }

  Future<void> addRecBook(CookieRequest request) async {
    String clubId = widget.club.pk.toString();
    String? selectedBookId = _selectedBookTitle != null
        ? bookTitleToIdMap[_selectedBookTitle]
        : null;

    final response = await request.post(
        'https://literatour-c10-tk.pbp.cs.ui.ac.id/book-club/${clubId}/add-rec-book-flutter/',
        {
          'recommended_books': selectedBookId,
        });

    clubIsUpdated = false;
    await fetchData(request);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    List<Widget> buttons = [];
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
        body: FutureBuilder<void>(
            future: fetchData(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Padding(
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.club.fields.recommendedBooks
                              .map((recBookTitle) => Text(
                                    bookIdToTitleMap[recBookTitle.toString()]!,
                                    style: const TextStyle(fontSize: 16),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Select a Book",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            value: _selectedBookTitle,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedBookTitle = newValue;
                              });
                            },
                            items: books.map((Book book) {
                              return DropdownMenuItem<String>(
                                value: book.fields.title,
                                child: Text(book.fields.title),
                              );
                            }).toList(),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please select a book";
                              }
                              return null;
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.indigo),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  addRecBook(request);
                                  _selectedBookTitle = null;
                                  _formKey.currentState!.reset();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ClubDetailPage(club: widget.club),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Add Book Recommendation",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Bubbles',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                  )),
                );
              }
            }));
  }
}
