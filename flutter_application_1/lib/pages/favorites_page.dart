// lib/pages/favorites_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/book_model.dart';
import '../widgets/book_card.dart';
import 'book_detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Book> _favoriteBooks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteJsonList = prefs.getStringList('favoriteBooks') ?? [];
      setState(() {
        _favoriteBooks = favoriteJsonList.map((jsonString) {
          final bookMap = json.decode(jsonString) as Map<String, dynamic>;
          return Book.fromJson(bookMap);
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading favorites: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- THEME MODIFICATIONS START ---
      backgroundColor: const Color(0xFFE8E4D9), // A soft, aged paper/parchment background
      appBar: AppBar(
        title: const Text(
          'Your Cherished Reads', // More thematic title
          style: TextStyle(
            color: Color(0xFF2D4D2F), // Dark green text for contrast
            fontFamily: 'OldStandardTT', // Example: a more classic font (you'd need to add this font to your project)
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFA5B899), // A muted, vintage green
        elevation: 4, // Subtle shadow for depth
        flexibleSpace: Container( // Add a subtle gradient for a richer feel
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA5B899), Color(0xFF7E967D)], // Lighter to slightly darker green
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      // --- THEME MODIFICATIONS END ---
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteBooks.isEmpty
              ? const Center(
                  child: Text(
                    'No favorites yet. Start exploring!', // More inviting message
                    style: TextStyle(
                      color: Color(0xFF2D4D2F), // Dark green text
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.3, // Keeps height relatively small as requested
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: _favoriteBooks.length,
                  itemBuilder: (context, index) {
                    final book = _favoriteBooks[index];
                    return BookCard(
                      book: book,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailPage(book: book),
                          ),
                        );
                      },
                      // Ensure BookCard handles its internal layout for smaller sizes
                    );
                  },
                ),
    );
  }
}