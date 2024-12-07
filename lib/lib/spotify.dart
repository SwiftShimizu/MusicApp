import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_clone/modules/songs/song.dart';

late SpotifyClient spotify;
Future setupSpotify() async {
  spotify = await SpotifyClient.inialize();
}

class SpotifyClient {
  late final String? token;
  static Dio dio = Dio();

  static Future<SpotifyClient> inialize() async {
    Response response =
        await Dio().post("https://accounts.spotify.com/api/token",
            data: {
              "grant_type": "client_credentials",
              "client_id": dotenv.env['SPOTIFY_CLIENT_ID'],
              "client_secret": dotenv.env['SPOTIFY_CLIENT_SECRET'],
            },
            options: Options(headers: {
              "Content-Type": "application/x-www-form-urlencoded",
            }));
    SpotifyClient spotifyClient = SpotifyClient();
    spotifyClient.token = response.data["access_token"];
    return spotifyClient;
  }

  Future<List<Song>> getPopluarSongs() async {
    Response response = await dio.get(
        "https://api.spotify.com/v1/playlists/5SLPaOxQyJ8Ne9zpmTOvSe/tracks",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    return response.data["items"].map<Song>((e) {
      final song = e["track"];
      return Song.fromJson({
        "name": song["name"],
        "artistName": song["artists"][0]["name"],
        "albumImageUrl": song["album"]["images"][0]["url"],
        "previewUrl": song["preview_url"],
      });
    }).toList();
  }

  Future<List<Song>> searchSongs(String keyword) async {
    Response response = await dio.get(
      "https://api.spotify.com/v1/search",
      queryParameters: {
        "q": keyword,
        "type": "track",
      },
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return response.data["tracks"]["items"].map<Song>((song) {
      return Song.fromJson({
        "name": song["name"],
        "artistName": song["artists"][0]["name"],
        "albumImageUrl": song["album"]["images"][0]["url"],
        "previewUrl": song["preview_url"],
      });
    }).toList();
  }
}
