import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_clone/lib/spotify.dart';
import 'package:music_clone/widgets/custom_app_bar.dart';
import 'package:music_clone/widgets/search_bar.dart';
import 'package:music_clone/widgets/song_card.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await setupSpotify();
  runApp(const MaterialApp(
    home: MusicApp(),
  ));
}

class MusicApp extends StatefulWidget {
  const MusicApp({
    super.key,
  });

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  @override
  void initState() {
    super.initState();
    _initiate();
  }

  void _initiate() async {
    final songs = await spotify.getPopluarSongs();
    print(songs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSearchBar(),
                  const SizedBox(height: 16),
                  const Text(
                    'Songs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      childAspectRatio: 0.75,
                      crossAxisCount: 2,
                      children: [
                        SongCard(),
                        SongCard(),
                        SongCard(),
                        SongCard(),
                        SongCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0E0E10),
    );
  }
}
