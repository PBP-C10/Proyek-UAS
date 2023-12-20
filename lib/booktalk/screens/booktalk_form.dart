import 'package:flutter/material.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// TODO: Impor drawer yang sudah dibuat sebelumnya aman
// import 'package:shopping_list/widgets/left_drawer.dart';

class ReviewFormPage extends StatefulWidget {
  const ReviewFormPage({super.key});

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class Review {
  // final String name;
  final _formKey = GlobalKey<FormState>();
  int rating;
  String reviewText;
  String? selectedBookTitle;

  Review({
    //required this.name,
    required this.rating,
    required this.reviewText,
    required this.selectedBookTitle,
  });
}

class ReviewList {
  static final List<Review> _reviews = [];
  static void addReview(Review review) {
    _reviews.add(review);
  }

  static List<Review> get reviews => _reviews;
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  final _formKey = GlobalKey<FormState>();
  // String _name = "";
  Map<String, String> _bookTitleToIdMap = {};
  int _rating = 0;
  String _reviewText = "";
  String? _selectedBookTitle;
  bool isLoaded = false;
  List<Book> books = [];
  List<String> _starOptions = ['1', '2', '3', '4', '5'];

  Future<List<Book>> fetchBook(CookieRequest request) async {
    if (!isLoaded) {
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
      // }

      for (var book in books) {
        _bookTitleToIdMap[book.fields.title] = book.pk.toString();
      }

      isLoaded = true;
    }

    return books;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Add Review',
            ),
          ),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        // TODO: Tambahkan drawer yang sudah dibuat di sini aman
        // drawer: const LeftDrawer(),
        body: FutureBuilder<List<Book>>(
            future: fetchBook(request),
            builder: (context, AsyncSnapshot<List<Book>> snapshot) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Gambar besar di atas formulir
                    Image.network(
                      'https://img.freepik.com/free-photo/cheerful-teen-couple-studying-library_23-2147864096.jpg?w=900&t=st=1703077513~exp=1703078113~hmac=c3bfe49f2615b87e2ad0c82c2917b36786bea26f0d01c368d908f7fbfcb0a317', // Gantilah URL_GAMBAR dengan URL gambar yang sesuai
                      height:
                          200, // Sesuaikan tinggi gambar sesuai keinginan Anda
                      fit: BoxFit.contain,
                    ),
                    Form(
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Review Text",
                                  labelText: "Review Text",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    // TODO: Tambahkan variabel yang sesuai aman
                                    _reviewText = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Review tidak boleh kosong!";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  const Text("Rating: "),
                                  ..._starOptions.map((star) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _rating = int.parse(star);
                                        });
                                      },
                                      child: Icon(
                                        Icons.star,
                                        color: int.parse(star) <= _rating
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                    );
                                  }).toList(),
                                  _rating == 0
                                      ? const Text(
                                          " (Rating cannot be zero)",
                                          style: TextStyle(color: Colors.red),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.indigo),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ReviewList.addReview(Review(
                                        rating: _rating,
                                        reviewText: _reviewText,
                                        selectedBookTitle: _selectedBookTitle,
                                      ));
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Review berhasil tersimpan'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text('Nama: $_name'),
                                                  // TODO: Munculkan value-value lainnya
                                                  Text('Rating: $_rating'),
                                                  Text('Review: $_reviewText'),
                                                  Text(
                                                      'Book Title: $_selectedBookTitle')
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  _selectedBookTitle = null;
                                                  _formKey.currentState!
                                                      .reset();
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
                          ])),
                    ),
                  ]);
            }));
  }
}
