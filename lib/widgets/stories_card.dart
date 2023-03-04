import 'package:flutter/material.dart';

class StoriesCard extends StatelessWidget {
  const StoriesCard({required this.map, super.key});
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              map['image'],
              height: 150,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Text('Loading ...');
              },
              // width: 250,
              // alignment: Alignment.topCenter,
              // scale: sqrt1_2,
            ),
            const SizedBox(height: 6),
            Text(
              map['heading'],
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              '${map['story']}',
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
            ),
            // SizedBox(
            //   height: 8,
            // ),
          ],
        ),
      ),
    );
  }
}
