import 'package:flutter/material.dart';
import 'package:literatour/bookclub/screens/form/club_form.dart';
import 'package:literatour/bookclub/screens/view/list_club.dart';

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
        onTap: () {
          if (item.name == "Create Club") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BookClubFormPage()));
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
