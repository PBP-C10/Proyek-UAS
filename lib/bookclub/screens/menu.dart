import 'package:flutter/material.dart';
import 'package:literatour/bookclub/screens/bubble_form.dart';
import 'package:literatour/bookclub/screens/club_form.dart';
import 'package:literatour/bookclub/screens/list_club.dart';

class BookClubPage extends StatelessWidget {
  final List<BookClubItem> items = [
    BookClubItem("Create Club"),
    BookClubItem("Post Bubble"),
    BookClubItem("View Club"),
  ];
  BookClubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Club',
        ),
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Book Club 🫂', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((BookClubItem item) {
                  // Iterasi untuk setiap item
                  return BookClubCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookClubItem {
  final String name;

  BookClubItem(this.name);
}

class BookClubCard extends StatelessWidget {
  final BookClubItem item;

  const BookClubCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: InkWell(
        // Area responsif terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Create Club") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BookClubFormPage()));
          } else if (item.name == "Post Bubble") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BubbleFormPage()));
          } else if (item.name == "View Club") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ClubPage()));
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
