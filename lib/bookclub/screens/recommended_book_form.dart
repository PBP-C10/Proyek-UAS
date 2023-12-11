import 'package:flutter/material.dart';
import 'package:literatour/bookclub/models/club.dart';
import 'package:literatour/bookclub/screens/club_detail.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RecommendedBookFormPage extends StatefulWidget {
  final Club club;
  const RecommendedBookFormPage({Key? key, required this.club})
      : super(key: key);

  @override
  State<RecommendedBookFormPage> createState() =>
      _RecommendedBookFormPageState();
}

class _RecommendedBookFormPageState extends State<RecommendedBookFormPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _bookTitleToIdMap = {};
  String? _selectedBookTitle;
  List<Book> books = [];
  bool isLoaded = false;

  Future<List<Book>> fetchBook(CookieRequest request) async {
    if (!isLoaded) {
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
        _bookTitleToIdMap[book.fields.title] = book.pk.toString();
      }

      isLoaded = true;
      print(_bookTitleToIdMap);
    }

    return books;
  }

  Future<void> addRecBook(CookieRequest request) async {
    String clubId = widget.club.pk.toString();
    String? selectedBookId = _selectedBookTitle != null
        ? _bookTitleToIdMap[_selectedBookTitle]
        : null;

    final response = await request.post(
        'http://127.0.0.1:8000/book-club/${clubId}/add-rec-book-flutter/', {
      'recommended_books': selectedBookId,
    });
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Book Recommendation',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // TODO: Tambahkan drawer yang sudah dibuat di sini
      body: FutureBuilder<List<Book>>(
          future: fetchBook(request),
          builder: (context, AsyncSnapshot snapshot) {
            return Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    builder: (context) => ClubDetailPage(
                                      club: widget.club,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ])));
          }),
    );
  }
}
