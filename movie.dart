class Movie {
  final String title;
  final String genre;
  final int year;
  final double rating;
  final String image;

  const Movie({
    required this.title,
    required this.genre,
    required this.year,
    required this.rating,
    required this.image,
  });
}

const List<Movie> movies = [
Movie(
title: 'Toy Story',
genre: 'Animation',
year: 1995,
rating: 8.3,
image: 'assets/Toy Story.jpg',
),
Movie(
title: 'Finding Nemo',
genre: 'Animation',
year: 2003,
rating: 8.2,
image: 'assets/Finding Nemo.jpg',
),
Movie(
title: 'The Lion King',
genre: 'Animation',
year: 1994,
rating: 8.5,
image: 'assets/The Lion King.jpg',
),
Movie(
title: 'Frozen',
genre: 'Animation',
year: 2013,
rating: 7.4,
image: 'assets/Frozen.jpg',
),
Movie(
title: 'Shrek',
genre: 'Animation',
year: 2001,
rating: 7.9,
image: 'assets/Shrek.jpg',
),
Movie(
title: 'Inside Out',
genre: 'Animation',
year: 2015,
rating: 8.1,
image: 'assets/Inside Out.jpg',
),
Movie(
title: 'Coco',
genre: 'Animation',
year: 2017,
rating: 8.4,
image: 'assets/Coco.jpg',
),
Movie(
title: 'Zootopia',
genre: 'Animation',
year: 2016,
rating: 8.0,
image: 'assets/Zootopia.jpg',
),
];