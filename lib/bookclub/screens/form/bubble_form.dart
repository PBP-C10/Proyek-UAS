import 'package:flutter/material.dart';
import 'package:literatour/bookclub/models/club.dart';
import 'package:literatour/bookclub/screens/view/club_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BubbleFormPage extends StatefulWidget {
  final Club club;
  const BubbleFormPage({Key? key, required this.club}) : super(key: key);

  @override
  State<BubbleFormPage> createState() => _BubbleFormPageState();
}

class _BubbleFormPageState extends State<BubbleFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";
  String _content = "";

  Future<bool> postBubble(CookieRequest request) async {
    String clubId = widget.club.pk.toString();
    final response = await request.post(
        'https://literatour-c10-tk.pbp.cs.ui.ac.id/book-club/${clubId}/post-bubble-flutter/',
        {
          'username': _username,
          'content': _content,
        });

    return response["status"] == "success";
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Post Bubble',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClubDetailPage(
                            club: widget.club,
                          )));
            },
          )
        ],
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // TODO: Tambahkan drawer yang sudah dibuat di sini
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Username",
                  labelText: "How Would You Like to Be Called?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _username = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Username can't be empty!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Your Bubble",
                  labelText: "Post Your Thoughts",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _content = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Content can't be empty!";
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
                      postBubble(request);
                      _formKey.currentState!.reset();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClubDetailPage(
                                    club: widget.club,
                                  )));
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
