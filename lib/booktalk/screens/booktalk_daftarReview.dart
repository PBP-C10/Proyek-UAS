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
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buku yang direview: ${review.selectedBookTitle ?? "Not specified"}',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0), // Adjust the spacing as needed
                  Text(
                    'Komentar: ${review.reviewText} ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                }),
              ),
              isThreeLine: true,
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
    );
  }
}
