// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:literatour/bookclub/models/club.dart';
import 'package:literatour/bookclub/screens/view/club_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({Key? key}) : super(key: key);

  @override
  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  List<Club> clubs = [];

  Future<void> refreshClubs(CookieRequest request) async {
    var updatedClubs = await fetchClub(request);
    setState(() {
      clubs = updatedClubs;
    });
  }

  Future<List<Club>> fetchClub(CookieRequest request) async {
    final response = await request.get(
      'https://literatour-c10-tk.pbp.cs.ui.ac.id/book-club/get-club-flutter/',
      // 'http://127.0.0.1:8000/book-club/get-club-flutter/'
    );

    // melakukan konversi data json menjadi object Book
    List<Club> list_club = [];
    for (var d in response["clubs"]) {
      if (d != null) {
        list_club.add(Club.fromJson(d));
      }
    }

    return list_club;
  }

  Future<void> deleteClub(CookieRequest request, int clubId) async {
    await request.post(
        'https://literatour-c10-tk.pbp.cs.ui.ac.id/book-club/delete-club-flutter/$clubId/',
        '');

    refreshClubs(request);
  }

  Future<void> joinClub(CookieRequest request, int clubId) async {
    await request.post(
        'https://literatour-c10-tk.pbp.cs.ui.ac.id/book-club/join-club-flutter/$clubId/',
        '');

    refreshClubs(request);
  }

  Future<void> leaveClub(CookieRequest request, int clubId) async {
    await request.post(
        'https://literatour-c10-tk.pbp.cs.ui.ac.id/book-club/leave-club-flutter/$clubId/',
        '');

    refreshClubs(request);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Club'),
        ),
        // drawer: const LeftDrawer(),
        body: FutureBuilder<List<Club>>(
            future: fetchClub(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "No club has been created.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        Club club = snapshot.data![index];

                        List<Widget> buttons = [];

                        bool isClubOwner = snapshot.data![index].fields.isOwner;
                        bool isClubMember =
                            snapshot.data![index].fields.isMember;

                        if (isClubOwner) {
                          buttons.add(ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ClubDetailPage(club: club),
                                  ),
                                );
                              },
                              child: const Text('Show More')));
                          buttons.add(ElevatedButton(
                              onPressed: () async {
                                deleteClub(request, club.pk);
                              },
                              child: const Text('Delete')));
                        } else if (isClubMember) {
                          buttons.add(ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ClubDetailPage(club: club),
                                  ),
                                );
                              },
                              child: const Text('Show More')));
                          buttons.add(ElevatedButton(
                              onPressed: () async {
                                leaveClub(request, club.pk);
                              },
                              child: const Text('Leave')));
                        } else {
                          buttons.add(ElevatedButton(
                              onPressed: () async {
                                joinClub(request, club.pk);
                              },
                              child: const Text('Join')));
                        }

                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data![index].fields.name}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                  "${snapshot.data![index].fields.description}"),
                              const SizedBox(height: 10),
                              Row(
                                children: buttons,
                              ),
                            ],
                          ),
                        );
                      });
                }
              }
            }));
  }
}
