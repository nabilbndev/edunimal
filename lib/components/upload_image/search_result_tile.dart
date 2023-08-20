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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.outline,
              ),
              child: const Text(
                "Search result",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
              title: Text(label),
              subtitle: Text('Confidence: $confidence'),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(5.0),
          child: Text("Tap the \"Story\" button to see some magic!"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
