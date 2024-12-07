import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:music_clone/lib/spotify.dart';
import 'package:music_clone/widgets/custom_app_bar.dart';
import 'package:music_clone/widgets/search_bar.dart';
import 'package:music_clone/widgets/song_card.dart';

import 'modules/songs/song.dart';
import 'widgets/player.dart';

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
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Song> _popularSongs = [];
  bool _isInitialized = false;
  Song? _selectedSong;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initiate();
  }

  void _initiate() async {
    final songs = await spotify.getPopluarSongs();
    setState(() {
      _popularSongs = songs;
      _isInitialized = true;
    });
  }

  void _play() {
    _audioPlayer.play(UrlSource(_selectedSong!.previewUrl!));
    setState(() {
      _isPlaying = true;
    });
  }

  void _stop() {
    _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _handleSongSelected(Song song) {
    debugPrint("you selected ${song.name}");
    if (_selectedSong == null) {
      _stop();
      return;
    }
    setState(() {
      _selectedSong = song;
    });
    _play();
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
                    child: !_isInitialized
                        ? Container()
                        : CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: LayoutGrid(
                                  columnSizes: [1.fr, 1.fr],
                                  rowSizes:
                                      List<IntrinsicContentTrackSize>.generate(
                                    (_popularSongs.length / 2).round(),
                                    (int index) => auto,
                                  ),
                                  children: _popularSongs
                                      .map((e) => SongCard(
                                          song: e, onTap: _handleSongSelected))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
              if (_selectedSong != null)
                Align(
                    alignment: Alignment.bottomCenter,
                    child: IntrinsicHeight(
                      child: Player(
                          song: _selectedSong!,
                          isPlaying: _isPlaying,
                          onButtonPressed: () => _isPlaying ? _stop : _play),
                    ))
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0E0E10),
    );
  }
}
