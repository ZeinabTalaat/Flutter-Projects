import 'package:flutter/material.dart';
import 'movie.dart';

class MovieCard extends StatelessWidget {
final Movie movie;

const MovieCard({super.key, required this.movie});
Color _getRatingColor(double rating) {
if (rating >= 8.0) {
return Colors.green;
} else if (rating >= 6.0) {
return Colors.orange;
} else {
return Colors.red;
}
}
@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

return Container(
decoration: BoxDecoration(
color: theme.cardColor,
borderRadius: BorderRadius.circular(16),
boxShadow: [
BoxShadow(
color: Colors.black.withOpacity(0.08),
blurRadius: 8,
offset: const Offset(0, 4),
),
],
),
clipBehavior: Clip.antiAlias,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Expanded(
child: Stack(
fit: StackFit.expand,
children: [
Image.asset(
movie.image,
fit: BoxFit.cover,
),
Positioned(
top: 8,
left: 8,
child: Container(
padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
decoration: BoxDecoration(
color: _getRatingColor(movie.rating),
borderRadius: BorderRadius.circular(8),
),
child: Text(
movie.rating.toString(),
style: const TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 12,
),
),
),
),
Positioned(
top: 8,
right: 8,
child: Container(
padding: const EdgeInsets.all(4),
decoration: BoxDecoration(
color: Colors.black54,
borderRadius: BorderRadius.circular(20),
),
child: const Icon(
Icons.bookmark_border,
color: Colors.white,
size: 18,
),
),
),
Positioned(
bottom: 8,
left: 8,
child: Container(
padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
decoration: BoxDecoration(
color: Colors.black54,
borderRadius: BorderRadius.circular(4),
),
child: Text(
movie.year.toString(),
style: const TextStyle(
color: Colors.white,
fontSize: 11,
fontWeight: FontWeight.w500,
),
),
),
),
],
),
),
Padding(
padding: const EdgeInsets.all(10.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
movie.title,
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 14,
),
maxLines: 1,
overflow: TextOverflow.ellipsis,
),
const SizedBox(height: 2),
Text(
movie.genre,
style: const TextStyle(
color: Colors.grey,
fontSize: 12,
),
maxLines: 1,
overflow: TextOverflow.ellipsis,
),
],
),
),
],
),
);
}
}