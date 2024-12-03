import 'package:flutter/material.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: const Color(0xFF2C2C2E),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.network(
                "https://i.scdn.co/image/ab67616d0000b273151dedf4ac086e6bb4dee739",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "毎日 - Every Day",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'By 米津玄師',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
