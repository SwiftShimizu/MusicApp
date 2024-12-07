import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function(String) onSearch;
  final void Function() onEditingComplete;
  const CustomSearchBar(
      {super.key, required this.onSearch, required this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: '探したい曲を入力してください',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) => onSearch(value),
                onEditingComplete: onEditingComplete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
