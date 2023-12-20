import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literatour/bookfinds/models/bookrequest.dart';
import 'package:literatour/bookfinds/screens/bookRequestForm.dart';
import 'package:literatour/bookfinds/widgets/bookrequestCard.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookRequestPage extends StatefulWidget {
  const BookRequestPage({Key? key}) : super(key: key);

  @override
  _BookRequestPageState createState() => _BookRequestPageState();
}

class _BookRequestPageState extends State<BookRequestPage> {
  Future<List<BookRequest>> fetchBookRequest() async {
    final request = context.watch<CookieRequest>();
    final response =
        await request.get('http://10.0.2.2:8000/get-book-requests/');
    List<BookRequest> listBookRequest = [];
    for (var d in response) {
      if (d != null) {
        listBookRequest.add(BookRequest.fromJson(d));
      }
    }
    return listBookRequest;
  }

  void _refreshWidget() {
    setState(() {
      fetchBookRequest();
    });
  }

  Future<void> _navigateToFormPage() async {
    final refresh = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const BookRequestFormPage(),
      ),
    );

    if (refresh!) {
      _refreshWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Request',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToFormPage();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
            future: fetchBookRequest(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          "No Book Request",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.indigo),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(8.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BookRequestFormPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Request a Book",
                              style: GoogleFonts.lato(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) =>
                          BookRequestCard(snapshot.data![index]),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
