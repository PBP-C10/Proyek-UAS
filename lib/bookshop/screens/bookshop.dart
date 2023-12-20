import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literatour/bookshop/models/cart.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:literatour/bookshop/screens/shoplist_form.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:literatour/bookshop/widgets/book_details.dart';

class BookShopPage extends StatefulWidget {
  const BookShopPage({Key? key}) : super(key: key);

  @override
  _BookShopPageState createState() => _BookShopPageState();
}

class _BookShopPageState extends State<BookShopPage> {
  List<Book> list_book = [];
  int totalPrice = 0;

  Future<List<Book>> fetchProduct(CookieRequest request) async {
    final response =
        await request.get('http://127.0.0.1:8000/BookShop/get-carts-flutter/');

    for (var d in response) {
      if (d != null) {
        list_book.add(Book.fromJson(d));
      }
    }

    return list_book;
  }

  Future<void> refreshPage(CookieRequest request) async {
    var updatedBooks = await fetchProduct(request);

    setState(() {
      list_book = updatedBooks;
    });
  }

  Future<void> deleteBook(CookieRequest request, int bookId) async {
    await request.get(
      'https://literatour-c10-tk.pbp.cs.ui.ac.id/BookShop/remove-book-flutter/$bookId',
    );
    refreshPage(request);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('BookShops'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartFormPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Warna latar belakang tombol
              ),
              child: const Text(
                'Create Order',
                style: TextStyle(
                  color: Colors.indigo, // Warna teks tombol
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: fetchProduct(request),
              builder: (context, AsyncSnapshot<List<Book>> snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.data!.isEmpty) {
                    return Container(
                      color: Colors.indigo,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Your shopping cart is empty",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => BookDetails(
                        snapshot.data![index],
                        "${snapshot.data![index].fields.price ~/ 1000}.${snapshot.data![index].fields.price % 1000}",
                        onDeletePressed: () {
                          // Callback function for delete button press
                          deleteBook(request, snapshot.data![index].pk);
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
