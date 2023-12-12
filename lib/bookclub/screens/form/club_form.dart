import 'package:flutter/material.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookClubFormPage extends StatefulWidget {
  const BookClubFormPage({super.key});

  @override
  State<BookClubFormPage> createState() => _BookClubFormPageState();
}

class _BookClubFormPageState extends State<BookClubFormPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _bookTitleToIdMap = {};
  String _name = "";
  String _description = "";
  String _bubble = "";
  String? _selectedBookTitle;
  List<Book> books = [];
  bool isLoaded = false;

  Future<List<Book>> fetchBook(CookieRequest request) async {
    if (!isLoaded) {
      final response = await request.get(
          // 'https://literatour-c10-tk.pbp.cs.ui.ac.id/get-books-flutter/',
          'http://127.0.0.1:8000/get-books-flutter/');

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
    }

    return books;
  }

  Future<bool> createClub(CookieRequest request) async {
    String? selectedBookId = _selectedBookTitle != null
        ? _bookTitleToIdMap[_selectedBookTitle]
        : null;

    final response = await request
        .post('http://127.0.0.1:8000/book-club/create-club-flutter/', {
      'name': _name,
      'username': 'Club Owner',
      'description': _description,
      'recommended_books': selectedBookId,
      'bubble': _bubble,
    });

    return response["status"] == "success";
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Create Club',
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        // TODO: Tambahkan drawer yang sudah dibuat di sini
        body: FutureBuilder<List<Book>>(
            future: fetchBook(request),
            builder: (context, AsyncSnapshot<List<Book>> snapshot) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Club Name",
                            labelText: "Club Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _name = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Name can't be empty!";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Description",
                            labelText: "Description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _description = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Description can't be empty!";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Your First Bubble",
                            labelText: "Your First Bubble",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _bubble = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Bubble can't be empty!";
                            }
                            return null;
                          },
                        ),
                      ),
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
                                createClub(request);
                                _selectedBookTitle = null;
                                _formKey.currentState!.reset();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
