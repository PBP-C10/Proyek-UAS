import 'package:flutter/material.dart';
import 'package:literatour/booktalk/screens/booktalk_form.dart';

class ReviewListPage extends StatelessWidget {
  const ReviewListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Review'),
        centerTitle:
            true, // If you want to center the title as in your form page
        backgroundColor:
            Colors.indigo, // Matching the color scheme of the form page
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: ReviewList.reviews.length,
        itemBuilder: (context, index) {
          final review = ReviewList.reviews[index];
          return Card(
            // Wrap each item in a Card for better styling
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                review.reviewText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .indigo, // Use a color scheme similar to your form page
                ),
              ),
              subtitle: Text(
                'Rating: ${review.rating}',
                style: TextStyle(
                    color: Colors.black54), // Subdued color for the subtitle
              ),
              isThreeLine:
                  true, // If you want to have space for an additional line of text
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              // You could also add an onTap to navigate to a detail page or similar
            ),
          );
        },
      ),
      // You might want to include a floating action button for adding new items
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReviewFormPage()),
          );
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
