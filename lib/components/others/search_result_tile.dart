import 'package:flutter/material.dart';

import '../../theme/theme_data.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    super.key,
    required this.label,
    required this.confidence,
  });

  final String label;
  final double confidence;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: brandColor,
              ),
              child: const Text(
                "Search result",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            )
          ]),
        ),
        const SizedBox(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: brandColor),
            child: ListTile(
              leading: const Icon(Icons.search),
              title: Text(label),
              subtitle: Text('Confidence: $confidence'),
            ),
          ),
        ),
      ],
    );
  }
}
