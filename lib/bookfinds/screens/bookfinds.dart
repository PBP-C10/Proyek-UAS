import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:literatour/bookfinds/screens/bookrequest.dart';
import 'package:literatour/bookfinds/widgets/bookcard.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookfindsPage extends StatefulWidget {
  const BookfindsPage({Key? key}) : super(key: key);

  @override
  _BookfindsPageState createState() => _BookfindsPageState();
}

class _BookfindsPageState extends State<BookfindsPage> {
  Future<List<Book>> fetchBook() async {
    final request = context.watch<CookieRequest>();
    final response =
        await request.get('http://10.0.2.2:8000/get-books-flutter/');
    List<Book> listBook = [];
    for (var d in response) {
      if (d != null) {
        listBook.add(Book.fromJson(d));
      }
    }
    return listBook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Finds',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookRequestPage(),
                ),
              );
            },
            child: Text(
              "Request\nBook",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: FutureBuilder(
        future: fetchBook(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.length == 0) {
              return Container(
                color: Colors.indigo,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: const EdgeInsets.all(20.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "No Book",
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
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) =>
                    BookCard(snapshot.data![index]),
              );
            }
          }
        },
      ),
    );
  }
}
