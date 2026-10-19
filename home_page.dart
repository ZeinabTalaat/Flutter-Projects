import 'package:flutter/material.dart';
import 'movie.dart';
import 'movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    final filteredMovies = movies.where((movie) {
      final query = _searchQuery.toLowerCase();
      return movie.title.toLowerCase().contains(query) ||
          movie.genre.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Library'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: const InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Expanded(
            child: filteredMovies.isEmpty
                ? const Center(child: Text('No movies found'))
                : _isGridView
                ? GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) =>
                  MovieCard(movie: filteredMovies[index]),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SizedBox(
                  height: 240,
                  child: MovieCard(movie: filteredMovies[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}