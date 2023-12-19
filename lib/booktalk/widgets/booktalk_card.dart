import 'package:flutter/material.dart';
import 'package:literatour/booktalk/screens/booktalk_form.dart';
import 'package:literatour/booktalk/screens/booktalk_menu.dart';
import 'package:literatour/booktalk/screens/booktalk_daftarReview.dart';
import 'package:literatour/booktalk/screens/booktalk_home_figma.dart';

class BookTalkCard extends StatelessWidget {
  final ShopItem item;

  const BookTalkCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          if (item.name == "Add Review") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReviewFormPage()));
          }

          if (item.name == "Lihat Review") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReviewListPage()));
          }

          if (item.name == "Figma Home") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FigmaHomePage(
                          title: 'judul buku',
                        )));
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
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
