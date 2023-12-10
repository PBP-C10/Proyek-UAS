import 'package:flutter/material.dart';
import 'package:literatour/bookclub/screens/menu.dart';
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
  String _name = "";
  String _description = "";
  String _bubble = "";
  String? _selectedBookTitle;

  List<Book>? _books;

  Future<List<Book>> fetchBook() async {
    final request = context.watch<CookieRequest>();
    final response = await request.get(
        'https://https://literatour-c10-tk.pbp.cs.ui.ac.id/get-books-flutter/');

    // melakukan konversi data json menjadi object Book
    List<Book> list_book = [];
    for (var d in response) {
      if (d != null) {
        list_book.add(Book.fromJson(d));
      }
    }
    return list_book;
  }

  @override
  void initState() {
    super.initState();
    // Initialize _books with your list of books (fetch from API or any source)
    _loadBooks(); // Call a function to load books asynchronously
  }

  Future<void> _loadBooks() async {
    final books =
        await fetchBook(); // Replace fetchBooks with your data fetching logic
    setState(() {
      _books = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Create Club',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // TODO: Tambahkan drawer yang sudah dibuat di sini
      body: Form(
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
                  items: _books?.map((Book book) {
                        return DropdownMenuItem<String>(
                          value: book.fields.title,
                          child: Text(book.fields.title),
                        );
                      }).toList() ??
                      [],
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
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                                  const Text('Club is successfully created!'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Club name: $_name'),
                                    Text('Description: $_description'),
                                    Text('Bubble: $_bubble'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        _formKey.currentState!.reset();
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
      ),
    );
  }
}
