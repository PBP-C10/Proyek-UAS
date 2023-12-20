import 'package:flutter/material.dart';
import 'package:literatour/bookfinds/models/book.dart';
import 'package:literatour/bookfinds/screens/bookdetails.dart';
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
    final response = await request.get(
        'https://matthew-hotmaraja-c10literatour.stndar.dev/get-books-flutter/');

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bookfinds'),
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
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
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      String bookPrice =
                          "${snapshot.data![index].fields.price ~/ 1000}.${snapshot.data![index].fields.price % 1000}";
                      return BookCard(snapshot.data![index], bookPrice);
                    },
                  );
                }
              }
            }));
  }
}
