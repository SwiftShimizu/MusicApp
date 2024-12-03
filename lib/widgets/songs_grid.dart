import 'package:flutter/material.dart';
import 'song_card.dart';

class SongsGrid extends StatelessWidget {
  const SongsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      children: const [
        SongCard(),
        SongCard(),
        SongCard(),
        SongCard(),
      ],
    );
  }
}
