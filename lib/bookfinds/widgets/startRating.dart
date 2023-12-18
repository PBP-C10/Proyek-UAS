import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final Color color;

  const StarRating(
      {super.key, required this.rating, this.color = Colors.yellow});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: color,
        ),
      ),
    );
  }
}
